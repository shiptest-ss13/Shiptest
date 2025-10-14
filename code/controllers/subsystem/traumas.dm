SUBSYSTEM_DEF(traumas)
	name = "Traumas"
	flags = SS_NO_FIRE
	var/list/phobia_types
	var/list/phobia_regexes
	var/list/phobia_mobs
	var/list/phobia_objs
	var/list/phobia_turfs
	var/list/phobia_species

#define PHOBIA_FILE "phobia.json"

/datum/controller/subsystem/traumas/Initialize()
	//phobia types is to pull from randomly for brain traumas, e.g. conspiracies is for special assignment only
	phobia_types = sortList(list("spiders", "space", "security", "greytide", "lizards",
						"skeletons", "snakes", "robots", "doctors", "authority", "the supernatural",
						"aliens", "strangers", "birds", "falling", "anime"))

	phobia_regexes = list(
		"spiders"          = construct_phobia_regex("spiders"),
		"space"            = construct_phobia_regex("space"),
		"security"         = construct_phobia_regex("security"),
		"greytide"         = construct_phobia_regex("greytide"),
		"lizards"          = construct_phobia_regex("lizards"),
		"skeletons"        = construct_phobia_regex("skeletons"),
		"snakes"           = construct_phobia_regex("snakes"),
		"robots"           = construct_phobia_regex("robots"),
		"doctors"          = construct_phobia_regex("doctors"),
		"authority"        = construct_phobia_regex("authority"),
		"the supernatural" = construct_phobia_regex("the supernatural"),
		"aliens"           = construct_phobia_regex("aliens"),
		"strangers"        = construct_phobia_regex("strangers"),
		"conspiracies"     = construct_phobia_regex("conspiracies"),
		"birds"            = construct_phobia_regex("birds"),
		"falling"          = construct_phobia_regex("falling"),
		"anime"            = construct_phobia_regex("anime")
	)

	phobia_mobs = list(
		"spiders"  = typecacheof(list(/mob/living/simple_animal/hostile/poison/giant_spider)),
		"security" = typecacheof(list(/mob/living/simple_animal/bot/secbot)),
		"lizards"  = typecacheof(list(/mob/living/simple_animal/hostile/lizard)),
		"skeletons" = typecacheof(list(/mob/living/simple_animal/hostile/human/skeleton)),
		"snakes"   = typecacheof(list(/mob/living/simple_animal/hostile/retaliate/poison/snake)),
		"robots"   = typecacheof(list(/mob/living/silicon/robot, /mob/living/silicon/ai,
		/mob/living/simple_animal/drone, /mob/living/simple_animal/bot)),
		"doctors"   = typecacheof(list(/mob/living/simple_animal/bot/medbot)),
		"the supernatural"   = typecacheof(list(/mob/living/simple_animal/revenant)),
		"aliens" = typecacheof(list(/mob/living/carbon/alien, /mob/living/simple_animal/slime, /mob/living/simple_animal/hostile/facehugger)),
		"conspiracies" = typecacheof(list(/mob/living/simple_animal/bot/secbot, /mob/living/simple_animal/drone,
		/mob/living/simple_animal/pet/penguin)),
		"birds" = typecacheof(list(/mob/living/simple_animal/parrot, /mob/living/simple_animal/chick, /mob/living/simple_animal/chicken,
		/mob/living/simple_animal/pet/penguin)),
	)

	phobia_objs = list(
		"snakes" = typecacheof(list(/obj/item/toy/plush/snakeplushie)),

		"spiders"   = typecacheof(list(/obj/structure/spider, /obj/item/toy/plush/spider)),

		"security"  = typecacheof(list(
			/obj/item/clothing/under/rank/security/officer, /obj/item/clothing/under/rank/security/warden,
			/obj/item/clothing/under/rank/security/head_of_security, /obj/item/clothing/under/rank/security/detective,
			/obj/item/melee/baton, /obj/item/gun/energy/taser, /obj/item/restraints/handcuffs,
			/obj/machinery/door/airlock/security, /obj/effect/hallucination/simple/securitron)),

		"greytide"  = typecacheof(list(
			/obj/item/clothing/under/color/grey, /obj/item/melee/baton/cattleprod,
			/obj/item/melee/spear, /obj/item/clothing/mask/gas)),

		"lizards"   = typecacheof(list(
			/obj/item/toy/plush/lizardplushie, /obj/item/organ/tail/lizard,
			/obj/item/reagent_containers/food/drinks/bottle/lizardwine)),

		"skeletons" = typecacheof(list(
			/obj/item/organ/tongue/bone, /obj/item/clothing/suit/armor/bone, /obj/item/stack/sheet/bone,
			/obj/item/food/meat/slab/human/mutant/skeleton,
			/obj/effect/decal/remains/human)),

		"conspiracies" = typecacheof(list(
			/obj/item/clothing/under/rank/command/captain, /obj/item/clothing/under/rank/security/head_of_security,
			/obj/item/clothing/under/rank/engineering/chief_engineer, /obj/item/clothing/under/rank/medical/chief_medical_officer,
			/obj/item/clothing/under/rank/command/head_of_personnel, /obj/item/clothing/under/rank/rnd/research_director,
			/obj/item/clothing/under/rank/security/head_of_security/alt,
			/obj/item/clothing/under/rank/rnd/research_director/alt, /obj/item/clothing/under/rank/rnd/research_director/turtleneck,
			/obj/item/clothing/under/rank/security/head_of_security/parade,
			/obj/item/clothing/under/rank/security/head_of_security/parade/female,
			/obj/item/clothing/head/helmet/abductor, /obj/item/clothing/suit/armor/abductor/vest, /obj/item/melee/baton/abductor,
			/obj/item/storage/belt/military/abductor, /obj/item/gun/energy/alien, /obj/item/abductor/silencer,
			/obj/item/abductor/gizmo, /obj/item/clothing/under/rank/centcom/official,
			/obj/item/clothing/suit/space/hardsuit/ert, /obj/item/clothing/suit/space/hardsuit/ert/sec,
			/obj/item/clothing/suit/space/hardsuit/ert/engi, /obj/item/clothing/suit/space/hardsuit/ert/med,
			/obj/item/clothing/suit/space/hardsuit/deathsquad, /obj/item/clothing/head/helmet/space/hardsuit/deathsquad,
			/obj/machinery/door/airlock/centcom)),

		"robots"   = typecacheof(list(
			/obj/machinery/computer/upload, /obj/item/aiModule/, /obj/machinery/recharge_station,
			/obj/item/aicard)),

		"doctors"   = typecacheof(list(
			/obj/item/clothing/under/rank/medical,
			/obj/item/reagent_containers/syringe, /obj/item/reagent_containers/pill/, /obj/item/reagent_containers/hypospray,
			/obj/item/storage/firstaid, /obj/item/storage/pill_bottle, /obj/item/healthanalyzer,
			/obj/structure/sign/departments/medbay, /obj/machinery/door/airlock/medical, /obj/machinery/sleeper, /obj/machinery/stasis,
			/obj/machinery/dna_scannernew, /obj/machinery/atmospherics/components/unary/cryo_cell,
			/obj/item/retractor, /obj/item/hemostat, /obj/item/cautery, /obj/item/surgicaldrill, /obj/item/scalpel, /obj/item/circular_saw,
			/obj/item/clothing/suit/bio_suit/plaguedoctorsuit, /obj/item/clothing/mask/gas/plaguedoctor)),

		"authority"   = typecacheof(list(
			/obj/item/clothing/under/rank/command/captain,  /obj/item/clothing/under/rank/command/head_of_personnel,
			/obj/item/clothing/under/rank/security/head_of_security, /obj/item/clothing/under/rank/rnd/research_director,
			/obj/item/clothing/under/rank/medical/chief_medical_officer, /obj/item/clothing/under/rank/engineering/chief_engineer,
			/obj/item/clothing/under/rank/centcom/official, /obj/item/clothing/under/rank/centcom/commander,
			/obj/item/melee/classic_baton/telescopic, /obj/item/card/id/silver, /obj/item/card/id/gold,
			/obj/item/card/id/captains_spare, /obj/item/card/id/centcom, /obj/machinery/door/airlock/command)),

		"the supernatural"  = typecacheof(list(
			/obj/item/clothing/suit/wizrobe, /obj/item/clothing/head/wizard, /obj/item/spellbook, /obj/item/staff,
			/obj/item/clothing/under/rank/civilian/chaplain)),

		"aliens"   = typecacheof(list(
			/obj/item/clothing/mask/facehugger_item, /obj/item/organ/body_egg/alien_embryo,
			/obj/structure/alien, /obj/item/toy/toy_xeno,
			/obj/item/clothing/suit/armor/abductor, /obj/item/abductor, /obj/item/gun/energy/alien,
			/obj/item/melee/baton/abductor, /obj/item/radio/headset/abductor, /obj/item/scalpel/alien, /obj/item/hemostat/alien,
			/obj/item/retractor/alien, /obj/item/circular_saw/alien, /obj/item/surgicaldrill/alien, /obj/item/cautery/alien,
			/obj/item/clothing/head/helmet/abductor, /obj/structure/bed/abductor, /obj/structure/table_frame/abductor,
			/obj/structure/table/abductor, /obj/structure/closet/abductor, /obj/item/organ/heart/gland,
			/obj/machinery/abductor, /obj/item/crowbar/abductor, /obj/item/screwdriver/abductor, /obj/item/weldingtool/abductor,
			/obj/item/wirecutters/abductor, /obj/item/wrench/abductor, /obj/item/stack/sheet/mineral/abductor)),

		"birds" = typecacheof(list(
			/obj/item/clothing/mask/gas/plaguedoctor, /obj/item/food/cracker,
			/obj/item/clothing/suit/toggle/owlwings, /obj/item/clothing/under/costume/owl, /obj/item/clothing/mask/gas/owl_mask)),

		"anime" = typecacheof(list(
			/obj/item/clothing/under/costume/schoolgirl, /obj/item/food/sashimi,
			/obj/item/food/chawanmushi,
			/obj/item/reagent_containers/food/drinks/bottle/sake, /obj/item/throwing_star,
			/obj/item/clothing/suit/space/space_ninja,
			/obj/item/clothing/mask/gas/space_ninja, /obj/item/clothing/shoes/space_ninja, /obj/item/clothing/gloves/space_ninja,
			/obj/item/melee/sword/vibro, /obj/item/melee/sword/energy_katana, /obj/item/toy/katana,
			/obj/item/melee/sword/katana, /obj/structure/window/paperframe, /obj/structure/mineral_door/paperframe))
	)

	phobia_turfs = list(
		"space" = typecacheof(list(/turf/open/space, /turf/open/floor/holofloor/space, /turf/open/floor/fakespace)),
		"the supernatural" = typecacheof(/turf/closed/wall/mineral/cult, /turf/open/floor/plasteel/cult),
		"aliens" = typecacheof(list(
			/turf/open/floor/plating/abductor, /turf/open/floor/plating/abductor2,
			/turf/open/floor/mineral/abductor, /turf/closed/wall/mineral/abductor)),
		"falling" = typecacheof(list(/turf/open/chasm, /turf/open/floor/fakepit))
	)

	phobia_species = list(
		"lizards" = typecacheof(list(/datum/species/lizard)),
		"birds" = typecacheof(list(/datum/species/kepori)),
		"skeletons" = typecacheof(list(/datum/species/skeleton, /datum/species/plasmaman)),
		"conspiracies" = typecacheof(list(/datum/species/abductor, /datum/species/lizard)),
		"robots" = typecacheof(list(/datum/species/android, /datum/species/ipc)),
		"aliens" = typecacheof(list(
			/datum/species/abductor, /datum/species/jelly, /datum/species/pod)),
		"spiders" = typecacheof(list(/datum/species/spider))
	)

	return ..()

///Creates a regular expression to match against the given phobia
///Capture group 2 = the scary word
///Capture group 3 = an optional suffix on the scary word
/datum/controller/subsystem/traumas/proc/construct_phobia_regex(list/name)
	var/list/words = strings(PHOBIA_FILE, name)
	if(!length(words))
		CRASH("phobia [name] has no entries")
	var/words_match = ""
	for(var/word in words)
		words_match += "[REGEX_QUOTE(word)]|"
	words_match = copytext(words_match, 1, -1)
	return regex("(\\b|\\A)([words_match])('?s*)(\\b|\\|)", "ig")

#undef PHOBIA_FILE
