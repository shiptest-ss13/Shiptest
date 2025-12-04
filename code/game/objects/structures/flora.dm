/obj/structure/flora
	resistance_flags = FLAMMABLE
	max_integrity = 40
	anchored = TRUE

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = -100, "acid" = 0) // 2x damage from fire
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

	/// How much fuel this provides to fires on its turf
	var/fuel_power = 4

/obj/structure/flora/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	var/turf/open/plant_turf = get_turf(src)
	if(isopenturf(plant_turf) && prob(plant_turf.flammability >= 1))
		plant_turf.ignite_turf(fuel_power + plant_turf.flammability)

/obj/structure/flora/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/weapons/slash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/fwoosh.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

//trees
/obj/structure/flora/tree
	name = "tree"
	desc = "A large tree."
	density = TRUE
	pixel_x = -16
	layer = FLY_LAYER
	var/log_amount = 10
	max_integrity = 200

	fuel_power = 1 // trees are more resistant to fire and take much longer to burn
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 0)
	hitsound_type = PROJECTILE_HITSOUND_WOOD

/obj/structure/flora/tree/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/largetransparency)

/obj/structure/flora/tree/attackby(obj/item/W, mob/user, params)
	if(log_amount && (!(flags_1 & NODECONSTRUCT_1)))
		if(W.get_sharpness() && W.force > 0)
			playsound(get_turf(src), 'sound/weapons/bladeslice.ogg', 100, FALSE, FALSE)
			user.visible_message(span_notice("[user] begins to cut down [src] with [W]."),span_notice("You begin to cut down [src] with [W]."), span_hear("You hear the sound of sawing."))
			if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
				user.visible_message(span_notice("[user] fells [src] with the [W]."),span_notice("You fell [src] with the [W]."), span_hear("You hear the sound of a tree falling."))
				playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100 , FALSE, FALSE)
				user.log_message("cut down [src] at [AREACOORD(src)]", LOG_ATTACK)
				for(var/i=1 to log_amount)
					new /obj/item/grown/log/tree(get_turf(src))
				var/obj/structure/flora/stump/S = new(loc)
				S.name = "[name] stump"
				qdel(src)
	else
		return ..()

/obj/structure/flora/stump
	name = "stump"
	desc = "This represents our promise to each other, and the universe itself, to cut down as many trees as possible." //running naked through the trees
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "tree_stump"
	density = FALSE
	pixel_x = -16
	fuel_power = 2 // it's dead
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)

	hitsound_type = PROJECTILE_HITSOUND_WOOD

/obj/structure/flora/tree/pine
	name = "pine tree"
	desc = "A coniferous pine tree."
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"
	var/list/icon_states = list("pine_1", "pine_2", "pine_3", "pine_4")

/obj/structure/flora/tree/pine/Initialize()
	. = ..()

	if(islist(icon_states) && icon_states.len)
		icon_state = pick(icon_states)

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	desc = "A wondrous decorated Christmas tree."
	icon_state = "pine_c"
	icon_states = null
	flags_1 = NODECONSTRUCT_1 //protected by the christmas spirit

/obj/structure/flora/tree/pine/xmas/presents
	icon_state = "pinepresents"
	desc = "A wondrous decorated Christmas tree. It has presents!"
	var/gift_type = /obj/item/a_gift/anything
	var/unlimited = FALSE
	var/static/list/took_presents //shared between all xmas trees

/obj/structure/flora/tree/pine/xmas/presents/Initialize()
	. = ..()
	if(!took_presents)
		took_presents = list()

/obj/structure/flora/tree/pine/xmas/presents/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!user.ckey)
		return

	if(took_presents[user.ckey] && !unlimited)
		to_chat(user, span_warning("There are no presents with your name on."))
		return
	to_chat(user, span_warning("After a bit of rummaging, you locate a gift with your name on it!"))

	if(!unlimited)
		took_presents[user.ckey] = TRUE

	var/obj/item/G = new gift_type(src)
	user.put_in_hands(G)

/obj/structure/flora/tree/pine/xmas/presents/unlimited
	desc = "A wonderous decorated Christmas tree. It has a seemly endless supply of presents!"
	unlimited = TRUE

/obj/structure/flora/tree/tall
	icon = 'icons/obj/flora/tall_trees.dmi'
	desc = "A remarkably tall tree."
	icon_state = "pine_1"

