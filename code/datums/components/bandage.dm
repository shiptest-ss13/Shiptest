#define TREATMENT_DAMAGE_MOD 2

/datum/component/bandage
	/// How fast do we stop bleeding?
	var/bleed_reduction = 0
	/// How many healing ticks will this bandage apply? Reduced by incoming damage and current bleeding
	var/lifespan = 300
	var/bandage_name = "gauze"
	/// The person this bandage is applied to
	var/mob/living/mummy

/datum/component/bandage/Initialize(_bleed_reduction, _lifespan, _bandage_name)
	if(!istype(parent, /obj/item/bodypart))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/bodypart/BP = parent
	mummy = BP.owner
	if(!mummy)
		return COMPONENT_INCOMPATIBLE
	if(_bleed_reduction)
		bleed_reduction = _bleed_reduction
	if(_lifespan)
		lifespan = _lifespan
	if(_bandage_name)
		bandage_name = _bandage_name
	RegisterSignal(mummy, COMSIG_MOB_APPLY_DAMGE, PROC_REF(check_damage))
	RegisterSignal(mummy, COMSIG_MOB_LIFE, PROC_REF(bandage_effects))
	RegisterSignal(parent, COMSIG_LIVING_DROP_LIMB, PROC_REF(drop_bandage))

/// Checks if damage to the owner is applied to this limb and reduces lifespan (perforated bandages dont work as well)
/datum/component/bandage/proc/check_damage(attacker, damage, damagetype = BRUTE, def_zone = null)
	SIGNAL_HANDLER

	if(parent != mummy.get_bodypart(check_zone(def_zone)))
		return
	lifespan -= damage / 100 * initial(lifespan) * TREATMENT_DAMAGE_MOD //take incoming damage as a % of durability
	if(lifespan <= 0)
		drop_bandage()

/// Handles healing effects and passive lifespan usage
/datum/component/bandage/proc/bandage_effects()
	SIGNAL_HANDLER

	var/obj/item/bodypart/heal_target = parent
	lifespan--
	heal_target.adjust_bleeding(-bleed_reduction)
	if(lifespan <= 0 || !heal_target.bleeding) //remove treatment once it's no longer able to treat
		drop_bandage(TRUE)

/// Handles deleting the component when the bandage runs out of lifespan or finishes healing. Special = bandage didn't get torn off
/datum/component/bandage/proc/drop_bandage(special = FALSE)
	SIGNAL_HANDLER

	var/obj/item/bodypart/BP = parent
	if(special)
		to_chat(mummy, span_notice("The [bandage_name] on your [parse_zone(BP.body_zone)] has [BP.bleeding ? "done what it can" : "stopped the bleeding"]."))
	else
		to_chat(mummy, span_warning("The [bandage_name] on your [parse_zone(BP.body_zone)] is damaged beyond use!"))
	qdel(src)

#undef TREATMENT_DAMAGE_MOD
