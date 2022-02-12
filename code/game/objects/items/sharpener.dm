/obj/item/sharpener
	name = "whetstone"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "sharpener"
	desc = "A block that makes things sharp."
	force = 5
	var/increment = 4
	var/blockincrement = 0
	var/apincrement = 0
	var/toolincrement = 0//subtract by decimal percentages for best effect, if trying to upgrade
	var/max = 30
	var/prefix = "sharpened"
	var/requires_sharpness = 1
	var/used = 0
	var/stackable = FALSE//for effects that can be applied multiple times, set to TRUE
	var/modify_text = "sharpen"//used in the flavour when sharpening items
	var/use_noise = 'sound/items/unsheath.ogg'
	var/postfix = null//allows special modifiers to give an RPG-style postfix instead, helps with name crowding

/obj/item/sharpener/attackby(obj/item/I, mob/user, params)
	if(used)
		if(requires_sharpness == 1)
			to_chat(user, "<span class='warning'>The [src] is too worn to use again!</span>")
			return
		else
			to_chat(user, "<span class='warning'>The [src] has already been used up!</span>")
			return
	if(I.force >= max || I.throwforce >= max)
		to_chat(user, "<span class='warning'>[I] is much too powerful to improve further!</span>")
		return
	if(requires_sharpness && !I.get_sharpness())
		to_chat(user, "<span class='warning'>You can only sharpen items that are already sharp, such as knives!</span>")
		return
	if(istype(I, /obj/item/melee/transforming/energy))//no esword sharpening
		to_chat(user, "<span class='warning'>You don't think \the [I] will be the thing getting modified if you use it on \the [src]!</span>")
		return

	var/signal_out = SEND_SIGNAL(I, COMSIG_ITEM_SHARPEN_ACT, increment, max)
	if(signal_out & COMPONENT_BLOCK_SHARPEN_MAXED)
		to_chat(user, "<span class='warning'>The [src] wouldn't be of any use on the [I]...</span>")
		return
	if(signal_out & COMPONENT_BLOCK_SHARPEN_BLOCKED)
		to_chat(user, "<span class='warning'>[I] is not able to be modified right now!</span>")
		return
	if(I.mods == maxmodify || !stackable)
		if((signal_out & COMPONENT_BLOCK_SHARPEN_ALREADY) || (I.force > initial(I.force) && !signal_out))
			to_chat(user, "<span class='warning'>[I] cannot be improved further with the [src]!</span>")
			return
	if(!(signal_out & COMPONENT_BLOCK_SHARPEN_APPLIED))
		I.force = clamp(I.force + increment, 0, max)
	if(requires_sharpness == 1)
		playsound(src, use_noise, 25, TRUE)
		user.visible_message("<span class='notice'>[user] sharpens [I] with [src]!</span>", "<span class='notice'>You sharpen [I], honing it to higher levels of deadliness.</span>")
	else
		playsound(src, use_noise, 25, TRUE)
		user.visible_message("<span class='notice'>[user] [modify_text]s [src] the [I]!</span>", "<span class='notice'>You [modify_text] [I] with the [src].</span>")

	if(requires_sharpness == 1)
		I.sharpness = IS_SHARP_ACCURATE
	I.throwforce = clamp(I.throwforce + increment, 0, max)
	I.block_chance = clamp(I.block_chance + blockincrement, 0, 50)
	I.armour_penetration = clamp(I.armour_penetration + apincrement, 0, 75)
	I.mods = clamp(I.mods + 1, 0, I.maxmodify)
	I.toolspeed = clamp(I.toolspeed + toolincrement, 0.1, 4)
	if(I.postfixed == TRUE)
		if(!findtext(I.name, prefix))
			I.name = "[prefix] [I.name]"
	else
		if(prob(50))
			if(!findtext(I.name, postfix))
				I.name = "[I.name] [postfix]"
			I.postfixed = TRUE
		else
			if(!findtext(I.name, prefix))
				I.name = "[prefix] [I.name]"
	name = "used [name]"
	desc = "[desc] At least, it used to."
	used = 1
	update_icon()