/obj/structure/flora/tree/tall/whitesands
	color = "#846996"
	icon_state = "pine_1"

/obj/structure/flora/tree/tall/whitesands/Initialize()
	. = ..()
	color = pick( "#846996", "#7b4e99", "#924fab")
	icon_state = "pine_[rand(1, 2)]"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	desc = "A dead tree. How it died, you know not."
	icon_state = "tree_1"
	fuel_power = 2 // it's dead
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)

/obj/structure/flora/tree/dead/Initialize()
	icon_state = "tree_[rand(1, 6)]"
	. = ..()

/obj/structure/flora/tree/palm
	icon = 'icons/misc/beach2.dmi'
	desc = "A tree straight from the tropics."
	icon_state = "palm1"

/obj/structure/flora/tree/palm/Initialize()
	. = ..()
	icon_state = pick("palm1","palm2")
	pixel_x = 0

/obj/structure/festivus
	name = "festivus pole"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "festivus_pole"
	desc = "During last year's Feats of Strength the Research Director was able to suplex this passing immobile rod into a planter."

/obj/structure/festivus/anchored
	name = "suplexed rod"
	desc = "A true feat of strength, almost as good as last year."
	icon_state = "anchored_rod"
	anchored = TRUE

/obj/structure/flora/tree/jungle
	name = "tree"
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree"
	desc = "It's seriously hampering your view of the jungle."
	var/randomize_icon = TRUE
	pixel_x = -48
	pixel_y = -20

/obj/structure/flora/tree/jungle/Initialize()
	. = ..()
	if(randomize_icon) //prevents varedited trees changing
		icon_state = "[icon_state][rand(1, 10)]"

/obj/structure/flora/tree/jungle/small
	pixel_y = 0
	pixel_x = -32
	icon = 'icons/obj/flora/jungletreesmall.dmi'

/obj/structure/flora/tree/jungle/small/Initialize()
	. = ..()
	if(randomize_icon) //prevents varedited trees changing
		icon_state = "[initial(icon_state)][rand(1, 6)]"

//grass
/obj/structure/flora/grass
	name = "grass"
	desc = "A patch of overgrown grass."
	icon = 'icons/obj/flora/snowflora.dmi'
	gender = PLURAL	//"this is grass" not "this is a grass"

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/Initialize()
	icon_state = "snowgrass[rand(1, 3)]bb"
	. = ..()

/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/Initialize()
	icon_state = "snowgrass[rand(1, 3)]gb"
	. = ..()

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/Initialize()
	icon_state = "snowgrassall[rand(1, 3)]"
	. = ..()


//bushes
/obj/structure/flora/bush
	name = "bush"
	desc = "Some type of shrub."
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = TRUE

/obj/structure/flora/bush/Initialize()
	icon_state = "snowbush[rand(1, 6)]"
	. = ..()

//bushes but in a pot
/obj/structure/flora/bigplant
	name = "potted plant"
	desc = "A large potted plant."
	icon = 'icons/obj/flora/bigplant.dmi'
	icon_state = "bigplant1"
	anchored = FALSE
	layer = ABOVE_MOB_LAYER
	pixel_x = -17

/obj/structure/flora/bigplant/Initialize()
	icon_state = "bigplant[rand(1, 2)]"
	. = ..()

//newbushes
/obj/structure/flora/ausbushes
	name = "bush"
	desc = "Some kind of plant."
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"

/obj/structure/flora/ausbushes/Initialize()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/Initialize()
	icon_state = "reedbush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/Initialize()
	icon_state = "leafybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/Initialize()
	icon_state = "palebush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/Initialize()
	icon_state = "stalkybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/Initialize()
	icon_state = "grassybush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/Initialize()
	icon_state = "fernybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/Initialize()
	icon_state = "sunnybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/Initialize()
	icon_state = "genericbush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/Initialize()
	icon_state = "pointybush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/Initialize()
	icon_state = "lavendergrass_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/Initialize()
	icon_state = "ywflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/Initialize()
	icon_state = "brflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/Initialize()
	icon_state = "ppflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/Initialize()
	icon_state = "sparsegrass_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/Initialize()
	icon_state = "fullgrass_[rand(1, 3)]"
	. = ..()

