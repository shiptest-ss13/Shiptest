/datum/mission/acquire
	desc = "Get me some things."

	/// The type of container to be spawned when the mission is accepted.
	var/atom/movable/container_type
	/// Instance of the container, spawned after the mission is accepted.
	var/atom/movable/container

	var/atom/movable/objective_type
	var/num_wanted = 1
	var/allow_subtypes = TRUE
	var/count_stacks = TRUE

/datum/mission/acquire/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	container = spawn_bound(container_type, accept_loc, VARSET_CALLBACK(src, container, null))

/datum/mission/acquire/Destroy()
	container = null
	return ..()

/datum/mission/acquire/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/cont_port = SSshuttle.get_containing_shuttle(container)
	return . && (current_num() >= num_wanted) && (cont_port?.current_ship == servant)

/datum/mission/acquire/get_progress_string()
	return "[current_num()]/[num_wanted]"

/datum/mission/acquire/turn_in()
	del_container()
	return ..()

/datum/mission/acquire/give_up()
	del_container()
	return ..()

/datum/mission/acquire/proc/current_num()
	if(!container)
		return 0
	var/num = 0
	for(var/target in container.contents)
		num += atom_effective_count(target)
		if(num >= num_wanted)
			return num
	return num

/datum/mission/acquire/proc/atom_effective_count(atom/movable/target)
	if(allow_subtypes ? !istype(target, objective_type) : target.type != objective_type)
		return 0
	if(count_stacks && istype(target, /obj/item/stack))
		var/obj/item/stack/target_stack = target
		return target_stack.amount
	return 1

/datum/mission/acquire/proc/del_container()
	var/turf/cont_loc = get_turf(container)
	for(var/atom/movable/target in container.contents)
		if(atom_effective_count(target))
			qdel(target)
		else
			target.forceMove(cont_loc)
	recall_bound(container)

/*
	Acquire: True Love
*/

/datum/mission/acquire/true_love
	name = "Diamond needed (urgent!!)"
	weight = 3
	value = 700
	duration = 20 MINUTES
	dur_mod_range = 0.2
	container_type = /obj/item/storage/box/true_love
	objective_type = /obj/item/stack/sheet/mineral/diamond
	num_wanted = 1

/datum/mission/acquire/true_love/New(...)
	var/datum/species/beloved = pick(subtypesof(/datum/species))

	desc = "I was going to gift \a [initial(objective_type.name)] to my [pick("beautiful", "handsome", "lovely")] \
			[initial(beloved.name)] [pick("boyfriend", "girlfriend", "lover", "SO", "spouse", "husband", "wife", "boywife")], \
			but I just lost it! Could you please find me a replacement? I don't have long!"
	. = ..()

/datum/mission/acquire/true_love/puce
	name = "Puce crystal needed (urgent!!)"
	weight = 1
	objective_type = /obj/item/reagent_containers/food/snacks/grown/ash_flora/puce

/datum/mission/acquire/true_love/fireblossom
	name = "Fireblossom needed (urgent!!)"
	weight = 1
	objective_type = /obj/item/reagent_containers/food/snacks/grown/ash_flora/fireblossom

/datum/mission/acquire/true_love/icepepper
	name = "Icepepper needed (urgent!!)"
	weight = 1
	objective_type = /obj/item/reagent_containers/food/snacks/grown/icepepper

/datum/mission/acquire/true_love/strange_crystal
	name = "Strange crystal needed (urgent!!!)"
	value = 1000
	weight = 1
	objective_type = /obj/item/strange_crystal

/*
Acquire: Anomaly
*/

/datum/mission/acquire/anomaly
	name = "Anomaly core requested"
	weight = 8
	value = 3000
	duration = 40 MINUTES
	dur_mod_range = 0.2
	container_type = /obj/item/storage/box/anomaly
	objective_type = /obj/item/assembly/signaler/anomaly
	num_wanted = 1