/obj/item/sharpener/super
	name = "super whetstone"
	desc = "A block of diamond-grit nanolaminate sharpening material, capable of honing objects to incredible levels."
	increment = 15
	apincrement = 5
	max = 100
	prefix = "honed"
	requires_sharpness = 1
	modify_text = "carefully sharpen"
	postfix = null

/obj/item/sharpener/mega//admin sharpener, makes any object an instakill weapon
	name = "mega whetstone"
	desc = "A block of advanced adminium. This will make your weapon sharper than Einstein on adderall."
	increment = 999
	max = 999
	blockincrement = 100
	apincrement = 100
	prefix = "coder-refracted"
	requires_sharpness = 0
	stackable = TRUE
	modify_text = "IMPOSSIBLY EMPOWER"
	postfix = "of divine judgement"

/obj/item/sharpener/improvised
	name = "wooden whetstone"
	desc = "A block of soft wood, useful for crude sharpening of edged weapons."
	color = "#8c6340"
	increment = 2
	max = 18
	prefix = "crudely-sharpened"
	requires_sharpness = 1
	stackable = TRUE
	modify_text = "crudely sharpen"
	postfix = null

/obj/item/sharpener/bone
	name = "bone whetstone"
	desc = "A block of compacted bone, useful for sharpening melee weapons on the fly."
	color = "#bfb78c"
	increment = 4
	max = 25
	prefix = "bone-scraped"
	postfix = null
	requires_sharpness = 1
	stackable = TRUE
	modify_text = "scrape"

/obj/item/sharpener/cloth
	name = "Cleaning Rag"
	desc = "A high-grit industrial cloth, designed for polishing and scraping grime off various well-loved objects. Everything works a little better when it's been recently cleaned."
	toolincrement = -0.5
	prefix = "spotless"
	postfix = null
	requires_sharpness = 0
	modify_text = "thoroughly scrub"
	use_noise = 'sound/items/handling/cloth_drop.ogg'

//elemental and special modifications
/obj/item/sharpener/venom
	name = "Tsuchigumo"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "venomphial"
	desc = "A strange, seemingly mystical oil, once poured on the metal blades of members of the Spider Clan. In recent years, their Hoshi Ninjatsu have largely switched to energy weapons, making such vials a valulable relic."
	apincrement = 15
	increment = 2
	max = 100
	prefix = "spiderbitten"
	postfix = "of poison"
	requires_sharpness = 0
	modify_text = "envenom"
	use_noise = 'sound/effects/footstep/water1.ogg'

/obj/item/sharpener/venom/update_icon_state()
	icon_state = "venomphial[used ? "_used" : ""]"

/obj/item/sharpener/venom/attackby(obj/item/I, mob/user, params)
	..()
	if(I.poisoned == FALSE)
		I.poisoned = TRUE
		I.poisonpower = clamp(I.poisonpower + 1, 0, 50)
		I.stabpoison = /datum/reagent/toxin/venom
	else
		I.poisonpower = clamp(I.poisonpower + 3, 0, 50)//improvest potency of other poisoned weapons
		I.damtype = TOX
	return

/obj/item/sharpener/ghost
	name = "Spectral Plasm"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ghostphial"
	desc = "A glowing vial of oily, pale liquid, seeming to softly shimmer in a translucent dance. It beckons you to uncork it and spread it over a weapon."
	apincrement = 15
	increment = 10
	max = 100
	prefix = "possessed"
	postfix = "of spectres"
	requires_sharpness = 0
	modify_text = "haunt"
	stackable = TRUE
	use_noise = 'sound/effects/curse3.ogg'

/obj/item/sharpener/ghost/update_icon_state()
	icon_state = "ghostphial[used ? "_used" : ""]"

/obj/item/sharpener/ghost/attackby(obj/item/I, mob/user, params)
	..()
	I.haunted = TRUE
	return

/obj/item/sharpener/fire
	name = "Infernum Oil"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "firephial"
	desc = "A softly-glowing vial of white-hot liquid, fuming and softly steaming. It beckons you to uncork it and spread it over a weapon."
	max = 100
	increment = 5
	prefix = "fuming"
	postfix = "of hellfire"
	requires_sharpness = 0
	modify_text = "kindle"
	use_noise = 'sound/magic/fireball.ogg'
	stackable = TRUE

