//rim size defines, this is passed into the string for the icon_state of both glasses and garnishes
#define RIM_SMALL "s"
#define RIM_MEDIUM "m"
#define RIM_LARGE "l"

//glass variant defines, if you're adding new glasses make sure to update these
#define SMALL_VARIANTS 6
#define MEDIUM_VARIANTS 13
#define LARGE_VARIANTS 5

//garnish layer defines, higher numbers go above low ones, add more of these if you manage to get sprites that can fit in a new part of the glass
#define GARNISH_RIM 1
#define GARNISH_CENTER 2
#define GARNISH_RIGHT 3
#define GARNISH_LEFT 4
#define GARNISH_MAX 4

//global list for reskinning
GLOBAL_LIST_EMPTY(glass_variants)

//glass that can be reskinned via alt-click, and have garnishes added to its rim
/obj/item/reagent_containers/food/drinks/modglass
	name = "malleable glass"
	desc = "Not your standard drinking glass!"
	icon = 'icons/obj/food/modglass.dmi'
	icon_state = "mglass-1-"
	fill_icon = 'icons/obj/food/modglass_fillings.dmi'
	fill_icon_thresholds = list(50,90)
	amount_per_transfer_from_this = 10
	volume = 50
	custom_materials = list(/datum/material/glass=500, /datum/material/silver=100)
	max_integrity = 30
	spillable = TRUE
	resistance_flags = ACID_PROOF
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 25
	//rim defines the size of rim the glass has, used to decide which skins are available, and which garnish sprites to use
	var/rim = RIM_MEDIUM
	//stores the number of variations this glass sprite has to select from
	var/variants = MEDIUM_VARIANTS
	//a list to be filled with the associative list containing possible skins
	var/list/glass_skins = list()
	//a list to be filled with the current garnishes placed on the glass
	var/list/garnishes = list()

/obj/item/reagent_containers/food/drinks/modglass/small
	name = "small malleable glass"
	icon_state = "sglass-1-"
	custom_materials = list(/datum/material/glass=100, /datum/material/silver=100)
	volume = 25
	rim = RIM_SMALL
	variants = SMALL_VARIANTS

/obj/item/reagent_containers/food/drinks/modglass/large
	name = "large malleable glass"
	icon_state = "lglass-1-"
	rim = RIM_LARGE
	variants = LARGE_VARIANTS

/obj/item/reagent_containers/food/drinks/modglass/Initialize()
	. = ..()
	if(variants)
		glass_skins = glass_variants_list()

//steals code from tile_reskinning.dm to cache an associative list containing possible reskins of the glass
/obj/item/reagent_containers/food/drinks/modglass/proc/glass_variants_list()
	. = GLOB.glass_variants[rim]
	if(.)
		return
	for(var/variant in 1 to variants)
		var/name_string = "[rim]glass-[variant]-"
		glass_skins[name_string] = icon('icons/obj/food/modglass.dmi', "[name_string]")
	return GLOB.glass_variants[rim] = glass_skins

//if this glass can be reskinned, open a radial menu containing the skins, and change the icon_state to whatever is chosen
/obj/item/reagent_containers/food/drinks/modglass/AltClick(mob/user)
	if(!glass_skins)
		return
	var/choice = show_radial_menu(user, src, glass_skins, radius = 48, require_near = TRUE)
	if(!choice || choice == icon_state)
		return
	icon_state = choice
	update_appearance()

//if the object is a garnish, with a valid garnish_state, and there isnt already a garnish of the same type, add it to the list at the index of its layer
/obj/item/reagent_containers/food/drinks/modglass/attackby(obj/item/garnish/garnish, mob/user, params)
	if(!istype(garnish))
		return ..()
	if(!garnish.garnish_state)
		return ..()
	if(garnishes["[garnish.garnish_layer]"])
		to_chat(user, "<span class='notice'>Theres already something on this part of the glass!</span>")
		return ..()
	garnishes["[garnish.garnish_layer]"] = garnish.garnish_state
	update_appearance()
	qdel(garnish)

//clear garnishes on wash
/obj/item/reagent_containers/food/drinks/modglass/wash(clean_types)
	garnishes = list()
	update_appearance()

/**
 * for each layer a garnish can be on, if there is a garnish in that layers index, apply a mutable appearance of its type and our rim size
 * if the garnish is a "rim" garnish, it is instead split into two halves, one drawn below all others,
 * and one above all others, allowing garnishes to be placed "inside" the glass
 */