/obj/item/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-01"
	desc = "A little bit of nature contained in a pot."
	layer = ABOVE_MOB_LAYER
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 13
	throw_speed = 2
	throw_range = 4

/obj/item/kirbyplants/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/tactical)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=10, force_wielded=10)
	AddElement(/datum/element/beauty, 500)

/obj/item/kirbyplants/random
	icon = 'icons/obj/flora/_flora.dmi'
	icon_state = "random_plant"
	var/list/static/states

	hitsound_type = PROJECTILE_HITSOUND_STONE

/obj/item/kirbyplants/random/Initialize()
	. = ..()
	icon = 'icons/obj/flora/plants.dmi'
	if(!states)
		generate_states()
	icon_state = pick(states)

/obj/item/kirbyplants/random/proc/generate_states()
	states = list()
	for(var/i in 1 to 25)
		var/number
		if(i < 10)
			number = "0[i]"
		else
			number = "[i]"
		states += "plant-[number]"
	states += "applebush"


/obj/item/kirbyplants/dead
	name = "RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-25"

/obj/item/kirbyplants/photosynthetic
	name = "photosynthetic potted plant"
	desc = "A bioluminescent plant."
	icon_state = "plant-09"
	light_color = COLOR_BRIGHT_BLUE
	light_range = 3

/obj/item/kirbyplants/fullysynthetic
	name = "plastic potted plant"
	desc = "A fake, cheap looking, plastic tree. Perfect for people who kill every plant they touch."
	icon_state = "plant-26"
	custom_materials = (list(/datum/material/plastic = 8000))

/obj/item/kirbyplants/fullysynthetic/Initialize()
	. = ..()
	icon_state = "plant-[rand(26, 29)]"

//a rock is flora according to where the icon file is
//and now these defines

/obj/structure/flora/rock
	icon_state = "basalt1"
	base_icon_state = "basalt"
	desc = "A volcanic rock. Pioneers used to ride these babies for miles."
	icon = 'icons/obj/flora/rocks.dmi'
	resistance_flags = FIRE_PROOF
	density = TRUE
	max_integrity = 100
	var/obj/item/stack/mineResult = /obj/item/stack/ore/glass/basalt

	hitsound_type = PROJECTILE_HITSOUND_STONE

/obj/structure/flora/rock/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(1,3)]"

/obj/structure/flora/rock/attackby(obj/item/W, mob/user, params)
	if(mineResult && (!(flags_1 & NODECONSTRUCT_1)))
		if(W.tool_behaviour == TOOL_MINING)
			to_chat(user, span_notice("You start mining..."))
			if(W.use_tool(src, user, 40, volume=50))
				to_chat(user, span_notice("You finish mining the rock."))
				new mineResult(get_turf(src), 20)
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
				qdel(src)
			return
	return ..()

/obj/structure/flora/rock/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/hit_stone.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/flora/rock/pile
	icon_state = "lavarocks1"
	base_icon_state = "lavarocks"
	desc = "A pile of rocks."

//Jungle grass

/obj/structure/flora/grass/jungle
	name = "jungle grass"
	desc = "Thick alien flora."
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "grassa"


/obj/structure/flora/grass/jungle/Initialize()
	icon_state = "[icon_state][rand(1, 5)]"
	. = ..()

/obj/structure/flora/grass/jungle/b
	icon_state = "grassb"

//Jungle rocks

/obj/structure/flora/rock/jungle
	icon_state = "rock1"
	base_icon_state = "rock"
	desc = "A pile of rocks."
	icon = 'icons/obj/flora/jungleflora.dmi'
	density = FALSE

/obj/structure/flora/rock/jungle/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(1,5)]"


//Jungle bushes

/obj/structure/flora/junglebush
	name = "bush"
	desc = "A wild plant that is found in jungles."
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "busha"
	base_icon_state = "busha"

/obj/structure/flora/junglebush/Initialize()
	icon_state = "[base_icon_state][rand(1, 3)]"
	. = ..()

/obj/structure/flora/junglebush/b
	icon_state = "bushb"
	base_icon_state = "bushb"

/obj/structure/flora/junglebush/c
	icon_state = "bushc"
	base_icon_state = "bushc"

