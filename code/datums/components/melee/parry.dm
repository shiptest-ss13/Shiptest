/datum/component/parry
	/// the world.time we last parried at
	var/time_parried
	/// the max time since `time_parried` that the shield is still considered "active"
	var/parry_time_out_time

	/// the flat amount of damage the shield user takes per non-perfect parry
	var/stamina_constant
	/// stamina_coefficient * damage * time_since_time_parried = stamina damage taken per non perfect parry
	var/stamina_coefficient
	/// the attack types that are considered for parrying
	var/parryable_attack_types
	/// the time between parry attempts
	var/parry_cooldown
	/// the cooldown you get when you parry an attack
	var/riposte

	/// Text to be shown to users who examine the parent. Will list which type of attacks it can parry.
	var/examine_text
	/// Does this item have a require a condition to meet before being able to parry? This is for two handed weapons that can parry. (Default: FALSE)
	var/requires_two_hands = FALSE
	/// Does this item require activation? This is for activation based items or energy weapons.
	var/requires_activation = FALSE

/datum/component/parry/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(dropped))
	RegisterSignal(parent, COMSIG_ITEM_HIT_REACT, PROC_REF(attempt_parry))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_parent_examined))

/datum/component/parry/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_EQUIPPED)
	UnregisterSignal(parent, COMSIG_ITEM_DROPPED)
	UnregisterSignal(parent, COMSIG_ITEM_HIT_REACT)
	var/obj/item/I = parent
	if(ismob(I.loc))
		UnregisterSignal(I.loc, COMSIG_LIVING_RESIST)

/datum/component/parry/Initialize(
	_stamina_constant = 0,
	_stamina_coefficient = 0,
	_parry_time_out_time = PARRY_DEFAULT_TIMEOUT,
	_parry_cooldown = 0.75 SECONDS,
	_riposte = PARRY_RIPOST,
	_requires_two_hands = FALSE,
	_requires_activation = FALSE,
	_parryable_attack_types = ALL_ATTACK_TYPES
)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	stamina_constant = _stamina_constant
	stamina_coefficient = _stamina_coefficient
	parry_time_out_time = _parry_time_out_time
	parry_cooldown = _parry_cooldown
	riposte = _riposte
	requires_two_hands = _requires_two_hands
	requires_activation = _requires_activation
	if(islist(_parryable_attack_types))
		parryable_attack_types = _parryable_attack_types
	else
		parryable_attack_types = list(_parryable_attack_types)

	var/static/list/attack_types_english = list(
		MELEE_ATTACK = "melee attacks",
		UNARMED_ATTACK = "unarmed attacks",
		PROJECTILE_ATTACK = "projectiles",
		THROWN_PROJECTILE_ATTACK = "thrown projectiles",
		LEAP_ATTACK = "leap attacks"
	)
	var/list/attack_list = list()
	for(var/attack_type in parryable_attack_types)
		attack_list += attack_types_english[attack_type]

	examine_text = span_notice("It's able to <b>parry</b> [english_list(attack_list)].")

/datum/component/parry/proc/equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER
	if(slot == ITEM_SLOT_HANDS)
		RegisterSignal(user, COMSIG_LIVING_RESIST, PROC_REF(start_parry))
	else
		UnregisterSignal(user, COMSIG_LIVING_RESIST)

/datum/component/parry/proc/dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, COMSIG_LIVING_RESIST)

/datum/component/parry/proc/start_parry(mob/living/L)
	SIGNAL_HANDLER
	var/time_since_parry = world.time - time_parried
	if(L.stat != CONSCIOUS)
		return
	//if(requires_two_hands && !HAS_TRAIT(parent, TRAIT_WIELDED)) // If our item has special conditions before being able to parry.
	//	return
	if(requires_activation && !HAS_TRAIT(parent, TRAIT_TRANSFORM_ACTIVE)) // If our item requires an activation to be able to parry. [E-sword / Teleshield, etc.]
		return
	if(time_since_parry < parry_cooldown) // stops spam
		return

	time_parried = world.time
	L.do_attack_animation(L, used_item = parent)

/datum/component/parry/proc/attempt_parry(obj/item/source, mob/living/carbon/human/owner, atom/movable/hitby, damage = 0, attack_type = MELEE_ATTACK)
	SIGNAL_HANDLER
	if(!(attack_type in parryable_attack_types))
		return
	var/time_since_parry = world.time - time_parried
	if(time_since_parry > parry_time_out_time)
		return

	var/armour_penetration_percentage = 0

	if(isitem(hitby))
		var/obj/item/I = hitby
		armour_penetration_percentage = I.armour_penetration

	if(isanimal(hitby))
		var/mob/living/simple_animal/animal = hitby
		armour_penetration_percentage = animal.armour_penetration

	if(armour_penetration_percentage >= 100)
		return

	var/stamina_damage = (stamina_coefficient * (((time_since_parry / parry_time_out_time) + armour_penetration_percentage / 100) * damage)) + stamina_constant

	var/sound_to_play
	if(attack_type == PROJECTILE_ATTACK)
		sound_to_play = pick('sound/weapons/effects/ric1.ogg', 'sound/weapons/effects/ric2.ogg', 'sound/weapons/effects/ric3.ogg', 'sound/weapons/effects/ric4.ogg', 'sound/weapons/effects/ric5.ogg')
	else
		sound_to_play = 'sound/weapons/parry.ogg'

	playsound(owner, sound_to_play, clamp(stamina_damage, 40, 120))
	//Riposte!
	if(riposte != -1)
		source.balloon_alert(owner, "Riposte!")
		owner.changeNext_move(riposte)

	to_chat(owner, "stamina_damage [stamina_damage] time_since_part [time_since_parry] parry_time_out_time [parry_time_out_time] armour_pen [armour_penetration_percentage] damage [damage] stam_const [stamina_constant] stam_coef [stamina_coefficient]")
	owner.adjustStaminaLoss(stamina_damage)
	if(owner.getStaminaLoss() < 100)
		return COMPONENT_HIT_REACTION_BLOCK

/datum/component/parry/proc/on_parent_examined(obj/item/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += examine_text