/datum/mission/acquire/anomaly/New(...)
	var/group = pick(list(
		"Cybersun Industries",
		"CMM-GOLD",
		"Nanotrasen Anomalous Studies Division",
		"The Naturalienwissenschaftlicher Studentenverbindungs-Verband",
		"The Central Solarian Anomaly Research Agency",
		"DeForest Medical R&D",
		"A strange lizard on the outpost"
	))

	desc = "[group] has requested that a ship [pick(list("procure", "grab", "acquire", "find", "locate"))] \
	an anomaly core for [pick(list("research", "analysis", "technical development", "closer inspection", "some reason"))]. \
	They've offered to pay well, so we're relaying this mission to you"
	. = ..()




/*
		Acquire: The Creature
*/

/datum/mission/acquire/creature
	name = "Capture a goliath"
	desc = "I require a live goliath for research purposes. Trap one within the given \
			Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1500
	duration = 30 MINUTES
	weight = 6
	container_type = /obj/structure/closet/mob_capture
	objective_type = /mob/living/simple_animal/hostile/asteroid/goliath
	num_wanted = 1
	count_stacks = FALSE

/datum/mission/acquire/creature/atom_effective_count(atom/movable/target)
	. = ..()
	if(!.)
		return
	var/mob/creature = target
	if(creature.stat == DEAD)
		return 0

/datum/mission/acquire/creature/legion
	name = "Capture a legion"
	desc = "I require a live legion for research purposes. Trap one within the given \
			Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1300
	objective_type = /mob/living/simple_animal/hostile/asteroid/hivelord/legion

/datum/mission/acquire/creature/ice_whelp
	name = "Capture an ice whelp"
	desc = "I require a live ice whelp for research purposes. Trap one within the given \
			Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1700
	weight = 2
	objective_type = /mob/living/simple_animal/hostile/asteroid/ice_whelp

/datum/mission/acquire/creature/ice_demon
	name = "Capture an ice demon"
	desc = "I require a live ice demon for research purposes. Trap one within the given \
			Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1500
	weight = 2
	objective_type = /mob/living/simple_animal/hostile/asteroid/ice_demon

/datum/mission/acquire/creature/migo
	name = "Capture a live mi-go"
	desc = "I require a live mi-go for research purposes. Trap one within the given \
			Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1050
	weight = 2
	objective_type = /mob/living/simple_animal/hostile/netherworld/migo/asteroid

/datum/mission/acquire/creature/floorbot
	name = "Detain a malfunctioning floorbot"
	desc = "I require a functional abandoned floorbot for \"research\" purposes. Trap one within \
			the given Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1450
	weight = 1
	objective_type = /mob/living/simple_animal/bot/floorbot/rockplanet

/datum/mission/acquire/creature/firebot
	name = "Detain a malfunctioning firebot"
	desc = "I require a functional abandoned firebot for \"research\" purposes. Trap one within \
			the given Lifeform Containment Unit and return it to me and you will be paid handsomely."
	value = 1450
	weight = 1
	objective_type = /mob/living/simple_animal/bot/firebot/rockplanet

/*
		Acquire: Fishing
*/

/datum/mission/acquire/aquarium
	name = "Fish needed for my aquarium"
	weight = 6
	value = 750
	duration = 60 MINUTES
	val_mod_range = 0.2
	container_type = /obj/item/storage/fish_case/mission

/datum/mission/acquire/aquarium/New(...)
	objective_type = pick(/obj/item/fish/clownfish,
						/obj/item/fish/pufferfish,
						/obj/item/fish/cardinal,
						/obj/item/fish/greenchromis,
						/obj/item/fish/trout,
						/obj/item/fish/salmon,
						/obj/item/fish/dwarf_moonfish,
						/obj/item/fish/gunner_jellyfish,
						/obj/item/fish/plasmatetra,
						/obj/item/fish/catfish,
						/obj/item/fish/bass,
						/obj/item/fish/armorfish,
						/obj/item/fish/needlefish)
	desc = "My aquarium is sorely lacking in [initial(objective_type.name)], can you please bring one to me? \
			Don't worry about if it's alive or dead, I have methods."
	. = ..()

