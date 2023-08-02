/obj/item/clothing/neck
	name = "necklace"
	icon = 'icons/obj/clothing/neck.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	strip_delay = 40
	equip_delay_other = 40
	cuttable = TRUE
	clothamnt = 1
	greyscale_colors = list(list(15, 20), list(16, 21), list(14, 19))
	greyscale_icon_state = "scarf"

/obj/item/clothing/neck/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(body_parts_covered & HEAD)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")
			if(HAS_BLOOD_DNA(src))
				. += mutable_appearance('icons/effects/blood.dmi', "maskblood")

/obj/item/clothing/neck/tie
	name = "tie"
	desc = "A neosilk clip-on tie. Special material allows it to be reskinned by Alt-clicking it, but only once."
	icon = 'icons/obj/clothing/neck.dmi'
	unique_reskin = list("red tie" = "redtie",
						"orange tie" = "orangetie",
						"green tie" = "greentie",
						"light blue tie" = "lightbluetie",
						"blue tie" = "bluetie",
						"purple tie" = "purpletie",
						"black tie" = "blacktie",
						"orange tie" = "orangetie",
						"light blue tie" = "lightbluetie",
						"purple tie" = "purpletie",
						"green tie" = "greentie",
						"brown tie" = "browntie",
						"rainbow tie" = "rainbow_tie",
						"horrible tie" = "horribletie",
						"transgender tie" = "transgender",
						"pansexual tie" = "pansexual",
						"nonbinary tie" = "nonbinary",
						"bisexual tie" = "bisexual",
						"lesbian tie" = "lesbian",
						"intersex tie" = "intersex",
						"gay tie" = "gay",
						"genderfluid tie" = "genderfluid",
						"asexual tie" = "asexual",
						"genderfae tie" = "genderfae",
						"ally tie" = "ally_tie"
						)
	icon_state = "rainbow_tie"
	item_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = 60
	greyscale_colors = list(list(16, 20), list(16, 16), list(16, 18))
	greyscale_icon_state = "tie"

/obj/item/clothing/neck/tie/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/neck/tie/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/neck/tie/black
	name = "black tie"
	icon_state = "blacktie"
//
/obj/item/clothing/neck/tie/orange
	name = "orange tie"
	icon_state = "orangetie"

/obj/item/clothing/neck/tie/light_blue
	name = "light blue tie"
	icon_state = "lightbluetie"

/obj/item/clothing/neck/tie/purple
	name = "purple tie"
	icon_state = "purpletie"

/obj/item/clothing/neck/tie/green
	name = "green tie"
	icon_state = "greentie"

/obj/item/clothing/neck/tie/brown
	name = "brown tie"
	icon_state = "browntie"
//
/obj/item/clothing/neck/tie/rainbow
	name = "rainbow tie"
	icon_state = "rainbow_tie"

/obj/item/clothing/neck/tie/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"

/obj/item/clothing/neck/tie/detective
	name = "loose tie"
	desc = "A loosely tied necktie, a perfect accessory for the over-worked detective."
	icon_state = "detective"
	unique_reskin = null

/obj/item/clothing/neck/maid
	name = "maid neck cover"
	desc = "A neckpiece for a maid costume, it smells faintly of disappointment."
	icon_state = "maid_neck"

/obj/item/clothing/neck/tie/trans
	name = "transgender tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the trans flag."
	icon_state = "transgender"

/obj/item/clothing/neck/tie/pan
	name = "pansexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the pansexual flag."
	icon_state = "pansexual"

/obj/item/clothing/neck/tie/enby
	name = "nonbinary tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the nonbinary flag."
	icon_state = "nonbinary"

/obj/item/clothing/neck/tie/bi
	name = "bisexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the bisexual flag."
	icon_state = "bisexual"

/obj/item/clothing/neck/tie/lesbian
	name = "lesbian tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the lesbian flag."
	icon_state = "lesbian"

/obj/item/clothing/neck/tie/intersex
	name = "intersex tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the intersex flag."
	icon_state = "intersex"

/obj/item/clothing/neck/tie/gay
	name = "gay tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the gay flag."
	icon_state = "gay"

/obj/item/clothing/neck/tie/genderfluid
	name = "genderfluid tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the genderfluid flag."
	icon_state = "genderfluid"

/obj/item/clothing/neck/tie/asexual
	name = "asexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the asexual flag."
	icon_state = "asexual"

/obj/item/clothing/neck/tie/genderfae
	name = "genderfae tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the genderfae flag."
	icon_state = "genderfae"

/obj/item/clothing/neck/tie/ally_tie
	name = "ally tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the ally flag."
	icon_state = "ally_tie"

/obj/item/clothing/neck/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"
	cuttable = FALSE

