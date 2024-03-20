#define BANDAGE_DAMAGE_COEFF 5

/datum/component/bandage
	/// How much damage do we heal?
	var/healing_speed = 0.2
	/// How many healing ticks will this bandage apply? Reduced by incoming damage and other nasties
	var/cleanliness = 300
	/// What is dropped when the bandage is removed?
	var/trash_item = /obj/effect/decal/cleanable/wrapping
	var/bandage_name = "bandage"
	///a
	var/mob/living/mummy

/datum/component/bandage/Initialize(_healing_speed, _cleanliness, _bandage_name, _trash_item)
	if(!istype(parent, /obj/item/bodypart))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/bodypart/BP = parent
	mummy = BP.owner
	if(!mummy)
		return COMPONENT_INCOMPATIBLE
	if(_healing_speed)
		healing_speed = _healing_speed
	if(_cleanliness)
		cleanliness = _cleanliness
	if(_bandage_name)
		bandage_name = _bandage_name
	if(_trash_item)
		trash_item = _trash_item
	RegisterSignal(mummy, COMSIG_MOB_APPLY_DAMGE, PROC_REF(check_damage))
	RegisterSignal(mummy, COMSIG_MOB_LIFE, PROC_REF(bandage_effects))

/datum/component/bandage/proc/check_damage(damage, damagetype = BRUTE, def_zone = null)
	if(parent != mummy.get_bodypart(check_zone(def_zone)))
		return
	cleanliness = cleanliness - damage * BANDAGE_DAMAGE_COEFF
	if(cleanliness <= 0)
		drop_bandage()


/datum/component/bandage/proc/bandage_effects()
	var/obj/item/bodypart/heal_target = parent
	var/actual_heal_speed = healing_speed //TODO: add modifiers to this (scope 2)
	heal_target.heal_damage(actual_heal_speed, actual_heal_speed)
	cleanliness --
	if(heal_target.bleeding)
		cleanliness = round(cleanliness - max(heal_target.bleeding, 1))
		heal_target.adjust_bleeding(actual_heal_speed)
	if(cleanliness <= 0 || (!heal_target.bleeding && !heal_target.get_damage()))
		drop_bandage()

/datum/component/bandage/proc/drop_bandage()
	
	if(trash_item)
		new trash_item(get_turf(parent))
		mummy.visible_message(span_notice("The [bandage_name] on [mummy]'s [parent] falls to the floor."), span_notice("The [bandage_name] on your [parent] falls to the floor."))
	else
		to_chat(mummy, span_notice("The [bandage_name] on your [parent] has healed what it can."))
	qdel(src)
