/datum/component/storage/concrete/fish_case
	max_items = 1
	can_hold_trait = TRAIT_FISH_CASE_COMPATIBILE
	can_hold_description = "fish and aquarium equipment"

/datum/component/storage/concrete/fish_case/live/can_be_inserted(/obj/item/fish/I, stop_messages, mob/M)
	. = ..()
	var/status = I.status
	if(!status == FISH_ALIVE)
		if (!stop_messages)
			to_chat(M, "<span class='warning'>[parent] only accepts live fish!</span>")
		return FALSE
