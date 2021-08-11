/obj/item/attachment/bayonet
	name = "bayonet"
	desc = "Stabby-Stabby"
	icon_state = "laser_sight"
	force = 20

	var/reach_extended = 2
	var/force_extended = 10

/obj/item/attachment/bayonet/Toggle(obj/item/gun/gun, mob/user)
	. = ..()

	reach = toggled ? reach_extended : initial(reach)
	force = toggled ? force_extended : initial(force)

	playsound(user, 'sound/weapons/batonextend.ogg')
	user.visible_message("[user] [toggled ? "expands" : "retracts"] [user.p_their()] [src].", "You [toggled ? "expand" : "retract"] \the [src].")

/obj/item/attachment/bayonet/PreAttack(obj/item/gun/gun, atom/target, mob/user, list/params)
	if(user.CanReach(target, src, TRUE))
		target.attackby(src, user, params)
		return TRUE