/obj/structure/flora/junglebush/large
	icon_state = "bush"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	pixel_x = -16
	pixel_y = -12
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/flora/rock/pile/largejungle
	name = "rocks"
	icon_state = "rocks"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	density = FALSE
	pixel_x = -16
	pixel_y = -16

/obj/structure/flora/rock/pile/largejungle/Initialize()
	. = ..()
	icon_state = "[initial(icon_state)][rand(1,3)]"

/obj/structure/flora/firebush
	name = "flaming bush"
	desc = "A bush being consumed by flames. Maybe it'll rise from its ashes like a phoenix?"
	icon = 'icons/obj/flora/hellflora.dmi'
	icon_state = "hell_bush"
	density = FALSE
	light_color = "#e08300"
	light_power = 2
	light_range = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/fullgrass/hell
	name = "thick hellish grass"
	desc = "A thick patch of grass tinted red."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF
	gender = PLURAL

/obj/structure/flora/ausbushes/fullgrass/hell/Initialize()
	. = ..()
	icon_state = "fullgrass_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")

/obj/structure/flora/ausbushes/sparsegrass/hell
	name = "sparse hellish grass"
	desc = "A sparse patch of grass tinted red."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF
	gender = PLURAL

/obj/structure/flora/ausbushes/sparsegrass/hell/Initialize()
	. = ..()
	icon_state = "sparsegrass_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")

/obj/structure/flora/ausbushes/grassybush/hell
	name = "crimson bush"
	desc = "A crimson bush, native to lava planets."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_color = "#c70404"
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/hell
	name = "smouldering bush"
	desc = "Some kind of orange plant that appears to be slowly burning."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 1
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/hell/Initialize()
	. = ..()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	light_color = pick("#e87800", "#780606")

/obj/structure/flora/ausbushes/fernybush/hell
	name = "hellish fern"
	desc = "Some kind of orange fern."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 1
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/fernybush/hell/Initialize()
	. = ..()
	icon_state = "fernybush_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")

/obj/structure/flora/ausbushes/genericbush/hell
	name = "hellish bush"
	desc = "A small crimson bush."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 2
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/genericbush/hell/Initialize()
	. = ..()
	icon_state = "genericbush_[rand(1, 4)]"
	light_color = pick("#e87800", "#780606")

/obj/structure/flora/ausbushes/ywflowers/hell
	name = "lavablossom"
	desc = "Some red and orange flowers. They appear to be faintly glowing."
	icon = 'icons/obj/flora/hellflora.dmi'
	light_color = "#aba507"
	light_power = 3
	light_range = 2
	resistance_flags = LAVA_PROOF
	gender = PLURAL

/obj/structure/flora/rock/lava
	name = "lavatic rock"
	desc = "A volcanic rock. Lava is gushing from it. "
	icon = 'icons/obj/flora/lavarocks.dmi'
	icon_state = "basalt1"
	base_icon_state = "basalt"
	light_color = "#ab4907"
	light_power = 3
	light_range = 2

/obj/structure/flora/rock/pile/lava
	name = "rock shards"
	desc = "Jagged shards of volcanic rock protuding from the ground."
	icon = 'icons/obj/flora/lavarocks.dmi'
	icon_state = "lavarocks1"
	base_icon_state = "lavarocks"
	gender = PLURAL

/obj/structure/flora/rock/asteroid
	name = "pebbles"
	desc = "Some small pebbles, sheared off a larger rock."
	icon_state = "asteroid0"
	base_icon_state = "asteroid"
	density = FALSE
	gender = PLURAL

/obj/structure/flora/rock/asteroid/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(0,9)]"

/obj/structure/flora/tree/dead/hell
	name = "crimson tree"
	desc = "A crimson tree with lava oozing from it, providing a slight glow."
	icon = 'icons/obj/flora/lavatrees.dmi'
	pixel_x = -16
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	light_range = 2
	light_power = 0.85
	resistance_flags = LAVA_PROOF

/obj/structure/flora/tree/dead_pine
	name = "dead pine"
	desc = "A dead pine tree, its leaves stripped away."
	icon = 'icons/obj/flora/bigtrees.dmi'
	icon_state = "med_pine_dead"
	pixel_x = -16

/obj/structure/flora/tree/dead/tall
	name = "dead tall tree"
	desc = "The last vestiges of an once majestic tree."
	icon = 'icons/obj/flora/tall_trees.dmi'
	icon_state = "tree_1"
	base_icon_state = "tree"
	pixel_x = -16
	resistance_flags = LAVA_PROOF

