// SPLINTS
/obj/item/stack/medical/splint
	name = "splints"
	desc = "Used to secure limbs following a fracture."
	gender = PLURAL
	singular_name = "splint"
	icon = 'whitesands/icons/obj/items_and_weapons.dmi'
	icon_state = "splint"
	self_delay = 5 SECONDS
	other_delay = 2 SECONDS
	max_amount = 12
	amount = 6
	grind_results = list(/datum/reagent/carbon = 2)
	merge_type = /obj/item/stack/medical/splint
	var/splint_type = /datum/bodypart_aid/splint


/obj/item/stack/medical/splint/try_heal(mob/living/M, mob/user, silent)
	var/obj/item/bodypart/limb = M.get_bodypart(check_zone(user.zone_selected))
	if(!limb)
		to_chat(user, "<span class='notice'>There's nothing there to bandage!</span>")
		return
	if(!LAZYLEN(limb.wounds))
		to_chat(user, "<span class='notice'>There's no wounds that require bandaging on [user==M ? "your" : "[M]'s"] [limb.name]!</span>") // good problem to have imo
		return

	var/splintable_wound = FALSE
	for(var/i in limb.wounds)
		var/datum/wound/woundies = i
		if(woundies.wound_flags & ACCEPTS_SPLINT)
			splintable_wound = TRUE
			break
	if(!splintable_wound)
		to_chat(user, "<span class='notice'>There's no wounds that require splinting on [user==M ? "your" : "[M]'s"] [limb.name]!</span>") // good problem to have imo
		return

	if(limb.current_splint)
		to_chat(user, "<span class='warning'>[user==M ? "Your" : "[M]'s"] [limb.name] is already fastened in a splint!</span>")
		return

	user.visible_message("<span class='warning'>[user] begins fastening [M]'s [limb.name] with [src]...</span>", "<span class='warning'>You begin to fasten [user == M ? "your" : "[M]'s"] [limb.name] with [src]...</span>")
	if(!do_after(user, (user == M ? self_delay : other_delay), target=M))
		return

	user.visible_message("<span class='green'>[user] applies [src] to [M]'s [limb.name].</span>", "<span class='green'>You splint [user == M ? "your" : "[M]'s"] [limb.name].</span>")
	limb.apply_splint(src)

/obj/item/stack/medical/splint/twelve
	amount = 12

/obj/item/stack/medical/splint/tribal
	name = "tribal splint"
	desc = "Bone fastened with sinew, used to keep injured limbs rigid, surprisingly effective."
	singular_name = "tribal splint"
	icon_state = "splint_tribal"
	amount = 1
	splint_type = /datum/bodypart_aid/splint/tribal
	merge_type = /obj/item/stack/medical/splint/tribal

/obj/item/stack/medical/splint/improvised
	name = "improvised splint"
	desc = "Crudely made out splints with wood and some cotton sling, you doubt this will be any good."
	singular_name = "improvised splint"
	icon_state = "splint_improv"
	amount = 1
	splint_type = /datum/bodypart_aid/splint/improvised
	merge_type = /obj/item/stack/medical/splint/improvised

/obj/item/stack/medical/bruise_pack/herb
	name = "ashen herbal pack"
	singular_name = "ashen herbal pack"
	desc = "Thereputic herbs designed to treat bruises."

/obj/item/stack/medical/ointment/herb
	name = "burn ointment slurry"
	singular_name = "burn ointment slurry"
	desc = "Herb slurry meant to treat burns."
