/datum/surgery/omni
	name = "Omni-surgery"
	desc = "allows multiple surgeries on one part based on tissue layers"
	status = 1
	steps = list()										//We ballin
	target_mobtypes = list(/mob/living/carbon/human)	//Acceptable Species
	possible_locs = list(BODY_ZONE_CHEST,BODY_ZONE_HEAD,BODY_ZONE_L_ARM,BODY_ZONE_L_LEG,BODY_ZONE_R_ARM,BODY_ZONE_R_LEG)
	speed_modifier = 1									//Step speed modifier
	var/atlayer = 0										// 0/1/2 -> skin/muscle/bone
	var/datum/surgery_step/omni/last_step				//The last step preformed

/datum/surgery/omni/next_step(mob/user, intent)
	if(location != user.zone_selected)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(intent == INTENT_DISARM)
		try_to_fail = TRUE
	var/obj/item/tool = user.get_active_held_item()
	var/list/L = get_surgery_step(tool,user,target)
	if(L)
		var/datum/surgery_step/omni/S = null
		if(L.len == 1)
			var/datum/surgery_step/omni/val = L[1]
			S = new val.type
		else/*
			if(last_step.repeatable && locate(last_step.type) in L)
				S = new last_step.type
			else
			*/
			var/P = input("Begin which procedure?", "Surgery", null, null) as null|anything in sortList(L)
			if(P && user && user.Adjacent(target) && (tool in user))
				var/datum/surgery_step/omni/T = locate(P) in L // Why tf does L[P] not work here.
				for(var/datum/surgery/other in target.surgeries)
					if(other == src)
						continue
					if(other.location == user.zone_selected)
						return FALSE
				S = new T.type
		if(S.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
			last_step = S
			return TRUE
		if(tool && tool.item_flags & SURGICAL_TOOL) //Just because you used the wrong tool it doesn't mean you meant to whack the patient with it
			var/required_tool_type = TOOL_CAUTERY
			if(requires_bodypart_type == BODYTYPE_ROBOTIC)
				required_tool_type = TOOL_SCREWDRIVER

			if(tool.tool_behaviour == required_tool_type)
				// Cancel the surgery if a cautery is used AND it's not the tool used in the next step.
				attempt_cancel_surgery(src, tool, target, user)
				return TRUE
			to_chat(user, "<span class='warning'>Somethings wrong, I can feel it!</span>")
			return TRUE
	else if(tool && tool.item_flags & SURGICAL_TOOL)
		var/required_tool_type = TOOL_CAUTERY
		if(requires_bodypart_type == BODYTYPE_ROBOTIC)
			required_tool_type = TOOL_SCREWDRIVER
		if(tool.tool_behaviour == required_tool_type)
			attempt_cancel_surgery(src, tool, target, user)
			return TRUE
	return FALSE

/datum/surgery/omni/get_surgery_step(obj/item/tool,mob/user,mob/living/target)
	var/list/all_steps = GLOB.omnisurgerysteps_list.Copy()
	var/list/valid_steps = list()
	var/datum/surgery_step/omni/beststep = null
	for(var/datum/surgery_step/omni/S in all_steps)
		if(!S.show)
			continue
		if(!S.valid_locations.Find(location))
			continue
		if(S.required_layer != atlayer)
			continue
		if(!(S.accept_any_item || S.accept_hand) && !(S.implements.Find(tool.tool_behaviour) || S.implements.Find(tool)))
			continue
		if(!S.test_op(user,target))
			continue
		if(beststep == null)
			beststep = S
			valid_steps += list(S)
		else
			if(beststep.priority > S.priority)
				beststep = S
			valid_steps += list(S)
	if(beststep && valid_steps.len == 1)
		return list(beststep)
	else if (valid_steps.len > 1)
		return valid_steps
	return null
/datum/surgery/omni/get_surgery_next_step()
	return null
