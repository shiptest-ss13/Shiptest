/datum/job/bartender
	name = "Bartender"
	total_positions = 1
	spawn_positions = 1
	wiki_page = "Drinks" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/bartender

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	display_order = JOB_DISPLAY_ORDER_BARTENDER

/datum/outfit/job/bartender
	name = "Bartender"
	job_icon = "bartender"
	jobtype = /datum/job/bartender

	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	belt = /obj/item/pda/bar
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/bartender
	alt_uniform = /obj/item/clothing/under/rank/civilian/bartender/purple //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/apron/purple_bartender
	suit = /obj/item/clothing/suit/armor/vest
	backpack_contents = list(/obj/item/storage/box/beanbag=1)
	shoes = /obj/item/clothing/shoes/laceup

/datum/outfit/job/bartender/syndicate
	id = /obj/item/card/id/syndicate_command/crew_id
	head = /obj/item/clothing/head/HoS/beret/syndicate

/datum/outfit/job/bartender/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()

	var/obj/item/card/id/W = H.wear_id
	if(H.age < AGE_MINOR)
		W.registered_age = AGE_MINOR
		to_chat(H, "<span class='notice'>You're not technically old enough to access or serve alcohol, but your ID has been discreetly modified to display your age as [AGE_MINOR]. Try to keep that a secret!</span>")

/datum/outfit/job/bartender/syndicate/sbc
	name = "Bartender (Twinkleshine)"

	uniform = /obj/item/clothing/under/syndicate/donk
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/gas/syndicate/voicechanger
	belt = /obj/item/storage/belt/bandolier
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate_command/crew_id

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	box = /obj/item/storage/box/survival/syndie

/datum/outfit/job/bartender/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(2, 5)) // squidquest real
	I.assignment = "Bartender"
	I.access |= list(ACCESS_SYNDICATE)
	I.update_label()

/datum/outfit/job/bartender/pharma
	name = "Mixologist"

	backpack_contents = list(/obj/item/storage/box/syringes=1, /obj/item/storage/box/drinkingglasses = 1)
	ears = /obj/item/radio/headset/headset_med
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/armor/vest
	l_pocket = /obj/item/pda/bar
	r_pocket = /obj/item/reagent_containers/food/drinks/shaker
	belt = /obj/item/storage/belt
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	uniform = /obj/item/clothing/under/suit/black
