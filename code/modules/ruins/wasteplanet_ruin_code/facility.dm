//turret
/obj/machinery/porta_turret/ruin/burst
	name = "Suppressor Turret"
	desc = "A triple-volley burst energy turret often employed in low-budget planetary operations to deter local fauna, as well as any other latent threats. It is universally bemoaned by frontier mechanics due to its exceedingly fragile design, which has sparked a tradition of tallying repairs on the outer casing."
	lethal_projectile = /obj/projectile/beam/laser/light
	stun_projectile = /obj/projectile/beam/disabler/weak
	lethal_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	stun_projectile_sound = 'sound/weapons/taser2.ogg'
	shot_delay = 10
	max_integrity = 200
	integrity_failure = 0.7
	burst_size = 3
	burst_delay = 8
	reaction_time = 30
	shot_delay = 40
	spread = 30

//i don't know a better way of doing this Lol
/obj/effect/spawner/random/tesla_bullets
	name = "tesla bullets"
	spawn_loot_count = 16
	loot = list(/obj/item/ammo_casing/c46x30mm/tesla)

//reprogrammed enemies
/mob/living/basic/hivebot/strong/reprogrammed
	name = "reprogrammed hivebot"
	desc = "A towering scrap-clad automaton. It appears to have been haphazardly rewired and rebranded, with a logo you don't recognise printed on its outer plating."
	aggro_quips = list("C#$ 7-/<!!","$&&#># 7@<@1!!","D$END#&TERI$@$S!!","/C$$&ITY$>WI&HINA^@!!","I$$RAR>$@$<T#$IN$AO$!!","$ER@$A#E #OS/E!!","$@P$#A$#&$#^#$EE/TT$@^N/@!!","A#SES<>$$ ENGAG$!!","$#$CL$^IM$AR!!","&#OR$/$NCL$@IM!!")
	faction = list(FACTION_ANTAG_HERMITS)

/mob/living/simple_animal/hostile/abandoned_minebot/reprogrammed
	name = "reprogrammed minebot"
	desc = "A rusted minebot fitted with antiquated mining and salvage tools. It appears to have been haphazardly rewired and rebranded, with a logo you don't recognise printed on its outer plating."
	faction = list(FACTION_ANTAG_HERMITS)

/mob/living/simple_animal/hostile/viscerator/reprogrammed
	name = "reprogrammed viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations. It appears to have been haphazardly rewired and rebranded, with a logo you don't recognise printed on its outer plating."
	faction = list(FACTION_ANTAG_HERMITS)
