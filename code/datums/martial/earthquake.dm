#define EARTH_STRONG_PUNCH_COMBO "HHH"
#define EARTH_LAUNCH_KICK_COMBO "HD"

//EARTHQUAKE STANCE: Conditional "martial art" mainly granted by the Concussion Gauntlets. An admin-spawnable no slowdown version also exists.
/datum/martial_art/earthquake
	name = "Earthquake Stance"
	id = MARTIALART_EARTHQUAKE
	allow_temp_override = FALSE
	help_verb = /mob/living/carbon/human/proc/earthquake_help
	display_combos = TRUE
	var/datum/action/neck_chop/neckchop = new/datum/action/neck_chop()
	var/datum/action/leg_sweep/legsweep = new/datum/action/leg_sweep()

/datum/martial_art/earthquake/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,EARTH_STRONG_PUNCH_COMBO))
		streak = ""
		strongPunch(A,D)
		return TRUE
	if(findtext(streak,EARTH_LAUNCH_KICK_COMBO))
		streak = ""
		launchKick(A,D)
		return TRUE


///Shelf Collapse: Harm Harm Harm, consistent 25 force punch on every third hit. Flings enemies away. Uppercut! Combo breaker!
/datum/martial_art/earthquake/proc/strongPunch(mob/living/carbon/human/A, mob/living/carbon/human/D)
	///this var is so that the strong punch is always aiming for the body part the user is targeting and not trying to apply to the chest before deviating
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("double uppercut", "full-body check", "slams into")
	D.visible_message("<span class='danger'>[A] [atk_verb]s [D]!</span>", \
					"<span class='userdanger'>[A] [atk_verb]s you!</span>", null, null, A)
	to_chat(A, "<span class='danger'>You [atk_verb] [D]!</span>")
	var/atom/throw_target = get_edge_target_turf(D, A.dir)
	D.throw_at(throw_target, 3, 4, A)
	D.apply_damage(15, STAMINA, BODY_ZONE_CHEST)
	D.Knockdown(15)
	playsound(get_turf(D), 'sound/weapons/resonator_blast.ogg', 25, TRUE, -1)
	log_combat(A, D, "combo-broken (Earthquake Stance)")
	D.apply_damage(20, A.dna.species.attack_type, affecting)
	return

///Fault Exposure Technique: Harm Disarm combo. After waiting a delay, deals heavy damage with a high chance to break bones. Structure killer.
/datum/martial_art/earthquake/proc/launchKick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	to_chat(A, "<span class='danger'>You concentrate on locating a fault line.</span>")
	if(!do_after(A, 35, target = D))
		to_chat(A, "<span class='userdanger'><b>Your attack was interrupted!</b></span>")
		return TRUE //martial art code was a mistake
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("impacted", "agitated")
	D.visible_message("<span class='danger'>[A] [atk_verb] [D] with inhuman strength and accuracy!</span>", \
					"<span class='userdanger'>Your body is [atk_verb] by [A] with the surgical accuracy!</span>")
	to_chat(A, "<span class='danger'>You [atk_verb] [D] with the knowlege of exactly how to make them break.</span>")
	D.apply_damage(rand(35,50), A.dna.species.attack_type, break_modifier = 50)
	D.Paralyze(20)
	playsound(D, 'sound/effects/meteorimpact.ogg', 50, TRUE, -1)
	log_combat(A, D, "exposed (Earthquake Stance)")
	return

/datum/martial_art/earthquake/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Earthquake Stance)")
	return ..()

/datum/martial_art/earthquake/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("blast", "slam", "destabilize", "oscillate")
	D.visible_message("<span class='danger'>[A] [atk_verb] [D]!</span>", \
					"<span class='userdanger'>[A] [atk_verb]s you!</span>", null, null, A)
	to_chat(A, "<span class='danger'>You [atk_verb] [D]!</span>")
	D.apply_damage(20, BRUTE, affecting)
	playsound(get_turf(D), 'sound/weapons/kenetic_accel.ogg', 25, TRUE, -1)//iconic kinetic accelerator spelling mistake
	log_combat(A, D, "punched (Earthquake Stance)")
	return TRUE

/datum/martial_art/earthquake/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Earthquake Stance)")
	return ..()