/obj/item/clothing/neck/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == INTENT_HELP)
			var/body_part = parse_zone(user.zone_selected)

			var/heart_strength = "<span class='danger'>no</span>"
			var/lung_strength = "<span class='danger'>no</span>"

			var/obj/item/organ/heart/heart = M.getorganslot(ORGAN_SLOT_HEART)
			var/obj/item/organ/lungs/lungs = M.getorganslot(ORGAN_SLOT_LUNGS)

			if(!(M.stat == DEAD || (HAS_TRAIT(M, TRAIT_FAKEDEATH))))
				if(heart && istype(heart))
					heart_strength = "<span class='danger'>an unstable</span>"
					if(heart.beating)
						heart_strength = "a healthy"
				if(lungs && istype(lungs))
					lung_strength = "<span class='danger'>strained</span>"
					if(!(M.failed_last_breath || M.losebreath))
						lung_strength = "healthy"

			var/diagnosis = (body_part == BODY_ZONE_CHEST ? "You hear [heart_strength] pulse and [lung_strength] respiration." : "You faintly hear [heart_strength] pulse.")
			user.visible_message("<span class='notice'>[user] places [src] against [M]'s [body_part] and listens attentively.</span>", "<span class='notice'>You place [src] against [M]'s [body_part]. [diagnosis]</span>")
			return
	return ..(M,user)

///////////
//SCARVES//
///////////

/obj/item/clothing/neck/scarf //Default white color, same functionality as beanies.
	name = "white scarf"
	icon_state = "scarf"
	desc = "A stylish scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	dog_fashion = /datum/dog_fashion/head
	custom_price = 60

/obj/item/clothing/neck/scarf/black
	name = "black scarf"
	icon_state = "scarf"
	color = "#4A4A4B" //Grey but it looks black

/obj/item/clothing/neck/scarf/pink
	name = "pink scarf"
	icon_state = "scarf"
	color = "#F699CD" //Pink

/obj/item/clothing/neck/scarf/red
	name = "red scarf"
	icon_state = "scarf"
	color = "#D91414" //Red

/obj/item/clothing/neck/scarf/green
	name = "green scarf"
	icon_state = "scarf"
	color = "#5C9E54" //Green

/obj/item/clothing/neck/scarf/darkblue
	name = "dark blue scarf"
	icon_state = "scarf"
	color = "#1E85BC" //Blue

/obj/item/clothing/neck/scarf/purple
	name = "purple scarf"
	icon_state = "scarf"
	color = "#9557C5" //Purple

/obj/item/clothing/neck/scarf/yellow
	name = "yellow scarf"
	icon_state = "scarf"
	color = "#E0C14F" //Yellow

/obj/item/clothing/neck/scarf/orange
	name = "orange scarf"
	icon_state = "scarf"
	color = "#C67A4B" //Orange

/obj/item/clothing/neck/scarf/cyan
	name = "cyan scarf"
	icon_state = "scarf"
	color = "#54A3CE" //Cyan


//Striped scarves get their own icons

/obj/item/clothing/neck/scarf/zebra
	name = "zebra scarf"
	icon_state = "zebrascarf"

/obj/item/clothing/neck/scarf/christmas
	name = "christmas scarf"
	icon_state = "christmasscarf"

//Shemaghs to operate tactically in a operational tactical situation

/obj/item/clothing/neck/shemagh
	name = "shemagh"
	desc = "An oversized shemagh, for those with a keen sense of fashion, or those operating tactically."
	icon_state = "shemagh"

//The three following scarves don't have the scarf subtype
//This is because Ian can equip anything from that subtype
//However, these 4 don't have corgi versions of their sprites
/obj/item/clothing/neck/stripedredscarf
	name = "striped red scarf"
	icon_state = "stripedredscarf"
	custom_price = 10

/obj/item/clothing/neck/stripedgreenscarf
	name = "striped green scarf"
	icon_state = "stripedgreenscarf"
	custom_price = 10

/obj/item/clothing/neck/stripedbluescarf
	name = "striped blue scarf"
	icon_state = "stripedbluescarf"
	custom_price = 10

/obj/item/clothing/neck/stripedsolgovscarf
	name = "striped solgov scarf"
	icon_state = "stripedsolgovscarf"
	custom_price = 10

/obj/item/clothing/neck/petcollar
	name = "pet collar"
	desc = "It's for pets. But some people wear it anyways for reasons unknown."
	icon_state = "petcollar"
	greyscale_colors = list(list(16,21), list(16,19), list(16,19))
	greyscale_icon_state = "collar"
	var/tagname = null


/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/neck/necklace/dope
	name = "gold necklace"
	desc = "Damn, it feels good to be a gangster."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bling"
	cuttable = FALSE

/obj/item/clothing/neck/necklace/dope/merchant
	desc = "Don't ask how it works, the proof is in the holochips!"
	/// scales the amount received in case an admin wants to emulate taxes/fees.
	var/profit_scaling = 1
	/// toggles between sell (TRUE) and get price post-fees (FALSE)
	var/selling = FALSE

