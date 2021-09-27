/obj/item/gauze_injector
	name = "gauze injector"
	desc = "Stops bleeding in deep puncture wounds."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "medipen"
	item_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	item_flags = NOBLUDGEON | NO_MAT_REDEMPTION
	grind_results = list(/datum/reagent/cellulose = 10)

	var/blood_capacity = 300

/obj/item/gauze_injector/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to choke on \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return OXYLOSS

/obj/item/gauze_injector/update_icon_state()
	if(blood_capacity != 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"
