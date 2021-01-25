/obj/item/storage/fancy/cigarettes/derringer
	name = "\improper Robust packet"
	desc = "Smoked by the robust."
	icon_state = "robust"
	spawn_type = /obj/item/gun/ballistic/derringer/traitor

/obj/item/storage/fancy/cigarettes/derringer/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.set_holdable(list(/obj/item/clothing/mask/cigarette, /obj/item/lighter, /obj/item/gun/ballistic/derringer, /obj/item/ammo_casing/a357))

/obj/item/storage/fancy/cigarettes/derringer/AltClick(mob/living/carbon/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	var/obj/item/W = (locate(/obj/item/ammo_casing/a357) in contents) || (locate(/obj/item/clothing/mask/cigarette) in contents) //Easy access smokes and bullets
	if(W && contents.len > 0)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, W, user)
		user.put_in_hands(W)
		contents -= W
		to_chat(user, "<span class='notice'>You take \a [W] out of the pack.</span>")
	else
		to_chat(user, "<span class='notice'>There are no items left in the pack.</span>")

/obj/item/storage/fancy/cigarettes/derringer/PopulateContents()
	new spawn_type(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/clothing/mask/cigarette/syndicate(src)

//For traitors with luck/class
/obj/item/storage/fancy/cigarettes/derringer/gold
	name = "\improper Robust Gold packet"
	desc = "Smoked by the truly robust."
	icon_state = "robustg"
	spawn_type = /obj/item/gun/ballistic/derringer/gold
