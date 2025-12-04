/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *		Action Figure Boxes
 *		Various paper bags.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon_state = "box"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboardbox_pickup.ogg'
	var/foldable = /obj/item/stack/sheet/cardboard
	var/illustration = "writing"

/obj/item/storage/box/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/storage/box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT
	STR.max_volume = STORAGE_VOLUME_CONTAINER_S
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.use_sound = 'sound/items/storage/briefcase.ogg'

/obj/item/storage/box/update_overlays()
	. = ..()
	if(illustration)
		. += illustration

/obj/item/storage/box/attack_self(mob/user)
	..()

	if(!foldable)
		return
	if(contents.len)
		to_chat(user, span_warning("You can't fold this box with items still inside!"))
		return
	if(!ispath(foldable))
		return

	to_chat(user, span_notice("You fold [src] flat."))
	var/obj/item/I = new foldable
	qdel(src)
	user.put_in_hands(I)

/obj/item/storage/box/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/packageWrap))
		return 0
	return ..()

//Disk boxes

/obj/item/storage/box/disks
	name = "diskette box"
	illustration = "disk_kit"

/obj/item/storage/box/disks/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/data(src)

/obj/item/storage/box/holodisc
	name = "holodisc box"
	illustration = "disk_kit"

/obj/item/storage/box/holodisc/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/holodisk(src)

//guys why are my tests failing
/obj/item/storage/box/disks_plantgene
	name = "plant data disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_plantgene/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/plantgene(src)

/obj/item/storage/box/disks_nanite
	name = "nanite program disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_nanite/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/nanite_program(src)

// Ordinary survival box
/obj/item/storage/box/survival
	var/mask_type = /obj/item/clothing/mask/breath
	var/internal_type = /obj/item/tank/internals/emergency_oxygen
	var/medipen_type = /obj/item/reagent_containers/hypospray/medipen
	var/radio_type = /obj/item/radio

/obj/item/storage/box/survival/PopulateContents()
	if(!isnull(mask_type))
		new mask_type(src)

	if(!isnull(radio_type))
		new radio_type(src)

	if(!isnull(medipen_type))
		new medipen_type(src)

	if(!isplasmaman(loc))
		new internal_type(src)
	else
		new /obj/item/tank/internals/plasmaman/belt(src)

// Mining survival box
/obj/item/storage/box/survival/mining
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/item/storage/box/survival/mining/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)

// Engineer survival box
/obj/item/storage/box/survival/engineer
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

// Syndie survival box
/obj/item/storage/box/survival/syndie
	mask_type = /obj/item/clothing/mask/gas/syndicate
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi
	medipen_type = null

// Security survival box
/obj/item/storage/box/survival/security
	mask_type = /obj/item/clothing/mask/gas

// Medical survival box
/obj/item/storage/box/survival/medical
	mask_type = /obj/item/clothing/mask/breath/medical

/obj/item/storage/box/survival/clip
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi //clip actually cares about their personnel

/obj/item/storage/box/survival/clip/minutemen
	mask_type = /obj/item/clothing/mask/balaclava/combat
	internal_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/item/storage/box/survival/pgf
	mask_type = /obj/item/clothing/mask/breath/pgfmask
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/inteq
	mask_type = /obj/item/clothing/mask/balaclava/inteq
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/frontier
	mask_type = null // we spawn in gas masks in frontiersmen bags alongside this, so it isn't nessary
	internal_type = /obj/item/tank/internals/emergency_oxygen //frontiersmen dont

/obj/item/storage/box/survival/vi
	mask_type = /obj/item/clothing/mask/gas/vigilitas
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains sterile latex gloves."
	illustration = "latex"

/obj/item/storage/box/gloves/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains sterile medical masks."
	illustration = "sterile"

/obj/item/storage/box/masks/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/mask/surgical(src)

/obj/item/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	illustration = "syringe"

/obj/item/storage/box/syringes/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/syringe(src)

/obj/item/storage/box/syringes/variety
	name = "syringe variety box"

