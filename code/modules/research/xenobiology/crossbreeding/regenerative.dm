/*
Regenerative extracts:
	Work like a legion regenerative core.
	Has a unique additional effect.
*/
/obj/item/slimecross/regenerative
	name = "regenerative extract"
	desc = "It's filled with a milky substance, and pulses like a heartbeat."
	effect = "regenerative"
	icon_state = "regenerative"

	var/oxy_loss = 0
	var/tox_loss = 0
	var/fire_loss = 0
	var/brute_loss = 0
	var/stamina_loss = 0
	var/blood_loss = 100
	var/organ_loss = 3
	var/slime_heal_modifier = 1 //Specialised types only heal half
	var/jelly_amount = 7.5
	var/bone_loss = FALSE
	var/life_loss = FALSE
	var/slime_delay = 10

/obj/item/slimecross/regenerative/proc/core_effect(mob/living/carbon/human/target, mob/user)
	return
/obj/item/slimecross/regenerative/proc/core_effect_before(mob/living/carbon/human/target, mob/user)
	return

/obj/item/slimecross/regenerative/afterattack(atom/target,mob/user,prox)
	. = ..()
	if(!prox || !isliving(target))
		return
	var/mob/living/H = target
	if(H.stat == DEAD && life_loss)
		slime_delay = 200 //Reviving the dead takes a while, 20 seconds to be exact
		to_chat(user, "<span class='warning'>You begin using the [src] to try and bring [H] back from the dead...</span>")
	else
		slime_delay = 10
	if(H.stat == DEAD && !life_loss) // Won't revive the dead, except for specific extracts
		to_chat(user, "<span class='warning'>[src] will not work on the dead!</span>")
		return
	if(H != user)
		if(!do_mob(user, H, slime_delay)) // 1 second delay
			return FALSE
		user.visible_message("<span class='notice'>[user] crushes the [src] over [H], the milky goo quickly regenerating some of [H.p_their()] injuries!</span>",
			"<span class='notice'>You squeeze the [src], and it bursts over [H], the milky goo regenerating some of [H.p_their()] injuries.</span>")
	else
		if(!do_mob(user, H, (slime_delay * 1.5))) // 1.5 second delay
			return FALSE
		user.visible_message("<span class='notice'>[user] crushes the [src] over [user.p_them()]self, the milky goo quickly regenerating some of [user.p_their()] injuries!</span>",
			"<span class='notice'>You squeeze the [src], and it bursts in your hand, splashing you with milky goo which quickly regenerates some of your injuries!</span>")
// Slimes are good at healing clone damage, but don't heal other damage types as much. Additionally heals 15 organ damage.
	core_effect_before(H, user) // can affect heal multiplier
	oxy_loss = (12.5 + (H.getOxyLoss() * 0.4 * slime_heal_modifier))
	tox_loss = (12.5 + (H.getToxLoss() * 0.4 * slime_heal_modifier))
	fire_loss = (12.5 + (H.getFireLoss() * 0.4 * slime_heal_modifier))
	brute_loss = (12.5 + (H.getBruteLoss() * 0.4 * slime_heal_modifier))
	stamina_loss = (12.5 + (H.getStaminaLoss() * 0.5 * slime_heal_modifier))
	core_effect(H, user) // can affect specific healing values
	H.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,jelly_amount) // Splits the healing effect across an instant heal, and a smaller heal after.
	H.specific_heal(brute_amt = brute_loss, fire_amt = fire_loss, tox_amt = tox_loss, oxy_amt = oxy_loss, stam_amt = stamina_loss, organ_amt = organ_loss, clone_amt = 100, blood_amt = blood_loss, specific_bones = bone_loss, specific_revive = life_loss)
	playsound(target, 'sound/effects/splat.ogg', 40, TRUE)
	qdel(src)

/obj/item/slimecross/regenerative/grey
	colour = "grey" //Has no bonus effect.
	effect_desc = "Partially heals the target and does nothing else."

/obj/item/slimecross/regenerative/orange
	colour = "orange"

/obj/item/slimecross/regenerative/orange/core_effect_before(mob/living/target, mob/user)
	target.visible_message("<span class='warning'>The [src] boils over!</span>")
	for(var/turf/turf in range(1,target))
		if(!locate(/obj/effect/hotspot) in turf)
			new /obj/effect/hotspot(turf)

