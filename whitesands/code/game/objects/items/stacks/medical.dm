// SPLINTS
/obj/item/stack/medical/splint
	amount = 2
	name = "splints"
	desc = "Used to secure limbs following a fracture."
	gender = PLURAL
	singular_name = "splint"
	icon = 'whitesands/icons/obj/items_and_weapons.dmi'
	icon_state = "splint"
	self_delay = 40
	other_delay = 15
	splint_factor = 0.15

/obj/item/stack/medical/splint/heal(mob/living/M, mob/user)
	. = ..()
	if(iscarbon(M))
		return heal_carbon(M, user)
	to_chat(user, "<span class='warning'>You can't splint [M]'s limb' with the \the [src]!</span>")

/obj/item/stack/medical/splint/ghetto //slightly shittier, but gets the job done
	name = "makeshift splints"
	desc = "Used to secure limbs following a fracture. This one is made out of simple materials."
	amount = 1
	self_delay = 50
	other_delay = 20
	splint_factor = 0.25

/obj/item/stack/medical/bruise_pack/herb
	name = "ashen herbal pack"
	singular_name = "ashen herbal pack"
	desc = "Thereputic herbs designed to treat bruises."

/obj/item/stack/medical/ointment/herb
	name = "burn ointment slurry"
	singular_name = "burn ointment slurry"
	desc = "Herb slurry meant to treat burns."