/obj/structure/flora/tree/dead/tall/Initialize()
	. = ..()
	icon_state = "[base_icon_state]_[rand(1,3)]"

/obj/structure/flora/tree/dead/tall/grey
	name = "petrified trunk"
	desc = "An ancient tree was carbonized in fire and ash. Only a skeleton remains."
	icon = 'icons/obj/flora/tall_trees_dead.dmi'


/obj/structure/flora/tree/cactus
	name = "maguaro cactus"
	desc = "A hardy species of modified Saguaro cacti, originating from the Sol system. Initially planted on Mars to help prevent soil erosion, it can now be found on frigid tundras across known space."
	icon = 'icons/obj/flora/bigtrees.dmi'
	icon_state = "cactus1"
	density = TRUE

/obj/structure/flora/tree/cactus/Initialize()
	. = ..()
	icon_state = "cactus[rand(1, 4)]"

/obj/structure/flora/rock/hell
	name = "rock"
	desc = "A volcanic rock, one of the few familiar things on this planet."
	icon_state = "basalt1"
	base_icon_state = "basalt"
	icon = 'icons/obj/flora/rocks.dmi'

/obj/structure/flora/rock/beach
	name = "sea stack"
	desc = "A column of rock, formed by wave erosion."
	icon_state = "basalt1"
	base_icon_state = "basalt"
	icon = 'icons/obj/flora/rocks.dmi'

/obj/structure/flora/tree/dead/barren
	name = "petrified tree"
	desc = "An ancient trunk, mummified by the passage of time. This one still has some purple to it."
	color = "#846996"
	icon = 'icons/obj/flora/barren_tree.dmi'
	icon_state = "barren_large"

/obj/structure/flora/tree/dead/barren/Initialize()
	. = ..()
	color = pick( "#846996", "#7b4e99", "#924fab")
	icon_state = "barren_large"

/obj/structure/flora/driftwood
	name = "driftwood"
	desc = "Floatsam, jetsam, all molded down in the unforgiving sea."
	icon = 'icons/obj/flora/grass-sticks.dmi'
	icon_state = "stick2"
	base_icon_state = "stick"
	density = FALSE

/obj/structure/flora/driftwood/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(1, 4)]"

/obj/structure/flora/driftlog
	name = "driftwood log"
	desc = "Better log this one in the database."
	icon = 'icons/obj/flora/grass-sticks.dmi'
	icon_state = "dry_log"
	density = FALSE

/obj/structure/flora/rock/rockplanet
	name = "russet stone"
	icon_state = "redrock1"
	base_icon_state = "redrock"
	desc = "A raised knurl of red rock."
	mineResult = /obj/item/stack/ore/glass/rockplanet

/obj/structure/flora/rock/pile/rockplanet
	name = "russet stones"
	desc = "A pile of rust-red rocks."
	icon_state = "redrocks1"
	base_icon_state = "redrocks"
	mineResult = /obj/item/stack/ore/glass/rockplanet

/obj/structure/flora/grass/rockplanet
	name = "cottongrass"
	desc= "A variety of cold-loving prarie grass. This variety seems to thrive the frigid rockworld enviroment, so long as water can be found nearby."
	icon = 'icons/obj/flora/grass-sticks.dmi'
	icon_state = "tall_grass_1"
	base_icon_state = "tall_grass"

/obj/structure/flora/grass/rockplanet/Initialize()
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 2)]"

/obj/structure/flora/grass/rockplanet/dead
	name = "dry cottongrass"
	desc= "This patch seems to have run dry on life-giving water."
	icon_state = "dry_grass_1"
	base_icon_state = "dry_grass"