/obj/item/slimecross/regenerative/purple
	colour = "purple"
	effect_desc = "Weakly heals the target, but treats toxin damage especially well. Additionally injects them with some additional regen jelly."

/obj/item/slimecross/regenerative/purple/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.75

/obj/item/slimecross/regenerative/purple/core_effect(mob/living/target, mob/user)
	tox_loss = (10 + (target.getBruteLoss() * 0.8))
	jelly_amount += 10

/obj/item/slimecross/regenerative/blue
	colour = "blue"
	effect_desc = "Weakly heals the target, but extra effective at treating burns. Additionally makes the floor wet."

/obj/item/slimecross/regenerative/blue/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.5

/obj/item/slimecross/regenerative/blue/core_effect(mob/living/target, mob/user)
	if(isturf(target.loc))
		var/turf/open/T = get_turf(target)
		T.MakeSlippery(TURF_WET_WATER, min_wet_time = 10, wet_time_to_add = 5)
		target.visible_message("<span class='warning'>The milky goo in the extract gets all over the floor!</span>")
	fire_loss = (10 + (target.getFireLoss() * 0.8))
	jelly_amount *= 0.2

/obj/item/slimecross/regenerative/metal
	colour = "metal"
	effect_desc = "Barely heals the target, but fixes their bones .Additionally encases the target in a locker."

/obj/item/slimecross/regenerative/metal/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.1

/obj/item/slimecross/regenerative/metal/core_effect(mob/living/target, mob/user)
	target.visible_message("<span class='warning'>The milky goo hardens and reshapes itself, encasing [target]!</span>")
	var/obj/structure/closet/C = new /obj/structure/closet(target.loc)
	C.name = "slimy closet"
	C.desc = "Looking closer, it seems to be made of a sort of solid, opaque, metal-like goo."
	target.forceMove(C)
	bone_loss = TRUE
	jelly_amount *= 0.2

/obj/item/slimecross/regenerative/yellow
	colour = "yellow"
	effect_desc = "Partially heals the target, can revive the dead. additionally Partially recharges a single item on the target."
	life_loss = TRUE //Will revive the dead. Heals normally unless target is dead, in which case it heals less.

/obj/item/slimecross/regenerative/yellow/core_effect_before(mob/living/target, mob/user)
	if(target.stat == DEAD)
		slime_heal_modifier = 0.1 //use surgery to fix wounds
	else
		slime_heal_modifier = 0.75 //discourages spamming these to revive a target, combine with other cores

/obj/item/slimecross/regenerative/yellow/core_effect(mob/living/target, mob/user)
	var/list/batteries = list()
	for(var/obj/item/stock_parts/cell/C in target.GetAllContents())
		if(C.charge < C.maxcharge)
			batteries += C
	if(batteries.len)
		var/obj/item/stock_parts/cell/ToCharge = pick(batteries)
		ToCharge.charge = ToCharge.maxcharge
		to_chat(target, "<span class='notice'>You feel a strange electrical pulse, and one of your electrical items was recharged.</span>")
	if(target.stat == DEAD)
		blood_loss = 100
		organ_loss = 30 // More effective at fixing organs if the target is dead
		jelly_amount *= 0.2
		target.visible_message("<span class='warning'>The [src] sparks as it tries to revive [target]!</span>")

/obj/item/slimecross/regenerative/darkpurple
	colour = "dark purple"
	effect_desc = "Partially heals the target and gives them purple clothing if they are naked."

/obj/item/slimecross/regenerative/darkpurple/core_effect(mob/living/target, mob/user)
	var/equipped = 0
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/purple(null), ITEM_SLOT_FEET)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightpurple(null), ITEM_SLOT_ICLOTHING)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/purple(null), ITEM_SLOT_GLOVES)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/head/soft/purple(null), ITEM_SLOT_HEAD)
	if(equipped > 0)
		target.visible_message("<span class='notice'>The milky goo congeals into clothing!</span>")

/obj/item/slimecross/regenerative/darkblue
	colour = "dark blue"
	effect_desc = "Partially heals the target and fireproofs their clothes."

/obj/item/slimecross/regenerative/darkblue/core_effect(mob/living/target, mob/user)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	var/fireproofed = FALSE
	if(H.get_item_by_slot(ITEM_SLOT_OCLOTHING))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		fireproof(C)
	if(H.get_item_by_slot(ITEM_SLOT_HEAD))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_HEAD)
		fireproof(C)
	if(fireproofed)
		target.visible_message("<span class='notice'>Some of [target]'s clothing gets coated in the goo, and turns blue!</span>")

