/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 *		Dice Pack (in a pill bottle)
 */

/*
 * First Aid Kits
 */

/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "An emergency medical aid kit."
	icon = 'icons/obj/storage.dmi'
	icon_state = "firstaid"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboardbox_pickup.ogg'
	throw_speed = 3
	throw_range = 7
	/// If the medkit starts empty or not
	var/empty = FALSE
	/// Defines damage type of the medkit. General ones stay null. Used for medibot healing bonuses
	var/damagetype_healed

/obj/item/storage/firstaid/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.use_sound = 'sound/items/storage/briefcase.ogg'

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"
	desc = "A first aid kit with the ability to heal common types of injuries."

/obj/item/storage/firstaid/regular/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/healthanalyzer = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/firstaid/medical
	name = "medical aid kit"
	icon_state = "firstaid_surgery"
	item_state = "firstaid"
	desc = "A generic medical aid kit for treating a myriad of wounds."

/obj/item/storage/firstaid/medical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL //holds the same equipment as a medibelt
	STR.max_items = 12
	STR.max_combined_w_class = 24
	STR.set_holdable(list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/hypospray,
		/obj/item/sensor_device,
		/obj/item/radio,
		/obj/item/clothing/gloves/,
		/obj/item/lazarus_injector,
		/obj/item/bikehorn/rubberducky,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/bonesetter,
		/obj/item/surgicaldrill,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/geiger_counter,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/stamp,
		/obj/item/clothing/glasses,
		/obj/item/wrench/medical,
		/obj/item/clothing/mask/muzzle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
		/obj/item/reagent_containers/blood,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/gun/syringe/syndicate,
		/obj/item/implantcase,
		/obj/item/implant,
		/obj/item/implanter,
		/obj/item/pinpointer/crew,
		/obj/item/holosign_creator/medical,
		/obj/item/stack/sticky_tape,
		/obj/item/stack/medical/bone_gel,
	))

/obj/item/storage/firstaid/medical/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/medical/bruise_pack = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
		/obj/item/storage/pill_bottle/tramal = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/firstaid/ancient
	icon = 'icons/obj/storage.dmi'
	icon_state = "firstaid_old"
	desc = "A basic first aid kit. It looks a little old..."

/obj/item/storage/firstaid/ancient/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/bruise_pack = 3,
		/obj/item/stack/medical/ointment = 3,
	)
	generate_items_inside(items_inside,src)

//Burn kit
/obj/item/storage/firstaid/fire
	name = "burn treatment kit"
	desc = "A specialized medical kit for treating severe burns."
	icon_state = "ointment"
	item_state = "firstaid-ointment"
	damagetype_healed = BURN

/obj/item/storage/firstaid/fire/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8

/obj/item/storage/firstaid/fire/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/ointment = 1,
		/obj/item/stack/medical/mesh = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/reagent_containers/medigel/quardexane = 1,
		/obj/item/storage/pill_bottle/alvitane = 1,
		/obj/item/reagent_containers/hypospray/medipen/ysiltane = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 1,
	)
	generate_items_inside(items_inside,src)

//Toxin kit
/obj/item/storage/firstaid/toxin
	name = "toxin treatment kit"
	desc = "A specialized medical kit for treating severe blood toxins."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"
	damagetype_healed = TOX

/obj/item/storage/firstaid/toxin/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/storage/pill_bottle/charcoal/less = 1,
		/obj/item/reagent_containers/syringe/pancrazine = 3,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/gjalrazine = 1,
	)
	generate_items_inside(items_inside,src)

//Rad kit
/obj/item/storage/firstaid/radiation
	name = "radiation treatment kit"
	desc = "A specialized medical kit for treating radiation poisoning."
	icon_state = "radiation"
	item_state = "firstaid-ointment" //its yellow
	damagetype_healed = TOX

/obj/item/storage/firstaid/radiation/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8

/obj/item/storage/firstaid/radiation/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 2,
		/obj/item/reagent_containers/hypospray/medipen/anti_rad = 4
	)
	generate_items_inside(items_inside,src)

//Oxy kit
/obj/item/storage/firstaid/o2
	name = "oxygen deprivation treatment kit"
	desc = "A specialized medical kit for treating suffocation and blood loss."
	icon_state = "o2"
	item_state = "firstaid-o2"
	damagetype_healed = OXY

/obj/item/storage/firstaid/o2/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8

/obj/item/storage/firstaid/o2/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/syringe/dexalin = 3,
		/obj/item/inhaler/salbutamol = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/storage/pill_bottle/iron = 1,
		/obj/item/reagent_containers/hypospray/medipen/blood_loss = 2,
	)
	generate_items_inside(items_inside,src)

//Brute kit
/obj/item/storage/firstaid/brute
	name = "brute trauma treatment kit"
	desc = "A specialized medical kit for treating severe bruises."
	icon_state = "brute"
	item_state = "firstaid-brute"
	damagetype_healed = BRUTE

/obj/item/storage/firstaid/brute/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8