// Special tree used in chapel ship
/obj/structure/flora/tree/chapel
	name = "sacred oak tree"
	icon = 'icons/obj/flora/chapeltree.dmi'
	icon_state = "churchtree"
	desc = "A true earthen oak tree imported directly from the holy soil of earth. It's radiates a spiritual warmth that calms the soul."
	pixel_x = -16
	bound_height = 64
	var/karma = 0
	var/mojorange = 4
	var/lastcycle = 0
	// Determines the karma gained/lost when feeding the tree this chem
	var/list/moralchems = list(
		/datum/reagent/water = 0.1,
		/datum/reagent/plantnutriment = 0.2,
		/datum/reagent/medicine/earthsblood = 1,
		/datum/reagent/water/holywater = 0.8,
		/datum/reagent/medicine/cryoxadone = 0.3,
		/datum/reagent/ammonia = 0.4,
		/datum/reagent/saltpetre = 0.5,
		/datum/reagent/ash = 0.2,
		/datum/reagent/diethylamine = 0.5,
		/datum/reagent/consumable/nutriment = 0.1,
		/datum/reagent/consumable/virus_food = 0.1,
		/datum/reagent/blood = -0.1,
		/datum/reagent/consumable/ethanol = -0.1,
		/datum/reagent/toxin = -0.2,
		/datum/reagent/fluorine = -0.3,
		/datum/reagent/chlorine = -0.3,
		/datum/reagent/toxin/acid = -0.3,
		/datum/reagent/toxin/acid/fluacid = -0.4,
		/datum/reagent/toxin/plantbgone = -0.5,
		/datum/reagent/napalm = -0.6,
		/datum/reagent/liquidgibs = -0.2,
		/datum/reagent/consumable/ethanol/demonsblood = -0.8,
		/datum/reagent/medicine/soulus = -0.2
	)

/obj/structure/flora/tree/chapel/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/flora/tree/chapel/process(seconds_per_tick)
	if(world.time > (lastcycle + 200))
		if(abs(karma) > 100)
			pulseKarma()
		//Clean up the air a bit
		if(isopenturf(loc))
			var/turf/open/T = src.loc
			if(T.air)
				var/co2 = T.air.get_moles(GAS_CO2)
				if(co2 > 0 && prob(50))
					var/amt = min(co2, 10)
					T.air.adjust_moles(GAS_CO2, -amt)
					T.atmos_spawn_air("o2=[amt];TEMP=293.15")
		lastcycle = world.time