/obj/item/slimecross/regenerative/darkblue/proc/fireproof(obj/item/clothing/C)
	C.name = "fireproofed [C.name]"
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#000080", FIXED_COLOUR_PRIORITY)
	C.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	C.heat_protection = C.body_parts_covered
	C.resistance_flags |= FIRE_PROOF

/obj/item/slimecross/regenerative/silver
	colour = "silver"
	effect_desc = "Partially heals the target and makes their belly feel round and full."

/obj/item/slimecross/regenerative/silver/core_effect(mob/living/target, mob/user)
	target.set_nutrition(NUTRITION_LEVEL_FULL - 1)
	to_chat(target, "<span class='notice'>You feel satiated.</span>")

/obj/item/slimecross/regenerative/bluespace
	colour = "bluespace"
	effect_desc = "Partially heals the target and teleports them to where this core was created."
	var/turf/open/T

/obj/item/slimecross/regenerative/bluespace/core_effect(mob/living/target, mob/user)
	target.visible_message("<span class='warning'>[src] disappears in a shower of sparks!</span>","<span class='danger'>The milky goo teleports you somewhere it remembers!</span>")
	do_sparks(5,FALSE,target)
	target.forceMove(T)
	do_sparks(5,FALSE,target)

/obj/item/slimecross/regenerative/bluespace/Initialize()
	. = ..()
	T = get_turf(src)

/obj/item/slimecross/regenerative/sepia
	colour = "sepia"
	effect_desc = "Partially heals the target and stops time."

/obj/item/slimecross/regenerative/sepia/core_effect_before(mob/living/target, mob/user)
	to_chat(target, "<span class=notice>You try to forget how you feel.</span>")
	target.AddComponent(/datum/component/dejavu)

/obj/item/slimecross/regenerative/cerulean
	colour = "cerulean"
	effect_desc = "Slightly heals the target, but provides a boost of oxygen for a while. Additionally makes a second regenerative core with no special effects."

/obj/item/slimecross/regenerative/cerulean/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.5

/obj/item/slimecross/regenerative/cerulean/core_effect(mob/living/target, mob/user)
	src.forceMove(user.loc)
	var/obj/item/slimecross/X = new /obj/item/slimecross/regenerative(user.loc)
	X.name = name
	X.desc = desc
	user.put_in_active_hand(X)
	oxy_loss = 150
	target.reagents.add_reagent(/datum/reagent/medicine/salbutamol,15) //Similar to the luminescent effect, lets you breathe without oxygen for a while.
	to_chat(user, "<span class='notice'>Some of the milky goo congeals in your hand!</span>")

/obj/item/slimecross/regenerative/pyrite
	colour = "pyrite"
	effect_desc = "Partially heals and randomly colors the target."

/obj/item/slimecross/regenerative/pyrite/core_effect(mob/living/target, mob/user)
	target.visible_message("<span class='warning'>The milky goo coating [target] leaves [target.p_them()] a different color!</span>")
	target.add_atom_colour(rgb(rand(0,255),rand(0,255),rand(0,255)),WASHABLE_COLOUR_PRIORITY)

/obj/item/slimecross/regenerative/red
	colour = "red"
	effect_desc = "Slightly heals the target and injects them with a lot of blood, what a rush!"

/obj/item/slimecross/regenerative/red/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.5

/obj/item/slimecross/regenerative/red/core_effect(mob/living/target, mob/user)
	to_chat(target, "<span class='notice'>You feel... <i>faster.</i></span>")
	target.reagents.add_reagent(/datum/reagent/medicine/ephedrine,3)
	blood_loss += 700

/obj/item/slimecross/regenerative/green
	colour = "green"
	effect_desc = "Weakly heals the target, but fixes their organs .Additionally changes the spieces or color of a slime or jellyperson."

/obj/item/slimecross/regenerative/green/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.5

/obj/item/slimecross/regenerative/green/core_effect(mob/living/target, mob/user)
	if(isslime(target))
		target.visible_message("<span class='warning'>The [target] suddenly changes color!</span>")
		var/mob/living/simple_animal/slime/S = target
		S.random_colour()
	if(isjellyperson(target))
		target.reagents.add_reagent(/datum/reagent/mutationtoxin/jelly,5)
	organ_loss += 17


/obj/item/slimecross/regenerative/pink
	colour = "pink"
	effect_desc = "Partially heals the target and injects them with some krokodil."