/datum/mission/acquire/aquarium/rare
	name = "Rare fish needed for my aquarium!"
	weight = 1
	value = 1500
	val_mod_range = 0.3

/datum/mission/acquire/aquarium/rare/New(...)
	. = ..()
	objective_type = pick(/obj/item/fish/lanternfish,
						/obj/item/fish/firefish,
						/obj/item/fish/donkfish)
	desc = "I seek to make my beloved aquarium truly spectacular, and to do this I need only the finest fish! \
			Bring me a [initial(objective_type.name)] and I will reward you handsomely."

/datum/mission/acquire/aquarium/sabatoge
	name = "That bastard has had it good for too long!"
	weight = 1
	value = 3000
	duration = 100 MINUTES

/datum/mission/acquire/aquarium/sabatoge/New(...)
	. = ..()
	desc = "My arch-nemesis [pick("Rutherford","Baldwin","Anderson","Percival")] thinks his aquarium is so much better than mine, I'll show him! \
			Bring me an emulsijack, and make sure it's alive!"
	objective_type = pick(/obj/item/fish/emulsijack)

/datum/mission/acquire/fish_cook
	name = "Fish needed for my meal"
	weight = 3
	duration = 40 MINUTES
	val_mod_range = 0.2
	objective_type = /obj/item/fish
	container_type = /obj/item/storage/fish_case/mission/big

/datum/mission/acquire/fish_cook/New(...)
	num_wanted = rand(1,3)
	desc = "I am a chef in need of [num_wanted] fish for my latest dish. Any fish will do, just make sure they're not filleted!"
	value = (250*num_wanted)
	. = ..()

/datum/mission/acquire/fish/alive/atom_effective_count(atom/movable/target)
	. = ..()
	if(!.)
		return
	var/mob/creature = target
	if(creature.stat == DEAD)
		return 0

/*
		Acquiry mission containers
*/

/obj/structure/closet/mob_capture
	name = "\improper Lifeform Containment Unit"
	desc = "A large closet-like container, used to capture hostile lifeforms for retrieval and analysis. The interior is heavily armored, preventing animals from breaking out while inside."
	icon_state = "abductor"
	icon_door = "abductor"
	color = "#FF88FF"
	drag_slowdown = 1
	max_integrity = 300
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 30, "fire" = 80, "acid" = 70)
	mob_storage_capacity = 1
	max_mob_size = MOB_SIZE_LARGE
	anchorable = FALSE
	can_weld_shut = FALSE

/obj/structure/closet/mob_capture/attack_animal(mob/living/simple_animal/M)
	if(M.loc == src)
		return FALSE
	return ..()

/obj/item/storage/box/true_love
	name = "gift box"
	desc = "A cardboard box covered in gift wrap. Looks like it was wrapped in a hurry."
	icon_state = "giftdeliverypackage3"
	item_state = "gift"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	foldable = null

/obj/item/storage/box/true_love/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = WEIGHT_CLASS_NORMAL
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 1

/obj/item/storage/fish_case/mission
	name = "fish delivery case"
	desc = "A stasis case that keeps fish alive during transportation, or at least stops them from becoming more dead."

/obj/item/storage/fish_case/mission/big
	name = "large fish delivery case"
	desc = "A specialized container for the delivering of large quatities of fish. Guarantees they stay fresh during delivery!."

/obj/item/storage/fish_case/mission/big/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 3

/obj/item/storage/box/anomaly
	name = "anomaly case"
	desc = "A metallic box made to store anomaly cores. They aren't always the safest to lug around."
	icon = 'icons/obj/nuke_tools.dmi'
	icon_state = "core_container_sealed" //it'd be neat if I could figure out how to make this seal but that's a problem for me in 6 months
	item_state = "tile"
	lefthand_file = 'icons/mob/inhands/misc/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/tiles_righthand.dmi'
	foldable = null

/obj/item/storage/box/anomaly/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = WEIGHT_CLASS_NORMAL
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 1