/obj/item/sharpener/fire/update_icon_state()
	icon_state = "firephial[used ? "_used" : ""]"

/obj/item/sharpener/fire/attackby(obj/item/I, mob/user, params)
	..()
	if(burner == FALSE)
		I.burner = TRUE
		I.burnpower = clamp(I.burnpower + 3, 0, 10)
	else
		I.burnpower = clamp(I.burnpower + 3, 0, 15)
	return

/obj/item/sharpener/frost
	name = "Extract of Boreas"
	desc = "A softly tinkling bottle, seemingly filled with a thick fluid in which blows a mighty winter wind. It beckons you to uncork it and spread it over a weapon."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "freezephial"
	apincrement = 10
	increment = 5
	max = 100
	prefix = "frostbitten"
	postfix = "of hypothermia"
	requires_sharpness = 0
	modify_text = "deep-freeze"
	use_noise = 'sound/weather/ashstorm/inside/weak_end.ogg'
	stackable = TRUE

/obj/item/sharpener/frost/update_icon_state()
	icon_state = "freezephial[used ? "_used" : ""]"

/obj/item/sharpener/frost/attackby(obj/item/I, mob/user, params)
	..()
	if(freezer == FALSE)
		I.freezer = TRUE
		I.freezepower = clamp(I.freezepower + 1, 0, 10)
	else
		I.freezepower = clamp(I.freezepower + 3, 0, 10)
	return

/obj/item/sharpener/bleed
	name = "The Old Blood"
	desc = "A dusty bottle, full of thick, maroon liquid. It beckons you to uncork it and spread it over a weapon."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "bloodphial"
	apincrement = 5
	increment = 5
	max = 100
	prefix = "serrated"
	postfix = "of bloodlust"
	requires_sharpness = 0
	modify_text = "sanguinate"
	use_noise = 'sound/effects/footstep/water1.ogg'
	stackable = TRUE

/obj/item/sharpener/bleed/update_icon_state()
	icon_state = "bloodphial[used ? "_used" : ""]"

/obj/item/sharpener/bleed/attackby(obj/item/I, mob/user, params)
	..()
	if(serrated == FALSE)
		I.serrated = TRUE
		I.bleedpower = clamp(I.bleedpower + 1, 0, 10)
	else
		I.bleedpower = clamp(I.bleedpower + 4, 0, 10)
	return

/obj/item/sharpener/speed
	name = "Wind of Zephyrus"
	desc = "A phial containing a mighty wind, preserved in liquor. By pouring it over an item, you can harness it's power to make your strikes fly lighter, but far faster.."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "windphial"
	apincrement = -5//hits become lighter
	increment = -10
	max = 100
	prefix = "whirling"
	postfix = "of dervish"
	requires_sharpness = 0
	modify_text = "suffuse"
	use_noise = 'sound/effects/footstep/water1.ogg'
	stackable = TRUE

/obj/item/sharpener/speed/update_icon_state()
	icon_state = "windphial[used ? "_used" : ""]"

/obj/item/sharpener/speed/attackby(obj/item/I, mob/user, params)
	..()
	I.attackspeed = clamp(I.attackspeed * 0.7, 0.1, 2)
	return

/obj/item/sharpener/holy
	name = "runeword"
	desc = "A fragment of a forgotten god's true name. Could be infused upon a weapon."
	apincrement = 5
	increment = 10
	blockincrement = 25
	max = 100
	prefix = "runed"
	postfix = "of warding"
	requires_sharpness = 0
	modify_text = "inlay"
	use_noise = 'sound/magic/smoke.ogg'
	stackable = TRUE
	icon = 'icons/obj/wizard.dmi'
	icon_state = "runescroll"
	stackable = TRUE

/obj/item/sharpener/holy/update_icon_state()
	icon_state = "runescroll[used ? "_used" : ""]"

/obj/item/sharpener/holy/attackby(obj/item/I, mob/user, params)
	..()
	if(overlayed == FALSE)
		I.overlayed = TRUE
		I.effect_icon = "shield-old"
		I.AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)
	return
