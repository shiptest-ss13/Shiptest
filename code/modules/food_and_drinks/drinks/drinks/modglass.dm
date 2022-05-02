//garnish layer defines
#define GARNISH_RIM 1
#define GARNISH_WEDGE 2
#define GARNISH_SKEWER 3
#define GARNISH_MAX 3

//glass that can be reskinned via alt-click, and have garnishes added to its rim
/obj/item/reagent_containers/food/drinks/modglass
	name = "malleable glass"
	desc = "Not your standard drinking glass!"
	icon = 'icons/obj/food/modglass.dmi'
	icon_state = "mglass-1-"
	fill_icon = 'icons/obj/food/modglass_fillings.dmi'
	fill_icon_thresholds = list(25,50)
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
	var/rim = "m"
	var/variants = 13
	var/list/glass_skins = list()
	var/list/garnishes = list()

/obj/item/reagent_containers/food/drinks/modglass/small
	name = "small malleable glass"
	icon_state = "sglass-1-"
	custom_materials = list(/datum/material/glass=100, /datum/material/silver=100)
	volume = 25
	rim = "s"
	variants = 6

/obj/item/reagent_containers/food/drinks/modglass/large
	name = "large malleable glass"
	icon_state = "lglass-1-"
	rim = "l"
	variants = 5

/obj/item/reagent_containers/food/drinks/modglass/Initialize()
	for(var/x in 1 to variants)
		glass_skins["[rim]glass-[x]-"] += icon('icons/obj/food/modglass.dmi', "[rim]glass-[x]-")
	return ..()


/obj/item/reagent_containers/food/drinks/modglass/AltClick(mob/user)
	if(!glass_skins)
		return
	var/choice = show_radial_menu(user, src, glass_skins, radius = 48, require_near = TRUE)
	if(!choice || choice == icon_state)
		return
	icon_state = choice
	update_icon()

//if the object is a garnish, with a valid garnish_state, and there isnt already a garnish of the same type, add it to the list at the index of its layer
/obj/item/reagent_containers/food/drinks/modglass/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/garnish))
		return ..()
	var/obj/item/garnish/item = I
	if(!item.garnish_state)
		return ..()
	if(garnishes.Find(item.garnish_layer))
		return ..()
	garnishes["[item.garnish_layer]"] = item.garnish_state
	update_icon()
	qdel(item)

//clear garnishes on wash
/obj/item/reagent_containers/food/drinks/modglass/wash(clean_types)
	garnishes = list()
	update_icon()

//for each layer a garnish can be on, if there is a garnish in that layers index, apply a mutable appearance of its type and our rim size
/obj/item/reagent_containers/food/drinks/modglass/update_overlays()
	. = ..()
	var/rimtype = garnishes["1"]
	if(rimtype)
		var/mutable_appearance/rimbottom = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[rimtype]-[rim]")
		. += rimbottom
	for(var/x in 2 to GARNISH_MAX)
		var/type = garnishes["[x]"]
		if(!type)
			break
		var/mutable_appearance/garnish = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[type]-[rim]")
		. += garnish
	if(rimtype)
		var/mutable_appearance/rimtop = mutable_appearance('icons/obj/food/modglass_garnishes.dmi', "[rimtype]-[rim]-top")
		. += rimtop




//garnishes, an item that if used on a modglass, will apply its garnish_state to it

//rim garnishes, these go on the bottom
//sprites for rim garnishes must be split into two halves, one with normal naming, the other with -top appended to it
//this will allow it to layer over things inside the glass
/obj/item/garnish
	name = "garnish"
	desc = "you should not see this"
	icon = 'icons/obj/food/modglass_garnishes_items.dmi'
	icon_state = "rim"
	var/garnish_state = "rim"
	var/garnish_layer = GARNISH_RIM

/obj/item/garnish/salt
	name = "salt garnish"
	desc = "Harvested from the tears of the saltiest assistant."
	icon_state = "rim"
	garnish_state = "rim"
	garnish_layer = GARNISH_RIM

/obj/item/garnish/ash
	name = "ash garnish"
	desc = "But why would you do this though."
	icon_state = "drim"
	garnish_state = "drim"
	garnish_layer = GARNISH_RIM

/obj/item/garnish/puce
	name = "puce garnish"
	desc = "Get some puce in your drink."
	icon_state = "puce"
	garnish_state = "puce"
	garnish_layer = GARNISH_RIM

/obj/item/garnish/crystal
	name = "strange crystal garnish"
	desc = "I'm sure nothing could possibly go wrong."
	icon_state = "crystal"
	garnish_state = "crystal"
	garnish_layer = GARNISH_RIM

/obj/item/garnish/wire
	name = "stripped wire"
	desc = "This seems like a perfectly normal thing to put on your drinks."
	icon_state = "wire"
	garnish_state = "wire"
	garnish_layer = GARNISH_RIM

//wedge garnishes, these go above the rim, but below other objects
/obj/item/garnish/lime
	name = "lime wedge"
	desc = "A classic topping for your drink."
	icon_state = "lime"
	garnish_state = "lime"
	garnish_layer = GARNISH_WEDGE

/obj/item/garnish/lemon
	name = "lemon wedge"
	desc = "A classic topping for your drink."
	icon_state = "lemon"
	garnish_state = "lemon"
	garnish_layer = GARNISH_WEDGE

/obj/item/garnish/orange
	name = "orange wedge"
	desc = "A classic topping for your drink."
	icon_state = "orange"
	garnish_state = "orange"
	garnish_layer = GARNISH_WEDGE

//skewered garnishes, these go above both the rim and wedges
/obj/item/garnish/olives
	name = "skewered olives"
	desc = "This would look good in a martini."
	icon_state = "olives"
	garnish_state = "olives"
	garnish_layer = GARNISH_SKEWER
