//extract implant (CREATE A TOOL SPECIFICALLY TO DO THIS PLEASE or just add in forceps [when you sprite it])
/datum/surgery_step/omni/extract_implant
	name = "Extract implant"
	implements = list(
		//TOOL_HEMOSTAT = 100,
		//TOOL_CROWBAR = 40,
		///obj/item/kitchen/fork = 33
		)
	time = 6.4 SECONDS
	success_sound = 'sound/surgery/hemostat1.ogg'
	experience_given = MEDICAL_SKILL_MEDIUM
	var/obj/item/implant/I = null
	required_layer = list(3)
	show = TRUE
	valid_locations = list(BODY_ZONE_CHEST)

/datum/surgery_step/omni/extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/O in target.implants)
		I = O
		break
	if(I)
		display_results(user, target, "<span class='notice'>You begin to extract [I] from [target]'s [target_zone]...</span>",
			"<span class='notice'>[user] begins to extract [I] from [target]'s [target_zone].</span>",
			"<span class='notice'>[user] begins to extract something from [target]'s [target_zone].</span>")
	else
		display_results(user, target, "<span class='notice'>You look for an implant in [target]'s [target_zone]...</span>",
			"<span class='notice'>[user] looks for an implant in [target]'s [target_zone].</span>",
			"<span class='notice'>[user] looks for something in [target]'s [target_zone].</span>")

/datum/surgery_step/omni/extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(I)
		display_results(user, target, "<span class='notice'>You successfully remove [I] from [target]'s [target_zone].</span>",
			"<span class='notice'>[user] successfully removes [I] from [target]'s [target_zone]!</span>",
			"<span class='notice'>[user] successfully removes something from [target]'s [target_zone]!</span>")
		I.removed(target)

		var/obj/item/implantcase/case
		for(var/obj/item/implantcase/ic in user.held_items)
			case = ic
			break
		if(!case)
			case = locate(/obj/item/implantcase) in get_turf(target)
		if(case && !case.imp)
			case.imp = I
			I.forceMove(case)
			case.update_appearance()
			display_results(user, target, "<span class='notice'>You place [I] into [case].</span>",
				"<span class='notice'>[user] places [I] into [case]!</span>",
				"<span class='notice'>[user] places it into [case]!</span>")
		else
			qdel(I)

	else
		to_chat(user, "<span class='warning'>You can't find anything in [target]'s [target_zone]!</span>")
	return ..()