/obj/item/reagent_containers/food/drinks/modglass/update_overlays()
	. = ..()
	var/rimtype = garnishes["1"]
	if(rimtype)
		var/mutable_appearance/rimbottom = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[rimtype]-[rim]")
		. += rimbottom
	for(var/i in 2 to GARNISH_MAX)
		var/type = garnishes["[i]"]
		if(type)
			var/mutable_appearance/garnish = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[type]-[rim]")
			. += garnish
	if(rimtype)
		var/mutable_appearance/rimtop = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[rimtype]-[rim]-top")
		. += rimtop




//garnishes, an item that if used on a modglass, will apply its garnish_state to it
/obj/item/garnish
	name = "garnish"
	desc = "you should not see this"
	icon = 'icons/obj/food/modglass_garnishes_items.dmi'
	icon_state = "rim"
	var/garnish_state = "rim"
	var/garnish_layer = GARNISH_RIM

/obj/item/garnish/Initialize(mapload, amount)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

//rim garnishes, these go on the bottom
//sprites for rim garnishes must be split into two halves, one with normal naming, the other with -top appended to it
//this will allow it to layer over things inside the glass
/obj/item/garnish/salt
	name = "salt garnish"
	desc = "Harvested from the tears of the saltiest assistant."

/obj/item/garnish/ash
	name = "ash garnish"
	desc = "But why would you do this though."
	icon_state = "drim"
	garnish_state = "drim"

/obj/item/garnish/puce
	name = "puce garnish"
	desc = "Get some puce in your drink."
	icon_state = "puce"
	garnish_state = "puce"

/obj/item/garnish/crystal
	name = "strange crystal garnish"
	desc = "I'm sure nothing could possibly go wrong."
	icon_state = "crystal"
	garnish_state = "crystal"

/obj/item/garnish/wire
	name = "stripped wire"
	desc = "This seems like a perfectly normal thing to put on your drinks."
	icon_state = "wire"
	garnish_state = "wire"

/obj/item/garnish/gold
	name = "gold trim"
	desc = "Give your drinks that first-class flair!"
	icon_state = "gold"
	garnish_state = "gold"

/obj/item/garnish/silver
	name = "silver trim"
	desc = "Give your drinks that second-class flair!"
	icon_state = "silver"
	garnish_state = "silver"

//center garnishes, none of these exist yet, but when they do, put them here

//right side garnishes, these go above the rim and center garnishes, but below all others
/obj/item/garnish/lime
	name = "lime wedge"
	desc = "A classic topping for your drink."
	icon_state = "lime"
	garnish_state = "lime"
	garnish_layer = GARNISH_RIGHT

/obj/item/garnish/lemon
	name = "lemon wedge"
	desc = "A classic topping for your drink."
	icon_state = "lemon"
	garnish_state = "lemon"
	garnish_layer = GARNISH_RIGHT

/obj/item/garnish/orange
	name = "orange wedge"
	desc = "A classic topping for your drink."
	icon_state = "orange"
	garnish_state = "orange"
	garnish_layer = GARNISH_RIGHT

/obj/item/garnish/cherry
	name = "bunch of cherries"
	desc = "A classic topping for your drink."
	icon_state = "cherry"
	garnish_state = "cherry"
	garnish_layer = GARNISH_RIGHT

//left side garnishes, these go above both the rim, center, and right side
/obj/item/garnish/olives
	name = "skewered olives"
	desc = "This would look good in a martini."
	icon_state = "olives"
	garnish_state = "olives"
	garnish_layer = GARNISH_LEFT

/obj/item/garnish/umbrellared
	name = "red drink umbrella"
	desc = "A cute little umbrella to go in your drink. This one is light red, <i>not</i> pink."
	icon_state = "umbrellared"
	garnish_state = "umbrellared"
	garnish_layer = GARNISH_LEFT

/obj/item/garnish/umbrellablue
	name = "blue drink umbrella"
	desc = "A cute little umbrella to go in your drink. This one is blue."
	icon_state = "umbrellablue"
	garnish_state = "umbrellablue"
	garnish_layer = GARNISH_LEFT

/obj/item/garnish/umbrellagreen
	name = "green drink umbrella"
	desc = "A cute little umbrella to go in your drink. This one is green."
	icon_state = "umbrellagreen"
	garnish_state = "umbrellagreen"
	garnish_layer = GARNISH_LEFT