/obj/item/storage/box/syringes/variety/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/syringe/lethal(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/bluespace(src)

/obj/item/storage/box/medipens
	name = "box of medipens"
	desc = "A box full of epinephrine MediPens."
	illustration = "syringe"

/obj/item/storage/box/medipens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/hypospray/medipen(src)

/obj/item/storage/box/medipens/utility
	name = "stimpack value kit"
	desc = "A box with several stimpack medipens for the economical miner."
	illustration = "syringe"

/obj/item/storage/box/medipens/utility/PopulateContents()
	..() // includes regular medipens.
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack(src)

/obj/item/storage/box/beakers
	name = "box of beakers"
	illustration = "beaker"

/obj/item/storage/box/beakers/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/glass/beaker(src)

/obj/item/storage/box/beakers/bluespace
	name = "box of bluespace beakers"
	illustration = "beaker"

/obj/item/storage/box/beakers/bluespace/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/glass/beaker/bluespace(src)

/obj/item/storage/box/beakers/variety
	name = "beaker variety box"

/obj/item/storage/box/beakers/variety/PopulateContents()
	new /obj/item/reagent_containers/glass/beaker(src)
	new /obj/item/reagent_containers/glass/beaker/large(src)
	new /obj/item/reagent_containers/glass/beaker/plastic(src)
	new /obj/item/reagent_containers/glass/beaker/meta(src)
	new /obj/item/reagent_containers/glass/beaker/noreact(src)
	new /obj/item/reagent_containers/glass/beaker/bluespace(src)

/obj/item/storage/box/hypospray
	name = "hypospray mk. II kit"
	icon = 'icons/obj/storage.dmi'		//WS Edit - Suitcases
	icon_state = "medbriefcase"
	illustration = null

/obj/item/storage/box/hypospray/PopulateContents()
	new /obj/item/hypospray/mkii(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/indomide(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/pancrazine(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/alvitane(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/dexalin(src)

/obj/item/storage/box/hypospray/mkiii
	name = "hypospray mk. III kit"

/obj/item/storage/box/hypospray/mkiii/PopulateContents()
	new /obj/item/hypospray/mkii/mkiii(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/silfrine(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/gjalrazine(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/ysiltane(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/salbutamol(src)

/obj/item/storage/box/medigels
	name = "box of medical gels"
	desc = "A box full of medical gel applicators, with unscrewable caps and precision spray heads."
	illustration = "medgel"

/obj/item/storage/box/medigels/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/medigel(src)

/obj/item/storage/box/injectors
	name = "box of DNA injectors"
	desc = "This box contains injectors, it seems."
	illustration = "dna"

/obj/item/storage/box/injectors/PopulateContents()
	var/static/items_inside = list(
		/obj/item/dnainjector/h2m = 3,
		/obj/item/dnainjector/m2h = 3)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/smokebombs
	name = "box of smoke grenades (WARNING)"
	desc = "<B>WARNING: Do not use in enclosed areas. Protective mask must be worn when in smoke cloud.</B>"
	icon_state = "secbox"
	illustration = "smoke"

/obj/item/storage/box/smokebombs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/smokebomb(src)

/obj/item/storage/box/barriers
	name = "box of barrier grenades (WARNING)"
	desc = "<B>WARNING: Deploy barriers with care, providing ample space for automatic deployment to prevent accidental injury.</B>"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/barriers/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/barrier(src)

/obj/item/storage/box/flashbangs
	name = "box of flashbangs (WARNING)"
	desc = "<B>WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use.</B>"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/flashbangs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/flashbang(src)

/obj/item/storage/box/stingbangs
	name = "box of stingbangs (WARNING)"
	desc = "<B>WARNING: These devices are extremely dangerous and can cause severe injuries or death in repeated use.</B>"
	icon_state = "secbox"
	illustration = "flashbang"

/obj/item/storage/box/stingbangs/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/stingbang(src)

/obj/item/storage/box/flashes
	name = "box of flashbulbs"
	desc = "<B>WARNING: Flashes can cause serious eye damage, protective eyewear is required.</B>"
	icon_state = "secbox"
	illustration = "flash"

/obj/item/storage/box/flashes/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/flash/handheld(src)

/obj/item/storage/box/wall_flash
	name = "wall-mounted flash kit"
	desc = "This box contains everything necessary to build a wall-mounted flash. <B>WARNING: Flashes can cause serious eye damage, protective eyewear is required.</B>"
	icon_state = "secbox"
	illustration = "flash"

/obj/item/storage/box/wall_flash/PopulateContents()
	var/id = rand(1000, 9999)
	// FIXME what if this conflicts with an existing one?

	new /obj/item/wallframe/button(src)
	new /obj/item/electronics/airlock(src)
	var/obj/item/assembly/control/flasher/remote = new(src)
	remote.id = id
	var/obj/item/wallframe/flasher/frame = new(src)
	frame.id = id
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/screwdriver(src)


/obj/item/storage/box/teargas
	name = "box of tear gas grenades (WARNING)"
	desc = "<B>WARNING: These devices are extremely dangerous and can cause blindness and skin irritation.</B>"
	icon_state = "secbox"
	illustration = "grenade"

/obj/item/storage/box/teargas/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/chem_grenade/teargas(src)

/obj/item/storage/box/emps
	name = "box of emp grenades"
	desc = "A box with 5 emp grenades."
	illustration = "emp"

/obj/item/storage/box/emps/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/empgrenade(src)

/obj/item/storage/box/trackimp
	name = "boxed tracking implant kit"
	desc = "Box full of scum-bag tracking utensils."
	icon_state = "secbox"
	illustration = "implant"

/obj/item/storage/box/trackimp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/tracking = 4,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/minertracker
	name = "boxed tracking implant kit"
	desc = "For finding those who have died on the accursed lavaworld."
	illustration = "implant"
	custom_price = 600

/obj/item/storage/box/minertracker/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/tracking = 3,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/chemimp
	name = "boxed chemical implant kit"
	desc = "Box of stuff used to implant chemicals."
	illustration = "implant"

/obj/item/storage/box/chemimp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/chem = 5,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/exileimp
	name = "boxed exile implant kit"
	desc = "Box of exile implants. It has a picture of a clown being booted through the Gateway."
	illustration = "implant"

/obj/item/storage/box/exileimp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/exile = 5,
		/obj/item/implanter = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/bodybags
	name = "body bags"
	desc = "The label indicates that it contains body bags."
	illustration = "bodybags"

/obj/item/storage/box/bodybags/PopulateContents()
	..()
	for(var/i in 1 to 7)
		new /obj/item/bodybag(src)

/obj/item/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	illustration = "glasses"

/obj/item/storage/box/rxglasses/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/glasses/regular(src)

/obj/item/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "It has a picture of drinking glasses on it."
	illustration = "drinkglass"

/obj/item/storage/box/drinkingglasses/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/food/drinks/drinkingglass(src)

/obj/item/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."
	illustration = "condiment"

/obj/item/storage/box/condimentbottles/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/condiment(src)

/obj/item/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	illustration = "cup"

/obj/item/storage/box/cups/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/food/drinks/sillycup(src)

/obj/item/storage/box/donkpockets
	name = "box of donk-pockets"
	desc = "<B>Instructions:</B> <I>Heat in microwave. Product will cool if not eaten within seven minutes.</I>"
	icon_state = "donkpocketbox"
	illustration=null
	var/donktype = /obj/item/food/donkpocket

/obj/item/storage/box/donkpockets/PopulateContents()
	for(var/i in 1 to 6)
		new donktype(src)

/obj/item/storage/box/donkpockets/donkpocketspicy
	name = "box of spicy-flavoured donk-pockets"
	icon_state = "donkpocketboxspicy"
	donktype = /obj/item/food/donkpocket/spicy

/obj/item/storage/box/donkpockets/donkpocketteriyaki
	name = "box of teriyaki-flavoured donk-pockets"
	icon_state = "donkpocketboxteriyaki"
	donktype = /obj/item/food/donkpocket/teriyaki

/obj/item/storage/box/donkpockets/donkpocketpizza
	name = "box of pizza-flavoured donk-pockets"
	icon_state = "donkpocketboxpizza"
	donktype = /obj/item/food/donkpocket/pizza

/obj/item/storage/box/donkpockets/donkpocketberry
	name = "box of berry-flavoured donk-pockets"
	icon_state = "donkpocketboxberry"
	donktype = /obj/item/food/donkpocket/berry

/obj/item/storage/box/monkeycubes
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon_state = "monkeycubebox"
	illustration = null
	var/cube_type = /obj/item/food/monkeycube

/obj/item/storage/box/monkeycubes/PopulateContents()
	for(var/i in 1 to 5)
		new cube_type(src)

/obj/item/storage/box/ids
	name = "box of spare IDs"
	desc = "Has so many empty IDs."
	illustration = "id"

/obj/item/storage/box/ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id(src)

/obj/item/storage/box/bankcard
	name = "box of spare bank cards"
	desc = "Has so many empty bank cards."
	illustration = "id"

/obj/item/storage/box/bankcard/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/bank(src)

//Some spare PDAs in a box
/obj/item/storage/box/PDAs
	name = "spare PDAs"
	desc = "A box of spare PDA microcomputers."
	illustration = "pda"

/obj/item/storage/box/PDAs/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/pda(src)
	new /obj/item/cartridge/head(src)

	var/newcart = pick(	/obj/item/cartridge/engineering,
						/obj/item/cartridge/security,
						/obj/item/cartridge/medical,
						/obj/item/cartridge/signal/toxins,
						/obj/item/cartridge/quartermaster)
	new newcart(src)

/obj/item/storage/box/silver_ids
	name = "box of spare silver IDs"
	desc = "Shiny IDs for important people."
	illustration = "id"

/obj/item/storage/box/silver_ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/silver(src)

/obj/item/storage/box/prisoner
	name = "box of prisoner IDs"
	desc = "Take away their last shred of dignity, their name."
	icon_state = "secbox"
	illustration = "id"

/obj/item/storage/box/prisoner/PopulateContents()
	..()
	new /obj/item/card/id/prisoner/one(src)
	new /obj/item/card/id/prisoner/two(src)
	new /obj/item/card/id/prisoner/three(src)
	new /obj/item/card/id/prisoner/four(src)
	new /obj/item/card/id/prisoner/five(src)
	new /obj/item/card/id/prisoner/six(src)
	new /obj/item/card/id/prisoner/seven(src)

/obj/item/storage/box/seccarts
	name = "box of PDA security cartridges"
	desc = "A box full of PDA cartridges used by Security."
	icon_state = "secbox"
	illustration = "pda"

/obj/item/storage/box/seccarts/PopulateContents()
	new /obj/item/cartridge/detective(src)
	for(var/i in 1 to 6)
		new /obj/item/cartridge/security(src)

/obj/item/storage/box/handcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "secbox"
	illustration = "handcuff"

/obj/item/storage/box/handcuffs/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/restraints/handcuffs(src)

/obj/item/storage/box/zipties
	name = "box of spare zipties"
	desc = "A box full of zipties."
	icon_state = "secbox"
	illustration = "handcuff"

/obj/item/storage/box/zipties/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/restraints/handcuffs/cable/zipties(src)

/obj/item/storage/box/alienhandcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "alienbox"
	illustration = "handcuff"

/obj/item/storage/box/alienhandcuffs/PopulateContents()
	for(var/i in 1 to 7)
		new	/obj/item/restraints/handcuffs/alien(src)

/obj/item/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = span_alert("Keep out of reach of children.")
	illustration = "mousetrap"

/obj/item/storage/box/mousetraps/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/mousetrap(src)

/obj/item/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."
	illustration = "pillbox"

/obj/item/storage/box/pillbottles/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/storage/pill_bottle(src)

/obj/item/storage/box/snappops
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"

/obj/item/storage/box/snappops/PopulateContents()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_FILL_TYPE, /obj/item/toy/snappop)

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "A small box of Almost But Not Quite Plasma Premium Matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	item_state = "zippo"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	drop_sound = 'sound/items/handling/matchbox_drop.ogg'
	pickup_sound =  'sound/items/handling/matchbox_pickup.ogg'
	custom_price = 2

/obj/item/storage/box/matches/PopulateContents()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_FILL_TYPE, /obj/item/match)

/obj/item/storage/box/matches/attackby(obj/item/match/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/match))
		W.matchignite()

/obj/item/storage/box/matches/ComponentInitialize()
	. = ..()
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	storage.set_holdable(list(/obj/item/match, null))

/obj/item/storage/box/lights
	name = "box of replacement bulbs"
	icon = 'icons/obj/storage.dmi'
	illustration = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	foldable = /obj/item/stack/sheet/cardboard //BubbleWrap

/obj/item/storage/box/lights/ComponentInitialize()//holy oversized box. this one can stay the way it is, for now
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.storage_flags = STORAGE_FLAGS_LEGACY_DEFAULT
	STR.max_items = 21
	STR.set_holdable(list(/obj/item/light/tube, /obj/item/light/bulb))
	STR.max_combined_w_class = 21
	STR.click_gather = FALSE //temp workaround to re-enable filling the light replacer with the box

/obj/item/storage/box/lights/bulbs/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/lights/tubes
	name = "box of replacement tubes"
	illustration = "lighttube"

/obj/item/storage/box/lights/tubes/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/tube(src)

/obj/item/storage/box/lights/mixed
	name = "box of replacement lights"
	illustration = "lightmixed"

/obj/item/storage/box/lights/mixed/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/light/tube(src)
	for(var/i in 1 to 7)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/flares
	name = "box of flares"
	illustration = "firecracker"

/obj/item/storage/box/flares/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/flashlight/flare(src)

/obj/item/storage/box/glowsticks
	name = "box of glowsticks"
	illustration = "sparkler"

/obj/item/storage/box/glowsticks/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/effect/spawner/random/decoration/glowstick(src)

/obj/item/storage/box/deputy
	name = "box of deputy armbands"
	desc = "To be issued to those authorized to act as deputy of security."
	icon_state = "secbox"
	illustration = "depband"

/obj/item/storage/box/deputy/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/accessory/armband/deputy(src)

/obj/item/storage/box/metalfoam
	name = "box of metal foam grenades"
	desc = "To be used to rapidly seal hull breaches."
	illustration = "grenade"

/obj/item/storage/box/metalfoam/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/grenade/chem_grenade/metalfoam(src)

/obj/item/storage/box/smart_metal_foam
	name = "box of smart metal foam grenades"
	desc = "Used to rapidly seal hull breaches. This variety conforms to the walls of its area."
	illustration = "grenade"

/obj/item/storage/box/smart_metal_foam/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/grenade/chem_grenade/smart_metal_foam(src)

/obj/item/storage/box/hug
	name = "box of hugs"
	desc = "A special box for sensitive people."
	icon_state = "hugbox"
	illustration = "heart"
	foldable = null

/obj/item/storage/box/hug/attack_self(mob/user)
	..()
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, "rustle", 50, TRUE, -5)
	user.visible_message(span_notice("[user] hugs \the [src]."),span_notice("You hug \the [src]."))

//////
/obj/item/storage/box/hug/medical/PopulateContents()
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)

/obj/item/storage/box/rubbershot
	name = "box of rubber shots"
	desc = "A box full of rubber shots, designed for riot shotguns."
	icon_state = "rubbershot_box"
	illustration = null

/obj/item/storage/box/rubbershot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/rubbershot(src)

/obj/item/storage/box/lethalshot
	name = "box of lethal shotgun shots"
	desc = "A box full of lethal shots, designed for riot shotguns."
	icon_state = "lethalshot_box"
	illustration = null

/obj/item/storage/box/lethalshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/buckshot(src)

/obj/item/storage/box/techshot
	name = "box of unloaded shotgun tech shells"
	desc = "A box full of unloaded tech shells, capable of producing a variety of effects once loaded."
	icon_state = "techshot_box"
	illustration = null

/obj/item/storage/box/techshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/techshell(src)

/obj/item/storage/box/beanbag
	name = "box of beanbags"
	desc = "A box full of beanbag shells."
	icon_state = "beanbag_box"
	illustration = null

/obj/item/storage/box/beanbag/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/shotgun/beanbag(src)

/obj/item/storage/box/slugshot
	name = "box of 12-gauge slug shotgun shells"
	desc = "a box full of slug shots, designed for riot shotguns"
	icon = 'icons/obj/storage.dmi'
	icon_state = "slugshot_box"
	illustration = null

/obj/item/storage/box/slugshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun(src)

/obj/item/storage/box/actionfigure
	name = "box of action figures"
	desc = "The latest set of collectable action figures."
	icon_state = "box"

/obj/item/storage/box/actionfigure/PopulateContents()
	for(var/i in 1 to 4)
		var/randomFigure = pick(subtypesof(/obj/item/toy/figure))
		new randomFigure(src)

/obj/item/storage/box/papersack
	name = "paper sack"
	desc = "A sack neatly crafted out of paper."
	icon_state = "paperbag_None"
	item_state = "paperbag_None"
	illustration = null
	resistance_flags = FLAMMABLE
	foldable = null
	/// A list of all available papersack reskins
	var/list/papersack_designs = list()

/obj/item/storage/box/papersack/Initialize(mapload)
	. = ..()
	papersack_designs = sortList(list(
		"None" = image(icon = src.icon, icon_state = "paperbag_None"),
		"NanotrasenStandard" = image(icon = src.icon, icon_state = "paperbag_NanotrasenStandard"),
		"SyndiSnacks" = image(icon = src.icon, icon_state = "paperbag_SyndiSnacks"),
		"Heart" = image(icon = src.icon, icon_state = "paperbag_Heart"),
		"SmileyFace" = image(icon = src.icon, icon_state = "paperbag_SmileyFace")
		))

/obj/item/storage/box/papersack/update_icon_state()
	if(contents.len == 0)
		icon_state = "[item_state]"
	else
		icon_state = "[item_state]_closed"
	return ..()

/obj/item/storage/box/papersack/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/pen))
		var/choice = show_radial_menu(user, src , papersack_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user, W), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		if(icon_state == "paperbag_[choice]")
			return FALSE
		switch(choice)
			if("None")
				desc = "A sack neatly crafted out of paper."
			if("NanotrasenStandard")
				desc = "A standard Nanotrasen paper lunch sack for loyal employees on the go."
			if("SyndiSnacks")
				desc = "The design on this paper sack is a remnant of the notorious 'SyndieSnacks' program."
			if("Heart")
				desc = "A paper sack with a heart etched onto the side."
			if("SmileyFace")
				desc = "A paper sack with a crude smile etched onto the side."
			else
				return FALSE
		to_chat(user, span_notice("You make some modifications to [src] using your pen."))
		icon_state = "paperbag_[choice]"
		item_state = "paperbag_[choice]"
		return FALSE
	else if(W.get_sharpness())
		if(!contents.len)
			if(item_state == "paperbag_None")
				user.show_message(span_notice("You cut eyeholes into [src]."), MSG_VISUAL)
				new /obj/item/clothing/head/papersack(user.loc)
				qdel(src)
				return FALSE
			else if(item_state == "paperbag_SmileyFace")
				user.show_message(span_notice("You cut eyeholes into [src] and modify the design."), MSG_VISUAL)
				new /obj/item/clothing/head/papersack/smiley(user.loc)
				qdel(src)
				return FALSE
	return ..()

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 * * P The pen used to interact with a menu
 */
/obj/item/storage/box/papersack/proc/check_menu(mob/user, obj/item/pen/P)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(contents.len)
		to_chat(user, span_warning("You can't modify [src] with items still inside!"))
		return FALSE
	if(!P || !user.is_holding(P))
		to_chat(user, span_warning("You need a pen to modify [src]!"))
		return FALSE
	return TRUE

/obj/item/storage/box/papersack/meat
	desc = "It's slightly moist and smells like a slaughterhouse."

/obj/item/storage/box/papersack/meat/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/meat/slab(src)

/obj/item/storage/box/ingredients //This box is for the randomely chosen version the chef spawns with, it shouldn't actually exist.
	name = "ingredients box"
	illustration = "fruit"
	var/theme_name

/obj/item/storage/box/ingredients/Initialize()
	. = ..()
	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "A box containing supplementary ingredients for the aspiring chef. The box's theme is '[theme_name]'."
		item_state = "syringe_kit"

/obj/item/storage/box/ingredients/wildcard
	theme_name = "wildcard"

/obj/item/storage/box/ingredients/wildcard/PopulateContents()
	for(var/i in 1 to 7)
		var/randomFood = pick(
			/obj/item/food/grown/chili,
			/obj/item/food/grown/tomato,
			/obj/item/food/grown/carrot,
			/obj/item/food/grown/potato,
			/obj/item/food/grown/sweet_potato,
			/obj/item/food/grown/apple,
			/obj/item/food/chocolatebar,
			/obj/item/food/grown/cherries,
			/obj/item/food/grown/banana,
			/obj/item/food/grown/cabbage,
			/obj/item/food/grown/soybeans,
			/obj/item/food/grown/corn,
			/obj/item/food/grown/mushroom/plumphelmet,
			/obj/item/food/grown/mushroom/chanterelle)
		new randomFood(src)

/obj/item/storage/box/ingredients/fiesta
	theme_name = "fiesta"

/obj/item/storage/box/ingredients/fiesta/PopulateContents()
	new /obj/item/food/tortilla(src)
	for(var/i in 1 to 2)
		new /obj/item/food/grown/corn(src)
		new /obj/item/food/grown/soybeans(src)
		new /obj/item/food/grown/chili(src)

/obj/item/storage/box/ingredients/italian
	theme_name = "italian"

/obj/item/storage/box/ingredients/italian/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/tomato(src)
		new /obj/item/food/meatball(src)
	new /obj/item/reagent_containers/food/drinks/bottle/wine(src)

/obj/item/storage/box/ingredients/vegetarian
	theme_name = "vegetarian"

/obj/item/storage/box/ingredients/vegetarian/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/carrot(src)
	new /obj/item/food/grown/eggplant(src)
	new /obj/item/food/grown/potato(src)
	new /obj/item/food/grown/apple(src)
	new /obj/item/food/grown/corn(src)
	new /obj/item/food/grown/tomato(src)

/obj/item/storage/box/ingredients/american
	theme_name = "american"

/obj/item/storage/box/ingredients/american/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/potato(src)
		new /obj/item/food/grown/tomato(src)
		new /obj/item/food/grown/corn(src)
	new /obj/item/food/meatball(src)

/obj/item/storage/box/ingredients/fruity
	theme_name = "fruity"

/obj/item/storage/box/ingredients/fruity/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/apple(src)
		new /obj/item/food/grown/citrus/orange(src)
	new /obj/item/food/grown/citrus/lemon(src)
	new /obj/item/food/grown/citrus/lime(src)
	new /obj/item/food/grown/watermelon(src)

/obj/item/storage/box/ingredients/sweets
	theme_name = "sweets"

/obj/item/storage/box/ingredients/sweets/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/cherries(src)
		new /obj/item/food/grown/banana(src)
	new /obj/item/food/chocolatebar(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/apple(src)

/obj/item/storage/box/ingredients/delights
	theme_name = "delights"

/obj/item/storage/box/ingredients/delights/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/sweet_potato(src)
		new /obj/item/food/grown/bluecherries(src)
	new /obj/item/food/grown/vanillapod(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/berries(src)

/obj/item/storage/box/ingredients/grains
	theme_name = "grains"

/obj/item/storage/box/ingredients/grains/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/oat(src)
	new /obj/item/food/grown/wheat(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/reagent_containers/honeycomb(src)
	new /obj/item/seeds/poppy(src)

/obj/item/storage/box/ingredients/carnivore
	theme_name = "carnivore"

/obj/item/storage/box/ingredients/carnivore/PopulateContents()
	new /obj/item/food/meat/slab/bear(src)
	new /obj/item/food/meat/slab/spider(src)
	new /obj/item/food/spidereggs(src)
	new /obj/item/food/fishmeat/carp(src)
	new /obj/item/food/meat/slab/xeno(src)
	new /obj/item/food/meatball(src)

/obj/item/storage/box/ingredients/exotic
	theme_name = "exotic"

/obj/item/storage/box/ingredients/exotic/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/fishmeat/carp(src)
		new /obj/item/food/grown/soybeans(src)
		new /obj/item/food/grown/cabbage(src)
	new /obj/item/food/grown/chili(src)

/obj/item/storage/box/emptysandbags
	name = "box of empty sandbags"
	illustration = "sandbag"

/obj/item/storage/box/emptysandbags/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/emptysandbag(src)

/obj/item/storage/box/rndboards
	name = "\proper the liberator's legacy"
	desc = "A box containing a gift for worthy golems."
	illustration = "scicircuit"
	custom_price = 2000

/obj/item/storage/box/rndboards/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndboards/old
	name = "\proper Nanotrasen R&D Construction Kit"
	desc = "A set of boards for constructing prototype design lathes, dating from a prewar Nanotrasen labratory. These ones are unbraked, and can produce any of the designs in their database without limit."

//departmental RND kits, for shiptests.
/obj/item/storage/box/rndmining
	name = "\proper QWIK-RND: M.I.D.A.S. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print resource-extraction and finance related designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndmining/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/cargo(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/cargo(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndengi
	name = "\proper QWIK-RND: A.T.L.A.S. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print maintenance, construction, and repair related designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndengi/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/engineering(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/engi(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndmed
	name = "\proper QWIK-RND: C.A.R.E. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print medical and pharmaceutical care related designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndmed/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/medical(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/med(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndsec
	name = "\proper QWIK-RND: P.E.A.C.E. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print military designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndsec/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/security(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/sec(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndciv
	name = "\proper QWIK-RND: H.O.M.E. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print a variety of service industry designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndciv/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/service(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/civ(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndbasic
	name = "\proper QWIK-RND: B.A.S.I.C. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print a variety of low-tier miscellaneous designs."
	illustration = "scicircuit"

/obj/item/storage/box/rndbasic/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/basic(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/basic(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/rndsci
	name = "\proper QWIK-RND: K.N.O.W. Module"
	desc = "A set of boards for constructing prototype design lathes. These ones are braked to only print designs related to high-level scientific disciplines."
	illustration = "scicircuit"

/obj/item/storage/box/rndsci/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/department/science(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/department/science(src)
	new /obj/item/circuitboard/computer/rdconsole(src)

/obj/item/storage/box/alvitane
	name = "box of alvitane patches"
	desc = "Contains patches used to treat burns."
	illustration = "firepatch"

/obj/item/storage/box/alvitane/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/patch/alvitane(src)

/obj/item/storage/box/fountainpens
	name = "box of fountain pens"
	illustration = "fpen"

/obj/item/storage/box/fountainpens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/pen/fountain(src)

/obj/item/storage/box/holy_grenades
	name = "box of holy hand grenades"
	desc = "Contains several grenades used to rapidly purge heresy."
	illustration = "grenade"

/obj/item/storage/box/holy_grenades/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/grenade/chem_grenade/holy(src)

/obj/item/storage/box/stockparts/basic //for ruins where it's a bad idea to give access to an autolathe/protolathe, but still want to make stock parts accessible
	name = "box of stock parts"
	desc = "Contains a variety of basic stock parts."

/obj/item/storage/box/stockparts/basic/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor = 3,
		/obj/item/stock_parts/scanning_module = 3,
		/obj/item/stock_parts/manipulator = 3,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/matter_bin = 3)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2
	name = "box of T2 stock parts"
	desc = "Contains a variety of advanced stock parts."

/obj/item/storage/box/stockparts/t2/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/adv = 2,
		/obj/item/stock_parts/scanning_module/adv = 2,
		/obj/item/stock_parts/manipulator/nano = 2,
		/obj/item/stock_parts/micro_laser/high = 2,
		/obj/item/stock_parts/matter_bin/adv = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2/capacitor

/obj/item/storage/box/stockparts/t2/capacitor/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/adv = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2/scan

/obj/item/storage/box/stockparts/t2/scan/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/scanning_module/adv = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2/manipulator

/obj/item/storage/box/stockparts/t2/manipulator/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/manipulator/nano = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2/laser

/obj/item/storage/box/stockparts/t2/laser/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/micro_laser/high = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t2/matter

/obj/item/storage/box/stockparts/t2/matter/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/matter_bin/adv = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3
	name = "box of T3 stock parts"
	desc = "Contains a variety of super stock parts."

/obj/item/storage/box/stockparts/t3/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/super = 2,
		/obj/item/stock_parts/scanning_module/phasic = 2,
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/micro_laser/ultra = 2,
		/obj/item/stock_parts/matter_bin/super = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3/capacitor

/obj/item/storage/box/stockparts/t3/capacitor/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/super = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3/scan

/obj/item/storage/box/stockparts/t3/scan/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/scanning_module/phasic = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3/manipulator

/obj/item/storage/box/stockparts/t3/manipulator/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/manipulator/pico = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3/laser

/obj/item/storage/box/stockparts/t3/laser/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/micro_laser/ultra = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/t3/matter

/obj/item/storage/box/stockparts/t3/matter/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/matter_bin/super = 10)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/deluxe
	name = "box of deluxe stock parts"
	desc = "Contains a variety of deluxe stock parts."
	icon_state = "syndiebox"

/obj/item/storage/box/stockparts/deluxe/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/stock_parts/scanning_module/triphasic = 2,
		/obj/item/stock_parts/manipulator/femto = 2,
		/obj/item/stock_parts/micro_laser/quadultra = 2,
		/obj/item/stock_parts/matter_bin/bluespace = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/dishdrive
	name = "DIY Dish Drive Kit"
	desc = "Contains everything you need to build your own Dish Drive!"
	custom_premium_price = 1000

/obj/item/storage/box/dishdrive/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/sheet/metal/five = 1,
		/obj/item/stack/cable_coil/random/five = 1, //Random from Smartwire Revert - WSie Bois
		/obj/item/circuitboard/machine/dish_drive = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/screwdriver = 1)
	generate_items_inside(items_inside,src)

// because i have no idea where the fuck to put this
/obj/item/storage/box/maid
	name = "Maid box"
	desc = "Contains a maid outfit"

/obj/item/storage/box/maid/PopulateContents()
	var/static/items_inside = list(
		/obj/item/clothing/head/maidheadband = 1,
		/obj/item/clothing/under/costume/maid = 1,
		/obj/item/clothing/gloves/maid = 1,
		/obj/item/clothing/neck/maid = 1,
		/obj/item/clothing/accessory/maidapron = 1,)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/material
	name = "box of materials"
	illustration = "implant"

/obj/item/storage/box/material/PopulateContents() 	//less uranium because radioactive
	var/static/items_inside = list(
		/obj/item/stack/sheet/metal/fifty=1,\
		/obj/item/stack/sheet/glass/fifty=1,\
		/obj/item/stack/sheet/rglass=50,\
		/obj/item/stack/sheet/plasmaglass=50,\
		/obj/item/stack/sheet/titaniumglass=50,\
		/obj/item/stack/sheet/plastitaniumglass=50,\
		/obj/item/stack/sheet/plasteel=50,\
		/obj/item/stack/sheet/mineral/plastitanium=50,\
		/obj/item/stack/sheet/mineral/titanium=50,\
		/obj/item/stack/sheet/mineral/gold=50,\
		/obj/item/stack/sheet/mineral/silver=50,\
		/obj/item/stack/sheet/mineral/plasma=50,\
		/obj/item/stack/sheet/mineral/uranium=20,\
		/obj/item/stack/sheet/mineral/diamond=50,\
		/obj/item/stack/sheet/bluespace_crystal=50,\
		/obj/item/stack/sheet/mineral/hidden/hellstone=50,\
		/obj/item/stack/sheet/mineral/wood=50,\
		/obj/item/stack/sheet/plastic/fifty=1,\
		/obj/item/stack/sheet/mineral/hidden/hellstone/fifty=1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/debugtools
	name = "box of debug tools"
	icon_state = "syndiebox"

/obj/item/storage/box/debugtools/PopulateContents()
	var/static/items_inside = list(
		/obj/item/flashlight/emp/debug=1,\
		/obj/item/pda=1,\
		/obj/item/modular_computer/tablet/preset/advanced=1,\
		/obj/item/geiger_counter=1,\
		/obj/item/construction/rcd/combat/admin=1,\
		/obj/item/pipe_dispenser=1,\
		/obj/item/card/emag=1,\
		/obj/item/spacecash/bundle/c10000=5,\
		/obj/item/healthanalyzer/advanced=1,\
		/obj/item/disk/tech_disk/debug=1,\
		/obj/item/uplink/debug=1,\
		/obj/item/uplink/nuclear/debug=1,\
		/obj/item/storage/box/beakers/bluespace=1,\
		/obj/item/storage/box/beakers/variety=1,\
		/obj/item/storage/box/material=1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/plastic
	name = "plastic box"
	desc = "It's a solid, plastic shell box."
	icon_state = "plasticbox"
	foldable = null
	illustration = "writing"
	custom_materials = list(/datum/material/plastic = 1000) //You lose most if recycled.


/obj/item/storage/box/fireworks
	name = "box of fireworks"
	desc = "Contains an assortment of fireworks."
	illustration = "sparkler"

/obj/item/storage/box/fireworks/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/sparkler(src)
		new/obj/item/grenade/firecracker(src)
	new /obj/item/toy/snappop(src)

/obj/item/storage/box/fireworks/dangerous

/obj/item/storage/box/fireworks/dangerous/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/sparkler(src)
		new/obj/item/grenade/firecracker(src)
	if(prob(20))
		new /obj/item/grenade/frag(src)
	else
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/firecrackers
	name = "box of firecrackers"
	desc = "A box filled with illegal firecracker. You wonder who still makes these."
	icon_state = "syndiebox"
	illustration = "firecracker"

/obj/item/storage/box/firecrackers/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/grenade/firecracker(src)

/obj/item/storage/box/sparklers
	name = "box of sparklers"
	desc = "A box of NT brand sparklers, burns hot even in the cold of space-winter."
	illustration = "sparkler"

/obj/item/storage/box/sparklers/PopulateContents()
	for(var/i in 1 to 7)
		new/obj/item/sparkler(src)

/obj/item/storage/box/shipping
	name = "box of shipping supplies"
	desc = "Contains several scanners and labelers for shipping things. Wrapping Paper not included."
	illustration = "shipping"

/obj/item/storage/box/shipping/PopulateContents()
	var/static/items_inside = list(
		/obj/item/destTagger=1,\
		/obj/item/sales_tagger=1,\
		/obj/item/export_scanner=1,\
		/obj/item/stack/packageWrap/small=2,\
		/obj/item/stack/wrapping_paper/small=1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/plasticware
	name = "plasticware box"
	desc = "Contains plastic forks, spoons and knives for eating food (and other things)."

/obj/item/storage/box/plasticware/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/kitchen/fork/plastic(src)
		new /obj/item/kitchen/spoon/plastic(src)
		new /obj/item/melee/knife/plastic(src)