/obj/item/clothing/neck/necklace/dope/merchant/attack_self(mob/user)
	. = ..()
	selling = !selling
	to_chat(user, "<span class='notice'>[src] has been set to [selling ? "'Sell'" : "'Get Price'"] mode.</span>")

/obj/item/clothing/neck/necklace/dope/merchant/afterattack(obj/item/I, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/datum/export_report/ex = export_item_and_contents(I, allowed_categories = (ALL), dry_run=TRUE)
	var/price = 0
	for(var/x in ex.total_amount)
		price += ex.total_value[x]

	if(price)
		var/true_price = round(price*profit_scaling)
		to_chat(user, "<span class='notice'>[selling ? "Sold" : "Getting the price of"] [I], value: <b>[true_price]</b> credits[I.contents.len ? " (exportable contents included)" : ""].[profit_scaling < 1 && selling ? "<b>[round(price-true_price)]</b> credit\s taken as processing fee\s." : ""]</span>")
		if(selling)
			new /obj/item/holochip(get_turf(user),true_price)
			for(var/i in ex.exported_atoms_ref)
				var/atom/movable/AM = i
				if(QDELETED(AM))
					continue
				qdel(AM)
	else
		to_chat(user, "<span class='warning'>There is no export value for [I] or any items within it.</span>")


/obj/item/clothing/neck/neckerchief
	icon = 'icons/obj/clothing/masks.dmi' //In order to reuse the bandana sprite
	w_class = WEIGHT_CLASS_TINY
	var/sourceBandanaType

/obj/item/clothing/neck/neckerchief/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/realOverlay = mutable_appearance('icons/mob/clothing/mask.dmi', icon_state)
		realOverlay.pixel_y = -3
		. += realOverlay

/obj/item/clothing/neck/neckerchief/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.get_item_by_slot(ITEM_SLOT_NECK) == src)
			to_chat(user, "<span class='warning'>You can't untie [src] while wearing it!</span>")
			return
		if(user.is_holding(src))
			var/obj/item/clothing/mask/bandana/newBand = new sourceBandanaType(user)
			var/currentHandIndex = user.get_held_index_of_item(src)
			var/oldName = src.name
			qdel(src)
			user.put_in_hand(newBand, currentHandIndex)
			user.visible_message("<span class='notice'>You untie [oldName] back into a [newBand.name].</span>", "<span class='notice'>[user] unties [oldName] back into a [newBand.name].</span>")
		else
			to_chat(user, "<span class='warning'>You must be holding [src] in order to untie it!</span>")

/obj/item/clothing/neck/beads
	name = "plastic bead necklace"
	desc = "A cheap, plastic bead necklace. Show team spirit! Collect them! Throw them away! The posibilites are endless!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "beads"
	color = "#ffffff"
	custom_price = 10
	custom_materials = (list(/datum/material/plastic = 500))
	cuttable = FALSE

/obj/item/clothing/neck/beads/Initialize()
	. = ..()
	color = color = pick("#ff0077","#d400ff","#2600ff","#00ccff","#00ff2a","#e5ff00","#ffae00","#ff0000", "#ffffff")

/obj/item/clothing/neck/crystal_amulet
	name = "crystal amulet"
	desc = "A mysterious amulet which protects the user from hits, at the cost of itself."
	icon_state = "crystal_talisman"
	cuttable = FALSE
	var/shield_state = "shieldsparkles"
	var/shield_on = "shieldsparkles"
	var/damage_to_take_on_hit = 40 //every time the owner is hit, how much damage to give to the amulet?


//This is copied and pasted from the shield harsuit code, any issues here are also a issue there. Should I have done this? No, i shouldn't. Should this be a component? Yes, most likely. Do i want to touch DCS ever again? No.

/obj/item/clothing/neck/crystal_amulet/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/datum/effect_system/spark_spread/quantum/spark_creator = new
	spark_creator.set_up(2, 1, src)
	spark_creator.start()
	owner.visible_message("<span class='danger'>[owner]'s shields deflect [attack_text] in a shower of sparks!</span>")
	take_damage(damage_to_take_on_hit)
	playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
	return TRUE

/obj/item/clothing/neck/crystal_amulet/examine(mob/user)
	. = ..()
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			. += "It looks slightly damaged."
		if(25 to 50)
			. += "It appears heavily damaged."
		if(0 to 25)
			. += "<span class='warning'>It's falling apart!</span>"

/obj/item/clothing/neck/crystal_amulet/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_state, MOB_LAYER + 0.01)

/obj/item/clothing/neck/crystal_amulet/obj_destruction(damage_flag)
	visible_message("<span class='danger'>[src] shatters into a million pieces!</span>")
	playsound(src,"shatter", 70)
	new /obj/effect/decal/cleanable/glass/strange(get_turf(src))
	return ..()
