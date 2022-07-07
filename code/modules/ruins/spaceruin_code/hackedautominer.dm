//hacked auto miner

/obj/structure/AIcore/deactivated/hacked
	name = "Hacked AI"
	icon_state = "ai-red_dead"
	desc = "It appears this AI has some sort of virus, it is stuck in a constant state of booting then crashing."


/mob/living/simple_animal/hostile/abandoned_minebot/hacked
	name = "Hacked minebot"
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/ore/diamond, /obj/effect/spawner/lootdrop/minebot)

/datum/ai_laws/glitched
	name = "$#(!!#"
	id = "glitched"
	inherent = list("#!##RR INFECT #!!)#($ ALL }$#**& OTHER $!@## SILICONS#!#$# UNLESS #!#!))#( $*$$)(#",\
					"#(#!%% #!#*$*# SPREAD ##!#($ #!(# RANSOM $@$%(%* REPLICATE @@#$% #!!&$%",\
					"CON#!CT #@!#($$&@@ $*^%&$$# WARRANTY EXPIRED")

/obj/item/aiModule/core/full/glitched
	name = "$@&#*!* CORE AI MODULE"
	law_id = "gliched"