/datum/martial_art/earthquake/on_projectile_hit(mob/living/carbon/human/A, obj/projectile/P, def_zone)
	. = ..()
	if(A.incapacitated(FALSE, TRUE)) //NO STUN
		return BULLET_ACT_HIT
	if(!(A.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return BULLET_ACT_HIT
	if(A.dna && A.dna.check_mutation(HULK)) //NO HULK
		return BULLET_ACT_HIT
	if(!isturf(A.loc))
		return BULLET_ACT_HIT
	if(A.in_throw_mode)
		A.visible_message("<span class='danger'>[A] reflects the projectile with their rock-hard abs!</span>", "<span class='userdanger'>You peform the metamorphic technique!</span>")
		playsound(get_turf(A), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
		P.firer = A
		P.setAngle(rand(0, 360))//SHING
		return BULLET_ACT_FORCE_PIERCE
	return BULLET_ACT_HIT

/datum/martial_art/earthquake/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	to_chat(H, "<span class='userdanger'>Your gauntlets harden into place. You recall the forgotten art of [name]!</span>")
	to_chat(H, "<span class='danger'>Check the status bar to learn the basics of EQS.</span>")
	ADD_TRAIT(H, TRAIT_NOGUNS, EARTHQUAKE_TRAIT)
	ADD_TRAIT(H, TRAIT_PIERCEIMMUNE, EARTHQUAKE_TRAIT)
	ADD_TRAIT(H, TRAIT_STUNRESISTANCE, EARTHQUAKE_TRAIT)
	ADD_TRAIT(H, TRAIT_IGNOREDAMAGESLOWDOWN, EARTHQUAKE_TRAIT)//you are slow as fuck, but your speed is constant
	H.physiology.brute_mod *= 0.4 //the earth is strong
	H.physiology.burn_mod *= 0.4 //burn the earth and it becomes even sterner in strength
	H.physiology.stamina_mod *= 2.0 //the earth is slow and difficult to carry topple those who use it(this combines with slowdown to become a clear PVP weakness- use it!)
	H.physiology.stun_mod *= 0.5 //the earth's existing movement cannot be so easily stopped, though
	H.physiology.pressure_mod *= 0.1 //rocks don't die in space dummy
	H.physiology.cold_mod *= 0.3 //cold mods are different to burn mods, they do stack however
	H.physiology.heat_mod *= 0.3 //earth can get pretty toasty, but it always melts eventually
	H.physiology.tox_mod *= 1.5//pollution is bad, kids

/datum/martial_art/earthquake/on_remove(mob/living/carbon/human/H)
	. = ..()
	to_chat(H, "<span class='userdanger'>Your connection to the earth fades. You have lost knowlege of [name]...</span>")
	REMOVE_TRAIT(H, TRAIT_NOGUNS, EARTHQUAKE_TRAIT)
	REMOVE_TRAIT(H, TRAIT_PIERCEIMMUNE, EARTHQUAKE_TRAIT)
	REMOVE_TRAIT(H, TRAIT_STUNRESISTANCE, EARTHQUAKE_TRAIT)
	REMOVE_TRAIT(H, TRAIT_IGNOREDAMAGESLOWDOWN, EARTHQUAKE_TRAIT)
	H.physiology.brute_mod = initial(H.physiology.brute_mod)
	H.physiology.burn_mod = initial(H.physiology.burn_mod)
	H.physiology.stamina_mod = initial(H.physiology.stamina_mod)
	H.physiology.stun_mod = initial(H.physiology.stun_mod)
	H.physiology.pressure_mod = initial(H.physiology.pressure_mod)
	H.physiology.cold_mod = initial(H.physiology.cold_mod)
	H.physiology.tox_mod = initial (H.physiology.tox_mod)
	H.physiology.heat_mod = initial (H.physiology.heat_mod)

/mob/living/carbon/human/proc/earthquake_help()
	set name = "Commune with the earth"
	set desc = "Remember the techniques taught by Earthquake Stance."
	set category = "Earthquake Stance"

	to_chat(usr, "<b><i>You retreat inward and recall the movement of tectonic plates...</i></b>")

	to_chat(usr, "<span class='notice'>Fist of Convection </span>: All unarmed attacks while wearing the gauntlets are punctuated by powerful quake blasts, doing additional damage that <b>pierces all armor.</b>")//damage vs humans is low, but consistent. damage vs. certain fauna is *considerably* higher.
	to_chat(usr, "<span class='notice'>Shelf Collapse Technique</span>: Harm Harm Harm. Takes advantage of built-up energy to create a devastating combo blast. Every third strike deals additional damage, and flings enemies away from you.")
	to_chat(usr, "<span class='notice'>Fault Exposure Technique</span>: Harm Disarm. Meditate on your connection to the earth, then strike a target's weakpoint with enhanced force. High chance of causing bone fractures. Devastating against structures.")
	to_chat(usr, "<span class='notice'>In addition, the special bond you share with the earth around you makes your body incredibly resilient to most damage, though you are now much slower. Enter throw mode to pefrom the metamorphic compaction technique, reflecting all ranged attacks!</span>")
	to_chat(usr, "<span class='danger'>Your sedimentary density means you are more easily tipped. Furthermore, your stony body is less responsive to medicine, and your connection to the earth means you are especially sensitive to tainting influences. Tread carefully.</span>")