/obj/item/slimecross/regenerative/pink/core_effect(mob/living/target, mob/user)
	to_chat(target, "<span class='notice'>You feel more calm.</span>")
	target.reagents.add_reagent(/datum/reagent/drug/krokodil,4)

/obj/item/slimecross/regenerative/gold
	colour = "gold"
	effect_desc = "Partially heals the target and produces a random coin."

/obj/item/slimecross/regenerative/gold/core_effect(mob/living/target, mob/user)
	var/newcoin = pick(/obj/item/coin/silver, /obj/item/coin/iron, /obj/item/coin/gold, /obj/item/coin/diamond, /obj/item/coin/plasma, /obj/item/coin/uranium)
	var/obj/item/coin/C = new newcoin(target.loc)
	playsound(C, 'sound/items/coinflip.ogg', 50, TRUE)
	target.put_in_hand(C)

/obj/item/slimecross/regenerative/oil
	colour = "oil"
	effect_desc = "Partially heals the target and flashes everyone in sight."

/obj/item/slimecross/regenerative/oil/core_effect(mob/living/target, mob/user)
	playsound(src, 'sound/weapons/flash.ogg', 100, TRUE)
	for(var/mob/living/L in view(user,7))
		L.flash_act()

/obj/item/slimecross/regenerative/black
	colour = "black"
	effect_desc = "Partially heals the target and creates a duplicate of them, that drops dead soon after."

/obj/item/slimecross/regenerative/black/core_effect_before(mob/living/target, mob/user)
	var/dummytype = target.type
	var/mob/living/dummy = new dummytype(target.loc)
	to_chat(target, "<span class='notice'>The milky goo flows from your skin, forming an imperfect copy of you.</span>")
	if(iscarbon(target))
		var/mob/living/carbon/T = target
		var/mob/living/carbon/D = dummy
		T.dna.transfer_identity(D)
		D.updateappearance(mutcolor_update=1)
		D.real_name = T.real_name
	dummy.adjustBruteLoss(target.getBruteLoss())
	dummy.adjustFireLoss(target.getFireLoss())
	dummy.adjustToxLoss(target.getToxLoss())
	dummy.adjustOxyLoss(200)

/obj/item/slimecross/regenerative/lightpink
	colour = "light pink"
	effect_desc = "Partially heals the target and also heals the user."

// Doesn't heal the user as much as the target
/obj/item/slimecross/regenerative/lightpink/core_effect(mob/living/target, mob/user)
	if(!isliving(user))
		return
	if(target == user)
		return
	var/mob/living/U = user
	var/oxy_loss = (10 + (U.getOxyLoss() * 0.3))
	var/tox_loss = (10 + (U.getToxLoss() * 0.3))
	var/fire_loss = (10 + (U.getFireLoss() * 0.3))
	var/brute_loss = (10 + (U.getBruteLoss() * 0.3))
	var/stamina_loss = (10 + (U.getStaminaLoss() * 0.35))
	U.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10) // Splits the healing effect across an instant heal, and a smaller heal after.
	U.specific_heal(brute_amt = brute_loss, fire_amt = fire_loss, tox_amt = tox_loss, oxy_amt = oxy_loss, stam_amt = stamina_loss, organ_amt = 2, clone_amt = 100)
	to_chat(U, "<span class='notice'>Some of the milky goo sprays onto you, as well!</span>")

/obj/item/slimecross/regenerative/adamantine
	colour = "adamantine"
	effect_desc = "weakly heals the target, but extra effective at treating brute trauma. Additionally boosts their armor."

/obj/item/slimecross/regenerative/adamantine/core_effect_before(mob/living/target, mob/user)
	slime_heal_modifier = 0.3

/obj/item/slimecross/regenerative/adamantine/core_effect(mob/living/target, mob/user) //WIP - Find out why this doesn't work.
	target.apply_status_effect(STATUS_EFFECT_SLIMESKIN)
	brute_loss = (10 + (target.getBruteLoss() * 0.65)) //most common damage type, let's not go overboard
	jelly_amount *= 0.5

/obj/item/slimecross/regenerative/rainbow
	colour = "rainbow"
	effect_desc = "Partially heals the target and temporarily makes them immortal, but pacifistic."

/obj/item/slimecross/regenerative/rainbow/core_effect(mob/living/target, mob/user)
	target.apply_status_effect(STATUS_EFFECT_RAINBOWPROTECTION)
