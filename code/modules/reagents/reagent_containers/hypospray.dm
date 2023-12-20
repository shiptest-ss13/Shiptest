#define HYPO_SPRAY 0
#define HYPO_INJECT 1

#define WAIT_SPRAY 25
#define WAIT_INJECT 25
#define SELF_SPRAY 15
#define SELF_INJECT 15

#define DELUXE_WAIT_SPRAY 20
#define DELUXE_WAIT_INJECT 20
#define DELUXE_SELF_SPRAY 10
#define DELUXE_SELF_INJECT 10

#define COMBAT_WAIT_SPRAY 0
#define COMBAT_WAIT_INJECT 0
#define COMBAT_SELF_SPRAY 0
#define COMBAT_SELF_INJECT 0

/obj/item/reagent_containers/hypospray
	name = "hypospray"
	desc = "The DeForest Medical Corporation hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients."
	icon = 'icons/obj/syringe.dmi'
	item_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = list()
	resistance_flags = ACID_PROOF
	reagent_flags = OPENCONTAINER
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = 0
	var/infinite = FALSE

/obj/item/reagent_containers/hypospray/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	inject(M, user)

///Handles all injection checks, injection and logging.
/obj/item/reagent_containers/hypospray/proc/inject(mob/living/M, mob/user)
	if(!reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return FALSE
	if(!iscarbon(M))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	var/contained = english_list(injected)
	log_combat(user, M, "attempted to inject", src, "([contained])")

	if(reagents.total_volume && (ignore_flags || M.can_inject(user, 1))) // Ignore flag should be checked first or there will be an error message.
		to_chat(M, "<span class='warning'>You feel a tiny prick!</span>")
		to_chat(user, "<span class='notice'>You inject [M] with [src].</span>")
		playsound(loc, pick('sound/items/hypospray.ogg','sound/items/hypospray2.ogg'), 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)


		if(M.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(M, amount_per_transfer_from_this, transfered_by = user, method = INJECT)
			else
				reagents.expose(M, INJECT, fraction)
				trans = reagents.copy_to(M, amount_per_transfer_from_this)
			to_chat(user, "<span class='notice'>[trans] unit\s injected. [reagents.total_volume] unit\s remaining in [src].</span>")
			log_combat(user, M, "injected", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/CMO
	list_reagents = list(/datum/reagent/medicine/omnizine = 30)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//combat

/obj/item/reagent_containers/hypospray/combat
	name = "combat stimulant injector"
	desc = "A modified air-needle autoinjector, used by support operatives to quickly heal injuries in combat."
	amount_per_transfer_from_this = 10
	item_state = "combat_hypo"
	icon_state = "combat_hypo"
	volume = 90
	ignore_flags = 1 // So they can heal their comrades.
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30, /datum/reagent/medicine/omnizine = 30, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/hypospray/combat/nanites
	name = "experimental combat stimulant injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with experimental medical nanites and a stimulant for rapid healing and a combat boost."
	item_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/quantum_heal = 80, /datum/reagent/medicine/synaptizine = 20)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/combat/heresypurge
	name = "holy water piercing injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with 5 doses of a holy water and pacifier mixture. Not for use on your teammates."
	item_state = "holy_hypo"
	icon_state = "holy_hypo"
	volume = 250
	list_reagents = list(/datum/reagent/water/holywater = 150, /datum/reagent/peaceborg/tire = 50, /datum/reagent/peaceborg/confuse = 50)
	amount_per_transfer_from_this = 50

//MediPens

/obj/item/reagent_containers/hypospray/medipen
	name = "epinephrine medipen"
	desc = "A rapid and safe way to stabilize patients in critical condition for personnel without advanced medical knowledge. Contains a powerful preservative that can delay decomposition when applied to a dead body."
	icon_state = "medipen"
	item_state = "medipen"
	base_icon_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount_per_transfer_from_this = 13
	volume = 13
	ignore_flags = 1 //so you can medipen through hardsuits
	reagent_flags = DRAWABLE
	flags_1 = null
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/toxin/formaldehyde = 3)
	custom_price = 150
	custom_premium_price = 300

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/M, mob/user)
	. = ..()
	if(.)
		reagents.maximum_volume = 0 //Makes them useless afterwards
		reagents.flags = NONE
		update_appearance()

