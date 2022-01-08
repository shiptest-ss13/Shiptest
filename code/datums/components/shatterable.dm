///Shatterable component
/*
dsafayugyausdohjfjdjsajdfah
*/
/datum/component/shatterable
	var/break_on_throw //self explainatory
	var/damage_taken_per_hit //whenever you hit something with it, or it hits something when thrown when the first var is disabled

/datum/component/shatterable/Initialize(break_on_throw = FALSE, damage_taken_per_hit = 50)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	src.break_on_throw = break_on_throw
	src.damage_taken_per_hit = damage_taken_per_hit
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK .proc/handle_attack)
	RegisterSignal(parent, COMSIG_MOVABLE_IMPACT .proc/handle_hit_onthrown)

/datum/component/shatterable/handle_attack()
	parent.obj_integrity = obj_integrity - damage_taken_per_hit
	if(obj_integrity <= 0)
		parent.qdel()

/datum/component/shatterable/handle_hit_onthrown()
	if(break_on_throw)
		parent.qdel()
	else
		parent.obj_integrity = obj_integrity - damage_taken_per_hit
		if(obj_integrity <= 0)
			parent.qdel()
