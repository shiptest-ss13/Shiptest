/obj/item/gun/energy/laser/iot/Initialize()
	. = ..()
	if(NTOS_type)
		integratedNTOS = new NTOS_type(src)
		integratedNTOS.enabled = TRUE

/obj/item/gun/energy/laser/iot/attack_self(mob/user)
	if(!integratedNTOS)
		return
	integratedNTOS.interact(user)