/obj/item/reagent_containers/hypospray/medipen/attack_self(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/medipen/examine()
	. = ..()
	if(reagents && reagents.reagent_list.len)
		. += "<span class='notice'>It is currently loaded.</span>"
	else
		. += "<span class='notice'>It is spent.</span>"

/obj/item/reagent_containers/hypospray/medipen/stimpack //goliath kiting
	name = "stimpack medipen"
	desc = "A rapid way to stimulate your body's adrenaline, allowing for freer movement in restrictive armor."
	icon_state = "stimpen"
	item_state = "stimpen"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/ephedrine = 10, /datum/reagent/consumable/coffee = 10)

/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor
	desc = "A modified stimulants autoinjector for use in combat situations. Has a mild healing effect."
	list_reagents = list(/datum/reagent/medicine/stimulants = 10, /datum/reagent/medicine/omnizine = 10)

//watered down traitor stim
/obj/item/reagent_containers/hypospray/medipen/stimpack/crisis
	name = "crisis stimpack"
	icon_state = "stimpen"
	item_state = "stimpen"
	base_icon_state = "stimpen"
	desc = "A modified stimulant autoinjector, containing a cocktail of potent nerve excitants and long-release healing chemicals. Designed for use in emergency situations where medical help may be hours or days away."
	list_reagents = list(/datum/reagent/medicine/stimulants = 5, /datum/reagent/medicine/ephedrine = 5, /datum/reagent/medicine/omnizine = 15)

/obj/item/reagent_containers/hypospray/medipen/stimulants
	name = "stimulant medipen"
	desc = "Contains a very large amount of an incredibly powerful stimulant, vastly increasing your movement speed and reducing stuns by a very large amount for around five minutes. Do not take if pregnant."
	icon_state = "syndipen"
	item_state = "tbpen"
	base_icon_state = "syndipen"
	volume = 50
	amount_per_transfer_from_this = 50
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)

/obj/item/reagent_containers/hypospray/medipen/morphine
	name = "morphine medipen"
	desc = "A rapid way to get you out of a tight situation and fast! You'll feel rather drowsy, though."
	icon_state = "morphen"
	base_icon_state = "morphen"
	item_state = "morphen"
	list_reagents = list(/datum/reagent/medicine/morphine = 10)

/obj/item/reagent_containers/hypospray/medipen/oxandrolone
	name = "oxandrolone medipen"
	desc = "A autoinjector containing oxandrolone, used to treat severe burns."
	icon_state = "oxapen"
	item_state = "oxapen"
	base_icon_state = "oxapen"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 10)

/obj/item/reagent_containers/hypospray/medipen/penacid
	name = "pentetic acid medipen"
	desc = "A autoinjector containing pentetic acid, used to reduce high levels of radiations and moderate toxins."
	icon_state = "penacid"
	item_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)

/obj/item/reagent_containers/hypospray/medipen/salacid
	name = "salicylic acid medipen"
	desc = "A autoinjector containing salicylic acid, used to treat severe brute damage."
	icon_state = "salacid"
	item_state = "salacid"
	base_icon_state = "salacid"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10)

/obj/item/reagent_containers/hypospray/medipen/salbutamol
	name = "salbutamol medipen"
	desc = "A autoinjector containing salbutamol, used to heal oxygen damage quickly."
	icon_state = "salpen"
	item_state = "salpen"
	base_icon_state = "salpen"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10)

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure
	name = "BVAK autoinjector"
	desc = "Bio Virus Antidote Kit autoinjector. Has a two use system for yourself, and someone else. Inject when infected."
	icon_state = "tbpen"
	item_state = "tbpen"
	base_icon_state = "tbpen"
	volume = 20
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 20)

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure/update_icon_state()
	. = ..()
	if(reagents.total_volume > 30)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

/* Replaced with variant in whitesands/code/modules/reagents/reagent_containers/hypospray.dm
/obj/item/reagent_containers/hypospray/medipen/survival
	name = "survival medipen"
	desc = "A medipen for surviving in the harshest of environments, heals and protects from environmental hazards. WARNING: Do not inject more than one pen in quick succession."
	icon_state = "stimpen"
	item_state = "stimpen"
	volume = 57
	amount_per_transfer_from_this = 58
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/bicaridinep = 8, /datum/reagent/medicine/dermaline = 8, /datum/reagent/medicine/epinephrine = 10, /datum/reagent/medicine/lavaland_extract = 2, /datum/reagent/medicine/omnizine = 5)
*/
/obj/item/reagent_containers/hypospray/medipen/atropine
	name = "atropine autoinjector"
	desc = "A rapid way to save a person from a critical injury state!"
	icon_state = "atropen"
	item_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/atropine = 10)