/obj/item/storage/firstaid/brute/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/medigel/hadrakine = 1,
		/obj/item/storage/pill_bottle/indomide = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/sticky_tape/surgical = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/splint = 1,
		/obj/item/reagent_containers/hypospray/medipen/silfrine = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 1,
	)
	generate_items_inside(items_inside,src)

//Advanced kit
/obj/item/storage/firstaid/advanced
	name = "advanced first aid kit"
	desc = "A specialized medical kit full of advanced medicine for treating most types of wounds."
	icon_state = "firstaid_advanced"
	item_state = "firstaid-advanced"
	custom_premium_price = 1100

/obj/item/storage/firstaid/advanced/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 11

/obj/item/storage/firstaid/advanced/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/pill/patch/synthflesh = 3,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 2,
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/ointment = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/storage/pill_bottle/penacid = 1,
		/obj/item/reagent_containers/glass/bottle/dimorlin = 1,
		/obj/item/reagent_containers/syringe = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/firstaid/roumain
	name = "Roumain first aid kit"
	desc = "A first aid kit full of natural medicine commonly used amongst the followers of the Ashen Huntsman."
	icon_state = "firstaid_srm"
	item_state = "firstaid-srm"
	custom_premium_price = 1100

/obj/item/storage/firstaid/roumain/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 13
	STR.max_combined_w_class = 26

/obj/item/storage/firstaid/roumain/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/food/grown/ash_flora/puce = 1,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle = 1,
		/obj/item/food/grown/ash_flora/cactus_fruit = 3,
		/obj/item/food/meat/slab/bear = 3,
		/obj/item/food/grown/ash_flora/mushroom_leaf = 3,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/firstaid/tactical
	name = "combat medical kit"
	desc = "A rare medical kit full of powerful tools to keep soldiers fighting."
	icon_state = "bezerk"

/obj/item/storage/firstaid/tactical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 9
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/firstaid/tactical/PopulateContents()
	if(empty)
		return
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/reagent_containers/hypospray/medipen/ysiltane(src)
	new /obj/item/reagent_containers/hypospray/medipen/ysiltane(src)
	new /obj/item/reagent_containers/hypospray/medipen/silfrine(src)
	new /obj/item/reagent_containers/hypospray/medipen/silfrine(src)
	new /obj/item/clothing/glasses/hud/health/night(src)

//medibot assembly
/obj/item/storage/firstaid/attackby(obj/item/bodypart/S, mob/user, params)
	if((!istype(S, /obj/item/bodypart/l_arm/robot)) && (!istype(S, /obj/item/bodypart/r_arm/robot)))
		return ..()

	//Making a medibot!
	if(contents.len >= 1)
		to_chat(user, span_warning("You need to empty [src] out first!"))
		return

	var/obj/item/bot_assembly/medbot/A = new
	if(istype(src, /obj/item/storage/firstaid/fire))
		A.set_skin("medibot_burn")
	else if(istype(src, /obj/item/storage/firstaid/toxin))
		A.set_skin("medibot_toxin")
	else if(istype(src, /obj/item/storage/firstaid/o2))
		A.set_skin("medibot_o2")
	else if(istype(src, /obj/item/storage/firstaid/brute))
		A.set_skin("medibot_brute")
	else if(istype(src, /obj/item/storage/firstaid/tactical))
		A.set_skin("medibot_bezerk")

	user.put_in_hands(A)
	to_chat(user, span_notice("You add [S] to [src]."))
	A.robot_arm = S.type
	A.firstaid = type
	qdel(S)
	qdel(src)

/*
 * Pill Bottles
 */

/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical/medicine.dmi'
	item_state = "pillbottle"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/pill_bottle/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.allow_quick_gather = TRUE
	STR.click_gather = TRUE
	STR.set_holdable(list(/obj/item/reagent_containers/pill, /obj/item/dice, /obj/item/paper/paperslip))
	STR.use_sound = 'sound/items/storage/pillbottle.ogg'

/obj/item/storage/pill_bottle/charcoal
	name = "bottle of charcoal pills"
	desc = "Contains pills used to counter toxins."

/obj/item/storage/pill_bottle/charcoal/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/charcoal(src)

/obj/item/storage/pill_bottle/charcoal/less

/obj/item/storage/pill_bottle/charcoal/less/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/charcoal(src)

/obj/item/storage/pill_bottle/epinephrine
	name = "bottle of epinephrine pills"
	desc = "Contains pills used to stabilize patients."

/obj/item/storage/pill_bottle/epinephrine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/epinephrine(src)

/obj/item/storage/pill_bottle/mutadone
	name = "bottle of mutadone pills"
	desc = "Contains pills used to treat genetic abnormalities."

/obj/item/storage/pill_bottle/mutadone/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mutadone(src)

/obj/item/storage/pill_bottle/potassiodide
	name = "bottle of potassium iodide pills"
	desc = "Contains pills used to reduce radiation damage."

/obj/item/storage/pill_bottle/potassiodide/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/potassiodide(src)

/obj/item/storage/pill_bottle/iron
	name = "bottle of iron pills"
	desc = "Contains pills used to reduce blood loss slowly.The tag in the bottle states 'Only take one each five minutes'."

