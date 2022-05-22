/datum/component/taped
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/taped_name
	var/taped_integrity = 0
	var/mutable_appearance/taped_icon
	var/taped_icon_state


/datum/component/taped/Initialize(obj/item/stack/tape/tape_used)
	if(!isatom(parent) || !tape_used)
		return COMPONENT_INCOMPATIBLE
	taped_name = tape_used.name
	taped_icon_state = tape_used.icon_state
	set_tape(tape_used.nonorganic_heal)

/datum/component/taped/InheritComponent(datum/component/taped/C, i_am_original, obj/item/stack/tape/tape_used)
	var/obj/I = parent
	var/added_integrity
	if(C)
		taped_name = C.taped_name
		taped_icon_state = C.taped_icon_state
		added_integrity = C.taped_integrity
	else
		taped_name = tape_used.name
		taped_icon_state = tape_used.icon_state
		added_integrity = tape_used.nonorganic_heal
	I.cut_overlay(taped_icon)
	set_tape(added_integrity)

/datum/component/taped/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/tape_rip)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/examine_tape)

/datum/component/taped/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))

/datum/component/taped/proc/set_tape(var/patch_amount)
	var/obj/I = parent
	var/icon/tape_marks = icon(initial(I.icon), initial(I.icon_state))

	I.obj_integrity = min((I.obj_integrity + patch_amount), I.max_integrity)
	taped_integrity += patch_amount

	tape_marks.Blend("#fff", ICON_ADD)
	tape_marks.Blend(icon('whitesands/icons/obj/tapes.dmi', "[taped_icon_state]_mask"), ICON_MULTIPLY)
	taped_icon = new(tape_marks)
	I.add_overlay(taped_icon)
	I.update_icon()

/datum/component/taped/proc/tape_rip(datum/source, obj/item/attacker, mob/user)
	var/obj/item/I = attacker
	if(!I.tool_behaviour == TOOL_WIRECUTTER || !I.sharpness == SHARP_EDGED)
		return
	playsound(parent, 'sound/items/poster_ripped.ogg', 30, TRUE, -2)
	user.visible_message("<span class='notice'>[user] cuts and tears [taped_name] off \the [parent].", "<span class='notice'>You finish peeling away all the [taped_name] from \the [parent].</span>")
	remove_tape()

/datum/component/taped/proc/examine_tape(datum/source, mob/user, list/examine_list)
	examine_list += "<span class='warning'>A bunch of [taped_name] is holding this thing together!</span>"

/datum/component/taped/proc/remove_tape()
	var/obj/item/I = parent
	I.obj_integrity -= taped_integrity
	I.cut_overlay(taped_icon)
	qdel(src)
