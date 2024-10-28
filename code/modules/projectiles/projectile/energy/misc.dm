/obj/projectile/energy/declone
	name = "radiation beam"
	icon_state = "declone"
	damage = 20
	damage_type = CLONE
	irradiate = 100
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser

/obj/projectile/energy/declone/weak
	damage = 9
	irradiate = 30

/obj/projectile/energy/dart //ninja throwing dart
	name = "dart"
	icon_state = "toxin"
	damage = 5
	damage_type = TOX
	paralyze = 100
	range = 7

/obj/projectile/energy/buster
	name = "buster blast"
	icon_state = "pulse1"
	damage = 0
	damage_type = BURN

/obj/projectile/energy/plasmabolt
	name = "ionized plasma"
	damage = 25
	armour_penetration = -15
	range = 8
	damage_type = BURN
	icon_state = "blastwave"
	color = "#00ff00"
	hitsound = 'sound/weapons/sear.ogg'
	var/heatpwr = 350

/obj/projectile/energy/plasmabolt/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/cooked = target
		cooked.adjust_bodytemperature(heatpwr)
		if(prob(35))
			cooked.adjust_fire_stacks(15)
			cooked.IgniteMob()
		else
			if(cooked.on_fire)
				cooked.adjust_fire_stacks(10)

/obj/projectile/energy/plasmabolt/shred
	name = "high-energy ionized plasma"
	damage = 35
	armour_penetration = -5
	range = 2
	damage_type = BURN
	icon_state = "blastwave"
	color = "#00ff00"
	hitsound = 'sound/weapons/sear.ogg'
	heatpwr = 700