/obj/structure/flora/tree/chapel/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = I
		if(!container.reagents.total_volume)
			to_chat(user, span_warning("[container] is empty!"))
			return 1
		if(!container.is_drainable())
			if(container.can_have_cap)
				to_chat(user, span_warning("[container] has a cap on!"))
			else
				to_chat(user, span_warning("You can't use [container] on [src]!"))
			return 1
		to_chat(user, span_notice("You feed [src] [container.amount_per_transfer_from_this]u from [container]..."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		var/datum/reagents/R = new /datum/reagents()
		R.my_atom = src
		container.reagents.trans_to(R, container.amount_per_transfer_from_this, transfered_by = user)
		apply_reagents(R, user)
	else if(I.get_sharpness() && I.force > 0)
		if(I.hitsound)
			playsound(get_turf(src), I.hitsound, 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to cut down [src] with [I]."),span_notice("You begin to cut down [src] with [I]."), span_hear("You hear the sound of sawing."))
		if(do_after(user, 1000/I.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
			//Regret.dm
			to_chat(user, span_danger("As you pierce the bark, a supernatural shock jolts through your body..."))
			user.log_message("attempted to cut down [src] and was smitten")
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				if(C.can_heartattack())
					C.set_heartattack(TRUE)
			else if (isliving(user))
				var/mob/living/L = user
				L.Immobilize(100, TRUE)
				L.set_timed_status_effect(100 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
				L.adjustToxLoss(66)
		return 1
	else ..()

/obj/structure/flora/tree/chapel/proc/apply_reagents(datum/reagents/S, mob/user)
	var/gainedkarma = 0
	for(var/datum/reagent/R in moralchems)
		if(S.has_reagent(R, 1))
			gainedkarma += S.get_reagent_amount(R) * moralchems[R]
	if(isliving(user))
		var/mob/living/M = user
		if(gainedkarma >= 0)
			to_chat(M, span_green("[src] fills with new life as a wave of comfort washes over you."))
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/good_tree, name)
			if(karma >= 0)
				M.adjustBruteLoss(-0.25*karma, 0)
				M.adjustFireLoss(-0.25*karma, 0)
				M.adjustToxLoss(-0.25*karma, 0)
				M.adjustCloneLoss(-0.25*karma, 0)
		else
			to_chat(M, span_danger("Colors fade from [src] as a wave of guilt crawls into your skin."))
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/bad_tree, name)
			M.adjustToxLoss(abs(karma)*0.25, 0)
	adjustKarma(gainedkarma)

/obj/structure/flora/tree/chapel/attackby_secondary(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if (istype(weapon, /obj/item/reagent_containers/syringe))
		to_chat(user, span_warning("You can't get any extract out of this plant."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return SECONDARY_ATTACK_CALL_NORMAL

/obj/structure/flora/tree/chapel/proc/update_tree()
	if(100 > karma > -100)
		name = initial(src.name)
		icon_state = initial(src.name)
		desc = initial(src.name)
	else if (karma >= 100)
		name = "hallowed oak tree"
		icon_state = "churchtree_nice"
		desc = "The sacred spirits of nature have been awoken, washing the area in a holy aura."
	else
		name = "accursed oak tree"
		icon_state = "churchtree_naughty"
		desc = "As the bark rots and the leafs turn blood red a sinister aura bleeds into the area."
	update_icon_state()

/obj/structure/flora/tree/chapel/proc/adjustKarma(x)
	var/need_update = 0
	var/newkarma = karma + x
	if(karma < 100 && newkarma >= 100)
		need_update = 1
		visible_message(span_green("[src] shifts colors as a heavenly warmth washes over the room."))
	if(karma > -100 && newkarma <= -100)
		need_update = 1
		visible_message(span_danger("As the life fades from [src] something evil seeps into the air."))
	if(abs(karma) > 100 && newkarma < 100)
		need_update = 1
	if(need_update)
		update_tree()
	karma = newkarma

/obj/structure/flora/tree/chapel/proc/pulseKarma()
	for(var/mob/living/L in range(mojorange, src))
		var/luck = rand(1, 100)
		if(karma > 100)
			if(luck > 90)
				L.reagents.add_reagent(/datum/reagent/medicine/panacea, 5)
			else if (luck > 50)
				SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/better_tree, name)
			else if (luck > 25)
				SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/good_tree, name)
			else if (luck == 1)
				adjustKarma(-10) //Nothing good lasts forever
		else
			if(luck > 90)
				L.reagents.add_reagent(/datum/reagent/toxin, 5)
			else if (luck > 50)
				SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/bad_tree, name)
			else if (luck > 25)
				SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "treekarma", /datum/mood_event/worse_tree, name)
			else if (luck == 1)
				adjustKarma(10)

/datum/mood_event/good_tree
	description = span_nicegreen("I feel closer to my soul.")
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/bad_tree
	description = span_warning("I should stop gardening.")
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/better_tree
	description = span_nicegreen("I feel blessed by the gods!")
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/worse_tree
	description = span_warning("It's like a root is digging into my heart.")
	mood_change = -6
	timeout = 5 MINUTES

// Tree used in the SRM ships.
/obj/structure/flora/tree/srm
	name = "Montagne's Oak"
	icon = 'icons/obj/flora/chapeltree.dmi'
	icon_state = "churchtree"
	desc = "A sturdy oak tree imported directly from Illestren the homeworld of the Saint-Roumain Militia. It contains a bacteria native to the planet. The soil was carfuly transfered from the same place it was planted. A apple tree branch has been grafted onto it. You could try watering it"
	pixel_x = -16
	bound_height = 64
	var/health = 0
	var/lastcycle = 0
	//Decides where the apple gets dropped
	var/apple_direction = SOUTH
	//Determines the health gained/lost when feeding the tree this chem
	var/list/healthchems = list(
		/datum/reagent/consumable/ethanol/trickwine/ash_wine = 0.8,
		/datum/reagent/water = 0.1,
		/datum/reagent/plantnutriment = 0.2,
		/datum/reagent/medicine/earthsblood = 1,
		/datum/reagent/water/holywater = 0.8,
		/datum/reagent/medicine/cryoxadone = 0.3,
		/datum/reagent/ammonia = 0.4,
		/datum/reagent/saltpetre = 0.5,
		/datum/reagent/ash = 0.2,
		/datum/reagent/diethylamine = 0.5,
		/datum/reagent/consumable/nutriment = 0.1,
		/datum/reagent/consumable/virus_food = 0.1,
		/datum/reagent/blood = -0.1,
		/datum/reagent/consumable/ethanol = -0.1,
		/datum/reagent/toxin = -0.2,
		/datum/reagent/fluorine = -0.3,
		/datum/reagent/chlorine = -0.3,
		/datum/reagent/toxin/acid = -0.3,
		/datum/reagent/toxin/acid/fluacid = -0.4,
		/datum/reagent/toxin/plantbgone = -0.5,
		/datum/reagent/napalm = -0.6,
		/datum/reagent/liquidgibs = -0.2,
		/datum/reagent/consumable/ethanol/demonsblood = -0.8,
		/datum/reagent/medicine/soulus = -0.2
	)

/obj/structure/flora/tree/srm/pine
	name = "Montagne's Conifer"
	icon = 'icons/obj/flora/tall_trees.dmi'
	icon_state = "pine_1"
	desc = "A hardy, imported conifer tree acting as the centerpiece of the garden. A branch from an Illestren apple tree has been grafted onto it, producing fruits containing bactera native to the planet; often used in recipes withheld by the Saint-Roumain Militia. You could try watering it."

/obj/structure/flora/tree/srm/Initialize()
	START_PROCESSING(SSobj, src)
	create_reagents(300, OPENCONTAINER)
	. = ..()

/obj/structure/flora/tree/srm/process(seconds_per_tick)
	if(world.time > (lastcycle + 100))
		if(reagents.total_volume > 0)
			var/gainedhealth = 0
			for(var/reagent in healthchems)
				if(reagents.has_reagent(reagent, 1))
					gainedhealth += reagents.get_reagent_amount(reagent) * healthchems[reagent]
					health += gainedhealth
					reagents.remove_reagent(reagent, reagents.get_reagent_amount(reagent))
			reagents.clear_reagents()
		if(health > 25)
			if(prob(50))
				var/obj/item/food/grown/apple/apple = new(get_step(get_turf(src), apple_direction))
				apple.name = "illestren Apple"
				apple.desc = "You can grind this for bacteria."
				apple.reagents.add_reagent(/datum/reagent/srm_bacteria, 10)
				visible_message(span_green("An [apple] falls from the tree."))
				health -= 25
		//Clean up the air a bit
		if(isopenturf(loc))
			var/turf/open/T = src.loc
			if(T.air)
				var/co2 = T.air.get_moles(GAS_CO2)
				if(co2 > 0 && prob(50))
					var/amt = min(co2, 10)
					T.air.adjust_moles(GAS_CO2, -amt)
					T.atmos_spawn_air("o2=[amt];TEMP=293.15")
		lastcycle = world.time

/obj/structure/fluff/steam_vent
	name = "steam vent"
	desc = "A outlet for steam, usually for water coming in contact with steam pipes."
	icon = 'icons/obj/structures.dmi'
	icon_state = "steamvent"
	deconstructible = FALSE
	layer = GAS_PUMP_LAYER

	var/particle_to_spawn = /particles/smoke/steam/vent
	var/obj/effect/particle_holder/part_hold

/obj/structure/fluff/steam_vent/Initialize()
	. = ..()
	part_hold = new(get_turf(src))
	part_hold.layer = EDGED_TURF_LAYER
	part_hold.particles = new particle_to_spawn()
	underlays.Cut()

/obj/structure/fluff/steam_vent/Destroy()
	. = ..()
	QDEL_NULL(part_hold)

/obj/structure/fluff/steam_vent/low
	particle_to_spawn = /particles/smoke/steam/vent/low

/obj/structure/fluff/steam_vent/high
	particle_to_spawn = /particles/smoke/steam/vent/high

/obj/effect/particle_holder
	name = ""
	anchored = TRUE
	mouse_opacity = 0

/obj/effect/particle_emitter/Initialize(mapload, time)
	. = ..()

/obj/structure/flora/rock/crystal
	icon_state = "crystal"
	base_icon_state = "crystal"
	desc = "A towering, obaque crystal. You could probably shave something off this."
	icon = 'icons/effects/32x64.dmi'
	resistance_flags = FIRE_PROOF
	density = TRUE
	max_integrity = 100
	mineResult = /obj/item/crystal_shard

	hitsound_type = PROJECTILE_HITSOUND_STONE

/obj/structure/flora/rock/crystal/Initialize()
	. = ..()
	icon_state = "[base_icon_state]"