/obj/item/reagent_containers/hypospray/medipen/snail
	name = "snail shot"
	desc = "All-purpose snail medicine! Do not use on non-snails!"
	icon_state = "snail"
	item_state = "snail"
	base_icon_state = "gorillapen"
	list_reagents = list(/datum/reagent/snail = 10)

/obj/item/reagent_containers/hypospray/medipen/magillitis
	name = "experimental autoinjector"
	desc = "A custom-frame needle injector with a small single-use reservoir, containing an experimental serum. Unlike the more common medipen frame, it cannot pierce through protective armor or hardsuits, nor can the chemical inside be extracted."
	icon_state = "gorillapen"
	item_state = "gorillapen"
	base_icon_state = "gorillapen"
	volume = 5
	ignore_flags = 0
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/hypospray/medipen/pumpup
	name = "maintenance pump-up"
	desc = "A ghetto looking autoinjector filled with a cheap adrenaline shot... Great for shrugging off the effects of stunbatons."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/pumpup = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"

/obj/item/reagent_containers/hypospray/medipen/anti_rad
	name = "emergency anti-radiation applicator"
	desc = "A dangerous looking applicator with a decal of a radiation warning crossed out."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/anti_rad = 15)

/obj/item/reagent_containers/hypospray/medipen/bonefixingjuice
	name = "rejuvenating agent injector"
	desc = "The C4L-Z1UM agent will induce a short stasis that will heal any organ damage and bone fractures effectively. \
	Has a menacing red S on it."
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/bonefixingjuice = 10)
	icon_state = "syndipen"

//A vial-loaded hypospray. Cartridge-based!
/obj/item/hypospray/mkii
	name = "hypospray mk.II"
	icon = 'icons/obj/syringe.dmi'
	icon_state = "hypo2"
	desc = "A new development from DeForest Medical, this hypospray takes 30-unit vials as the drug supply for easy swapping."
	w_class = WEIGHT_CLASS_TINY
	var/list/allowed_containers = list(/obj/item/reagent_containers/glass/bottle/vial/tiny, /obj/item/reagent_containers/glass/bottle/vial/small)
	var/mode = HYPO_INJECT
	var/obj/item/reagent_containers/glass/bottle/vial/vial
	var/start_vial = /obj/item/reagent_containers/glass/bottle/vial/small
	var/spawnwithvial = TRUE
	var/inject_wait = WAIT_INJECT
	var/spray_wait = WAIT_SPRAY
	var/spray_self = SELF_SPRAY
	var/inject_self = SELF_INJECT
	var/quickload = FALSE
	var/penetrates = FALSE

/obj/item/hypospray/mkii/brute
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/bicaridine

/obj/item/hypospray/mkii/toxin
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/antitoxin

/obj/item/hypospray/mkii/oxygen
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/dexalin

/obj/item/hypospray/mkii/burn
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/kelotane

/obj/item/hypospray/mkii/tricord
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/tricord

/obj/item/hypospray/mkii/CMO
	name = "hypospray mk.II deluxe"
	allowed_containers = list(/obj/item/reagent_containers/glass/bottle/vial/tiny, /obj/item/reagent_containers/glass/bottle/vial/small, /obj/item/reagent_containers/glass/bottle/vial/large)
	icon_state = "cmo2"
	desc = "The Deluxe Hypospray can take larger-size vials. It also acts faster and delivers more reagents per spray."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/CMO
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT

/obj/item/hypospray/mkii/CMO/combat
	name = "combat hypospray mk.II"
	desc = "A combat-ready deluxe hypospray that acts almost instantly. It can be tactically reloaded by using a vial on it."
	icon_state = "combat2"
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/combat
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_SPRAY
	inject_self = COMBAT_SELF_INJECT
	quickload = TRUE
	penetrates = TRUE

/obj/item/hypospray/mkii/Initialize()
	. = ..()
	if(!spawnwithvial)
		update_appearance()
		return
	if(start_vial)
		vial = new start_vial
	update_appearance()

/obj/item/hypospray/mkii/update_appearance()
	..()
	icon_state = "[initial(icon_state)][vial ? "" : "-e"]"
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
	return

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	if(vial)
		to_chat(user, "[vial] has [vial.reagents.total_volume]u remaining.")
	else
		to_chat(user, "It has no vial loaded in.")
	to_chat(user, "[src] is set to [mode ? "Inject" : "Spray"] contents on application.")