/obj/item/storage/pill_bottle/iron/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/iron(src)

/obj/item/storage/pill_bottle/mannitol
	name = "bottle of mannitol pills"
	desc = "Contains pills used to treat brain damage."

/obj/item/storage/pill_bottle/mannitol/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mannitol(src)

/obj/item/storage/pill_bottle/stimulant
	name = "bottle of stimulant pills"
	desc = "Guaranteed to give you that extra burst of energy during a long shift!"

/obj/item/storage/pill_bottle/stimulant/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/stimulant(src)

/obj/item/storage/pill_bottle/zoom
	name = "suspicious pill bottle"
	desc = "The label is pretty old and almost unreadable, you recognize some chemical compounds."

/obj/item/storage/pill_bottle/zoom/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/zoom(src)

/obj/item/storage/pill_bottle/happy
	name = "suspicious pill bottle"
	desc = "There is a smiley on the top."

/obj/item/storage/pill_bottle/happy/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/happy(src)

/obj/item/storage/pill_bottle/lsd
	name = "suspicious pill bottle"
	desc = "There is a crude drawing which could be either a mushroom, or a deformed moon."

/obj/item/storage/pill_bottle/lsd/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/lsd(src)

/obj/item/storage/pill_bottle/aranesp
	name = "suspicious pill bottle"
	desc = "The label has 'fuck disablers' hastily scrawled in black marker."

/obj/item/storage/pill_bottle/aranesp/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/aranesp(src)

/obj/item/storage/pill_bottle/psicodine
	name = "bottle of psicodine pills"
	desc = "Contains pills used to treat mental distress and traumas."

/obj/item/storage/pill_bottle/psicodine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/psicodine(src)

/obj/item/storage/pill_bottle/penacid
	name = "bottle of pentetic acid pills"
	desc = "Contains pills to expunge radiation and toxins."

/obj/item/storage/pill_bottle/penacid/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/penacid(src)


/obj/item/storage/pill_bottle/neurine
	name = "bottle of neurine pills"
	desc = "Contains pills to treat non-severe mental traumas."

/obj/item/storage/pill_bottle/neurine/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/neurine(src)

/obj/item/storage/pill_bottle/floorpill
	name = "bottle of floorpills"
	desc = "An old pill bottle. It smells musty."

/obj/item/storage/pill_bottle/floorpill/Initialize()
	. = ..()
	var/obj/item/reagent_containers/pill/P = locate() in src
	name = "bottle of [P.name]s"

/obj/item/storage/pill_bottle/floorpill/PopulateContents()
	for(var/i in 1 to rand(1,7))
		new /obj/item/reagent_containers/pill/floorpill(src)

/obj/item/storage/pill_bottle/floorpill/full/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/floorpill(src)

/obj/item/storage/pill_bottle/indomide
	name = "bottle of indomide pills"
	desc = "Contains pills used to treat brute damage.The tag in the bottle states 'Eat before ingesting'."

/obj/item/storage/pill_bottle/indomide/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/indomide(src)

/obj/item/storage/pill_bottle/licarb
	name = "bottle of lithium carbonate pills"
	desc = "Contains pills used to stabilize mood."
	custom_price = 50

/obj/item/storage/pill_bottle/licarb/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/licarb(src)

/obj/item/storage/pill_bottle/finobranc
	name = "bottle of finobranc tablets"
	desc = "Party in the Solar Cantons, tonight."

/obj/item/storage/pill_bottle/finobranc/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/finobranc(src)

/obj/item/storage/pill_bottle/stardrop
	name = "bottle of stardrop patches"
	desc = "Contains vision-enhancing patches."
	custom_price = 300

/obj/item/storage/pill_bottle/stardrop/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/patch/stardrop(src)

/obj/item/storage/pill_bottle/starlight
	name = "bottle of starlight patches"
	desc = "Contains vision-enhancing patches."

/obj/item/storage/pill_bottle/starlight/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/patch/starlight(src)

/obj/item/storage/pill_bottle/strider
	name = "bottle of strider patches"
	desc = "Contains endurance-enhancing patches. The bottle is decorated with art of a heavily spliced human woman, galloping on 4 horse legs. A small caption reads \"GALLOP ON!\""

/obj/item/storage/pill_bottle/strider/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/patch/strider(src)

/obj/item/storage/pill_bottle/placebatol
	name = "bottle of prescription pills"
	desc = "Contains pills as prescribed. A tag reads: \"NO MEDICINAL EFFECT\"."

/obj/item/storage/pill_bottle/placebatol/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/placebatol(src)

/obj/item/storage/pill_bottle/tramal
	name = "bottle of tramal pills"
	desc = "Contains tramal pills, a mild painkiller."

/obj/item/storage/pill_bottle/tramal/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/tramal(src)

/obj/item/storage/pill_bottle/alvitane
	name = "bottle of alvitane patches"
	desc = "Contains alvitane pills, for treating burn injuries."

/obj/item/storage/pill_bottle/alvitane/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/alvitane
