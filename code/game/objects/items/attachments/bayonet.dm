/obj/item/attachment/bayonet
	name = "Bayonet"
	desc = "Stabby-Stabby"
	icon_state = "laser_sight"
	force = 20
	signals = list(
		COMSIG_ATTACHMENT_PRE_ATTACK = .proc/handle_attack
	)

	var/range = 1
	var/range_extended = 2
	var/force_extended = 10

/obj/item/attachment/bayonet/Toggle(datum/component/attachment_holder/holder, obj/item/gun/gun, mob/user)
	. = ..()

	range = toggled ? range_extended : initial(range)
	force = toggled ? force_extended : initial(force)

/obj/item/attachment/bayonet/proc/handle_attack(datum/component/attachment_holder/holder, obj/item/gun/gun, atom/target, mob/user, list/params)
	if(target in range(range, user))
		target.attackby(src, user, params)
	return