/obj/item/hypospray/mkii/proc/unload_hypo(obj/item/I, mob/user)
	if((istype(I, /obj/item/reagent_containers/glass/bottle/vial)))
		var/obj/item/reagent_containers/glass/bottle/vial/V = I
		V.forceMove(user.loc)
		user.put_in_hands(V)
		to_chat(user, "<span class='notice'>You remove [vial] from [src].</span>")
		vial = null
		update_appearance()
		playsound(loc, 'sound/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, "<span class='notice'>This hypo isn't loaded!</span>")
		return

/obj/item/hypospray/mkii/attackby(obj/item/I, mob/living/user)
	if((istype(I, /obj/item/reagent_containers/glass/bottle/vial) && vial != null))
		if(!quickload)
			to_chat(user, "<span class='warning'>[src] can not hold more than one vial!</span>")
			return FALSE
		unload_hypo(vial, user)
	if((istype(I, /obj/item/reagent_containers/glass/bottle/vial)))
		var/obj/item/reagent_containers/glass/bottle/vial/V = I
		if(!is_type_in_list(V, allowed_containers))
			to_chat(user, "<span class='notice'>[src] doesn't accept this type of vial.</span>")
			return FALSE
		if(!user.transferItemToLoc(V,src))
			return FALSE
		vial = V
		user.visible_message("<span class='notice'>[user] has loaded a vial into [src].</span>","<span class='notice'>You have loaded [vial] into [src].</span>")
		update_appearance()
		playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
		return TRUE
	else
		to_chat(user, "<span class='notice'>This doesn't fit in [src].</span>")
		return FALSE

/obj/item/hypospray/mkii/AltClick(mob/user)
	if(vial)
		vial.attack_self(user)

// Gunna allow this for now, still really don't approve - Pooj
/obj/item/hypospray/mkii/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		to_chat(user, "[src] happens to be already overcharged.")
		return
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = TRUE
	to_chat(user, "You overcharge [src]'s control circuit.")
	obj_flags |= EMAGGED
	return TRUE

/obj/item/hypospray/mkii/attack_hand(mob/user)
	. = ..() //Don't bother changing this or removing it from containers will break.

/obj/item/hypospray/mkii/attack(obj/item/I, mob/user, params)
	return

/obj/item/hypospray/mkii/afterattack(atom/target, mob/user, proximity)
	if(!vial)
		return

	if(!proximity)
		return

	if(!ismob(target))
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!penetrates && !L.can_inject(user, 1)) //This check appears another four times, since otherwise the penetrating sprays will break in do_mob.
			return

	if(!L && !target.is_injectable()) //only checks on non-living mobs, due to how can_inject() handles
		to_chat(user, "<span class='warning'>You cannot directly fill [target]!</span>")
		return

	if(target.reagents.total_volume >= target.reagents.maximum_volume)
		to_chat(user, "<span class='notice'>[target] is full.</span>")
		return

	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, "<span class='warning'>The limb is missing!</span>")
			return
		if(!IS_ORGANIC_LIMB(affecting))
			to_chat(user, "<span class='notice'>Medicine won't work on a robotic limb!</span>")
			return

	var/contained = vial.reagents.log_list()
	log_combat(user, L, "attemped to inject", src, addition="which had [contained]")
//Always log attemped injections for admins
	if(vial != null)
		switch(mode)
			if(HYPO_INJECT)
				if(L) //living mob
					if(L != user)
						L.visible_message("<span class='danger'>[user] is trying to inject [L] with [src]!</span>", \
										"<span class='userdanger'>[user] is trying to inject [L] with [src]!</span>")
						if(!do_mob(user, L, inject_wait))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						L.visible_message("<span class='danger'>[user] uses the [src] on [L]!</span>", \
										"<span class='userdanger'>[user] uses the [src] on [L]!</span>")
					else
						if(!do_mob(user, L, inject_self))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [L.name] ([L.ckey]), which had [contained] (INTENT: [uppertext(user.a_intent)]) (MODE: [src.mode])</font>")
						L.log_message("<font color='orange'>applied [src] to  themselves ([contained]).</font>", INDIVIDUAL_ATTACK_LOG)

				var/fraction = min(vial.amount_per_transfer_from_this/vial.reagents.total_volume, 1)
				vial.reagents.expose(L, INJECT, fraction)
				vial.reagents.trans_to(target, vial.amount_per_transfer_from_this, method = INJECT)
				if(vial.amount_per_transfer_from_this >= 15)
					playsound(loc,'sound/items/hypospray_long.ogg',50, 1, -1)
				if(vial.amount_per_transfer_from_this < 15)
					playsound(loc,  pick('sound/items/hypospray.ogg','sound/items/hypospray2.ogg'), 50, 1, -1)
				to_chat(user, "<span class='notice'>You inject [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units.</span>")

			if(HYPO_SPRAY)
				if(L) //living mob
					if(L != user)
						L.visible_message("<span class='danger'>[user] is trying to spray [L] with [src]!</span>", \
										"<span class='userdanger'>[user] is trying to spray [L] with [src]!</span>")
						if(!do_mob(user, L, spray_wait))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						L.visible_message("<span class='danger'>[user] uses the [src] on [L]!</span>", \
										"<span class='userdanger'>[user] uses the [src] on [L]!</span>")
					else
						if(!do_mob(user, L, spray_self))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [L.name] ([L.ckey]), which had [contained] (INTENT: [uppertext(user.a_intent)]) (MODE: [src.mode])</font>")
						L.log_message("<font color='orange'>applied [src] to  themselves ([contained]).</font>", INDIVIDUAL_ATTACK_LOG)
				var/fraction = min(vial.amount_per_transfer_from_this/vial.reagents.total_volume, 1)
				vial.reagents.expose(L, PATCH, fraction)
				vial.reagents.trans_to(target, vial.amount_per_transfer_from_this, method = PATCH)
				if(vial.amount_per_transfer_from_this >= 15)
					playsound(loc,'sound/items/hypospray_long.ogg',50, 1, -1)
				if(vial.amount_per_transfer_from_this < 15)
					playsound(loc,  pick('sound/items/hypospray.ogg','sound/items/hypospray2.ogg'), 50, 1, -1)
				to_chat(user, "<span class='notice'>You spray [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units.</span>")
	else
		to_chat(user, "<span class='notice'>[src] doesn't work here!</span>")
		return

/obj/item/hypospray/mkii/attack_self(mob/living/user)
	if(user)
		if(user.incapacitated())
			return
		else if(!vial)
			to_chat(user, "This Hypo needs to be loaded first!")
			return
		else
			unload_hypo(vial,user)

/obj/item/hypospray/mkii/verb/modes()
	set name = "Toggle Application Mode"
	set category = "Object"
	set src in usr
	var/mob/M = usr
	switch(mode)
		if(HYPO_SPRAY)
			mode = HYPO_INJECT
			to_chat(M, "[src] is now set to inject contents on application.")
		if(HYPO_INJECT)
			mode = HYPO_SPRAY
			to_chat(M, "[src] is now set to spray contents on application.")

/obj/item/hypospray/mkii/CtrlClick()
	var/mob/M = usr
	switch(mode)
		if(HYPO_SPRAY)
			mode = HYPO_INJECT
			to_chat(M, "[src] is now set to inject contents on application.")
		if(HYPO_INJECT)
			mode = HYPO_SPRAY
			to_chat(M, "[src] is now set to spray contents on application.")

/obj/item/reagent_containers/hypospray/medipen/survival
	name = "survival stimpak"
	desc = "A medical cocktail for surviving in the harshest of environments, quickly heals and inhibits pain to help overcome extreme conditions. WARNING: Frequent use has long-term side effects."
	icon_state = "stimpen"
	item_state = "stimpen"
	base_icon_state = "stimpen"
	custom_price = 500
	volume = 35
	amount_per_transfer_from_this = 36
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5.5, /datum/reagent/medicine/lavaland_extract = 3, /datum/reagent/drug/methamphetamine = 2, /datum/reagent/medicine/morphine = 0.5, /datum/reagent/medicine/leporazine = 6, /datum/reagent/medicine/salglu_solution = 8, /datum/reagent/medicine/oxandrolone = 5, /datum/reagent/medicine/sal_acid = 5)

#undef HYPO_SPRAY
#undef HYPO_INJECT
#undef WAIT_SPRAY
#undef WAIT_INJECT
#undef SELF_SPRAY
#undef SELF_INJECT
#undef DELUXE_WAIT_SPRAY
#undef DELUXE_WAIT_INJECT
#undef DELUXE_SELF_SPRAY
#undef DELUXE_SELF_INJECT
#undef COMBAT_WAIT_SPRAY
#undef COMBAT_WAIT_INJECT
#undef COMBAT_SELF_SPRAY
#undef COMBAT_SELF_INJECT
