#define HYPO_SPRAY 0
#define HYPO_INJECT 1

#define WAIT_SPRAY 15
#define WAIT_INJECT 15
#define SELF_SPRAY 10
#define SELF_INJECT 10

#define DELUXE_WAIT_SPRAY 7
#define DELUXE_WAIT_INJECT 7
#define DELUXE_SELF_SPRAY 4
#define DELUXE_SELF_INJECT 4

#define COMBAT_WAIT_SPRAY 0
#define COMBAT_WAIT_INJECT 0
#define COMBAT_SELF_SPRAY 0
#define COMBAT_SELF_INJECT 0

/obj/item/reagent_containers/hypospray
	name = "hypospray"
	desc = "The hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients."
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
		to_chat(user, span_warning("[src] is empty!"))
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
		to_chat(M, span_warning("You feel a tiny prick!"))
		to_chat(user, span_notice("You inject [M] with [src]."))
		playsound(loc, pick('sound/items/hypospray.ogg','sound/items/hypospray2.ogg'), 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)


		if(M.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(M, amount_per_transfer_from_this, transfered_by = user, method = INJECT)
			else
				reagents.expose(M, INJECT, fraction)
				trans = reagents.copy_to(M, amount_per_transfer_from_this)
			to_chat(user, span_notice("[trans] unit\s injected. [reagents.total_volume] unit\s remaining in [src]."))
			log_combat(user, M, "injected", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/CMO
	list_reagents = list(/datum/reagent/medicine/panacea = 30)
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
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30, /datum/reagent/medicine/panacea = 30, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

//MediPens

/obj/item/reagent_containers/hypospray/medipen
	name = "epinephrine medipen"
	desc = "A rapid and safe way to stabilize patients in critical condition for personnel without advanced medical knowledge. Contains a powerful preservative that can delay decomposition when applied to a dead body."
	icon_state = "medipen"
	item_state = "medipen"
	base_icon_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount_per_transfer_from_this = 15
	volume = 15
	ignore_flags = 1 //so you can medipen through hardsuits
	reagent_flags = DRAWABLE
	flags_1 = null
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/toxin/formaldehyde = 3, /datum/reagent/medicine/chitosan = 2)
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
		. += span_notice("It is currently loaded.")
	else
		. += span_notice("It is spent.")

/obj/item/reagent_containers/hypospray/medipen/stimpack //goliath kiting
	name = "stimpack medipen"
	desc = "A rapid way to stimulate your body's adrenaline, allowing for freer movement in restrictive armor."
	icon_state = "stimpen"
	item_state = "stimpen"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/ephedrine = 10, /datum/reagent/consumable/coffee = 10)

/obj/item/reagent_containers/hypospray/medipen/stimpack/crisis
	name = "crisis stimpack"
	icon_state = "stimpen"
	item_state = "stimpen"
	base_icon_state = "stimpen"
	desc = "A modified stimulant autoinjector, containing a cocktail of potent nerve excitants and long-release healing chemicals. Designed for use in emergency situations where medical help may be hours or days away."
	list_reagents = list(/datum/reagent/medicine/stimulants = 5, /datum/reagent/medicine/ephedrine = 5, /datum/reagent/medicine/panacea = 15)

/obj/item/reagent_containers/hypospray/medipen/morphine
	name = "morphine medipen"
	desc = "A rapid way to get you out of a tight situation and fast! You'll feel rather drowsy, though."
	list_reagents = list(/datum/reagent/medicine/morphine = 10)
	custom_price = 50

/obj/item/reagent_containers/hypospray/medipen/tramal
	name = "tramal medipen"
	desc = "A quick way to relieve persistant pain."
	list_reagents = list(/datum/reagent/medicine/tramal = 10)
	custom_price = 25

/obj/item/reagent_containers/hypospray/medipen/silfrine
	name = "silfrine medipen"
	desc = "A autoinjector containing silfrine, used to near-instantly reknit hewn flesh."
	icon_state = "salpen"
	item_state = "salpen"
	base_icon_state = "salpen"
	list_reagents = list(/datum/reagent/medicine/silfrine = 10)

/obj/item/reagent_containers/hypospray/medipen/ysiltane
	name = "ysiltane medipen"
	desc = "A autoinjector containing ysiltane, used to rapidly clear up widespread surface-level burning."
	icon_state = "oxapen"
	item_state = "oxapen"
	base_icon_state = "oxapen"
	list_reagents = list(/datum/reagent/medicine/ysiltane = 10)

/obj/item/reagent_containers/hypospray/medipen/gjalrazine
	name = "gjalrazine medipen"
	desc = "A autoinjector containing Gjalrazine, used to purge the body of toxic after effects."
	icon_state = "penacid"
	item_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/gjalrazine = 10)

/obj/item/reagent_containers/hypospray/medipen/penacid
	name = "pentetic acid medipen"
	desc = "A autoinjector containing pentetic acid, used to reduce high levels of radiations and moderate toxins."
	icon_state = "penacid"
	item_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)

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

/obj/item/reagent_containers/hypospray/medipen/atropine
	name = "atropine autoinjector"
	desc = "A rapid way to save a person from a critical injury state!"
	icon_state = "atropen"
	item_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/atropine = 10)
	custom_price = 100

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
	custom_price = 25

/obj/item/reagent_containers/hypospray/medipen/bonefixingjuice
	name = "rejuvenating agent injector"
	desc = "The C4L-Z1UM agent will induce a short stasis that will heal any organ damage and bone fractures effectively. \
	Has a menacing red S on it."
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/bonefixingjuice = 10)
	icon_state = "syndipen"

/obj/item/reagent_containers/hypospray/medipen/diphen
	name = "diphenhydramine injector"
	desc = "An effective way to stop an allergic reaction."
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 10)
	volume = 10
	amount_per_transfer_from_this = 10

/obj/item/reagent_containers/hypospray/medipen/psicodine
	name = "psicodine injector"
	desc = "An injector filled with psicodine, which rapidly stabilizes the mind."
	list_reagents = list(/datum/reagent/medicine/psicodine = 10)
	volume = 10
	amount_per_transfer_from_this = 10
	custom_price = 50

/obj/item/reagent_containers/hypospray/medipen/synap
	name = "synaptizine injector"
	desc = "A stimulating injector with a shot of synaptizine inside."
	list_reagents = list(/datum/reagent/medicine/synaptizine = 5)
	custom_price = 75
	volume = 5
	amount_per_transfer_from_this = 5
	icon_state = "stimpen"
	item_state = "stimpen"

/obj/item/reagent_containers/hypospray/medipen/antihol
	name = "antihol injector"
	desc = "An injector filled with antihol, essential for the binge drinker."
	list_reagents = list(/datum/reagent/medicine/antihol = 10)
	volume = 10
	amount_per_transfer_from_this = 10
	custom_price = 25

/obj/item/reagent_containers/hypospray/medipen/cureall
	name = "cureall injector"
	desc = "An injector filled with cureall, a mildly effective healing agent."
	list_reagents = list(/datum/reagent/medicine/cureall = 15)
	volume = 15
	amount_per_transfer_from_this = 15
	icon_state = "morphen"
	base_icon_state = "morphen"
	item_state = "morphen"

/obj/item/reagent_containers/hypospray/medipen/mannitol
	name = "mannitol injector"
	desc = "An injector filled with mannitol, a restorative compound that targets the brain."
	list_reagents = list(/datum/reagent/medicine/mannitol = 15)
	volume = 15
	amount_per_transfer_from_this = 15
	icon_state = "morphen"
	base_icon_state = "morphen"
	item_state = "morphen"

/obj/item/reagent_containers/hypospray/medipen/badstop
	name = "Stabilizer injector"
	desc = "A 2-use injector filled with a mix of medical agents, designed to stabilize someone for immediate extraction."
	list_reagents = list(/datum/reagent/medicine/chitosan = 5, /datum/reagent/medicine/morphine = 10, /datum/reagent/medicine/psicodine = 5, /datum/reagent/medicine/atropine = 10)
	volume = 30
	amount_per_transfer_from_this = 15
	icon_state = "tbpen"
	item_state = "tbpen"
	base_icon_state = "tbpen"

/obj/item/reagent_containers/hypospray/medipen/badstop/update_icon_state()
	. = ..()
	if(reagents.total_volume > 30)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

/obj/item/reagent_containers/hypospray/medipen/combat_drug
	name = "combat cocktail"
	desc = "An injector filled with a potent combat drug mixture. Straight from the Shoal."
	list_reagents = list(/datum/reagent/drug/combat_drug = 6, /datum/reagent/medicine/silfrine = 6, /datum/reagent/medicine/ysiltane = 6)
	volume = 18
	amount_per_transfer_from_this = 18
	icon_state = "syndipen"
	base_icon_state = "syndipen"
	item_state = "syndipen"

/obj/item/reagent_containers/hypospray/medipen/rabbit
	name = "rabbit injector"
	desc = "An injector decorated with a chibi-stylized armored rabbitgirl, wielding what appears to be a Hydra DMR."
	list_reagents = list(/datum/reagent/drug/stardrop/starlight = 10, /datum/reagent/medicine/carfencadrizine = 6, /datum/reagent/medicine/stimulants = 8)
	volume = 24
	amount_per_transfer_from_this = 24
	icon_state = "stimpen"
	base_icon_state = "stimpen"

/obj/item/reagent_containers/hypospray/medipen/mammoth
	name = "mammoth injector"
	desc = "An injector filled with an ICW-era mixture of aggression-enhancing stimulants."
	list_reagents = list(/datum/reagent/drug/mammoth = 7, /datum/reagent/medicine/dimorlin = 6, /datum/reagent/medicine/carfencadrizine = 6)
	volume = 19
	amount_per_transfer_from_this = 19
	icon_state = "syndipen"
	base_icon_state = "syndipen"
	item_state = "syndipen"

/obj/item/reagent_containers/hypospray/medipen/netzach
	name = "\improper Nesah injector"
	desc = "A combat injector filled with a tightly curated mixture of regenerative compounds. \"The Fearlessness To Go Forward\" is etched in small text opposite the activator."
	list_reagents = list(/datum/reagent/medicine/silfrine = 10, /datum/reagent/medicine/ysiltane = 10, /datum/reagent/drug/cinesia = 10, /datum/reagent/medicine/morphine = 10)
	volume = 40
	amount_per_transfer_from_this = 40
	icon_state = "penacid"
	base_icon_state = "penacid"
	item_state = "penacid"

/obj/item/reagent_containers/hypospray/medipen/placebatol
	name = "prescription medipen"
	desc = "An injector filled with some prescribed substance."
	list_reagents = list(/datum/reagent/drug/placebatol = 15)
	volume = 15
	amount_per_transfer_from_this = 15

/obj/item/reagent_containers/hypospray/medipen/ekit
	name = "emergency first-aid autoinjector"
	desc = "An epinephrine medipen with extra coagulant and antibiotics to help stabilize bad cuts and burns."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 12, /datum/reagent/medicine/chitosan = 2.5, /datum/reagent/medicine/spaceacillin = 0.5)

/obj/item/reagent_containers/hypospray/medipen/blood_loss
	name = "hypovolemic-response autoinjector"
	desc = "A medipen designed to stabilize and rapidly reverse severe bloodloss."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5, /datum/reagent/medicine/chitosan = 2.5, /datum/reagent/iron = 3.5, /datum/reagent/medicine/salglu_solution = 4)

//A vial-loaded hypospray. Cartridge-based!
/obj/item/hypospray/mkii
	name = "hypospray mk.II"
	icon = 'icons/obj/syringe.dmi'
	icon_state = "hypo2"
	desc = "A medical product traditionally manufactured by Nanotrasen and Cybersun, this hypospray takes 30-unit vials as the drug supply for easy swapping."
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
	var/penetrates = TRUE

/obj/item/hypospray/mkii/brute
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/indomide

/obj/item/hypospray/mkii/toxin
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/pancrazine

/obj/item/hypospray/mkii/oxygen
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/dexalin

/obj/item/hypospray/mkii/burn
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/alvitane

/obj/item/hypospray/mkii/cureall
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/cureall

/obj/item/hypospray/mkii/mkiii
	name = "hypospray mk.III"
	allowed_containers = list(/obj/item/reagent_containers/glass/bottle/vial/tiny, /obj/item/reagent_containers/glass/bottle/vial/small, /obj/item/reagent_containers/glass/bottle/vial/large)
	icon_state = "cmo2"
	desc = "The mk.III Hypospray can take larger-size vials. It also acts faster and delivers more reagents per spray."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/CMO
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT

/obj/item/hypospray/mkii/mkiii/combat
	name = "combat hypospray mk.II"
	desc = "A combat-ready deluxe hypospray that acts almost instantly. It can be tactically reloaded by using a vial on it."
	icon_state = "combat2"
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/large/preloaded/combat
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_SPRAY
	inject_self = COMBAT_SELF_INJECT
	quickload = TRUE

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
		to_chat(user, span_notice("You remove [vial] from [src]."))
		vial = null
		update_appearance()
		playsound(loc, SOUND_EMPTY_MAG, 50, 1)
	else
		to_chat(user, span_notice("This hypo isn't loaded!"))
		return

/obj/item/hypospray/mkii/attackby(obj/item/I, mob/living/user)
	if((istype(I, /obj/item/reagent_containers/glass/bottle/vial) && vial != null))
		if(!quickload)
			to_chat(user, span_warning("[src] can not hold more than one vial!"))
			return FALSE
		unload_hypo(vial, user)
	if((istype(I, /obj/item/reagent_containers/glass/bottle/vial)))
		var/obj/item/reagent_containers/glass/bottle/vial/V = I
		if(!is_type_in_list(V, allowed_containers))
			to_chat(user, span_notice("[src] doesn't accept this type of vial."))
			return FALSE
		if(!user.transferItemToLoc(V,src))
			return FALSE
		vial = V
		user.visible_message(span_notice("[user] has loaded a vial into [src]."),span_notice("You have loaded [vial] into [src]."))
		update_appearance()
		playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
		return TRUE
	else
		to_chat(user, span_notice("This doesn't fit in [src]."))
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
		if(!penetrates && !L.can_inject(user, 1)) //This check appears another four times, since otherwise the penetrating sprays will break in do_after.
			return

	if(!L && !target.is_injectable()) //only checks on non-living mobs, due to how can_inject() handles
		to_chat(user, span_warning("You cannot directly fill [target]!"))
		return

	if(target.reagents.total_volume >= target.reagents.maximum_volume)
		to_chat(user, span_notice("[target] is full."))
		return

	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(!IS_ORGANIC_LIMB(affecting))
			to_chat(user, span_notice("Medicine won't work on a robotic limb!"))
			return

	var/contained = vial.reagents.log_list()
	log_combat(user, L, "attemped to inject", src, addition="which had [contained]")
//Always log attemped injections for admins
	if(vial != null)
		switch(mode)
			if(HYPO_INJECT)
				if(L) //living mob
					if(L != user)
						L.visible_message(span_danger("[user] is trying to inject [L] with [src]!"), \
										span_userdanger("[user] is trying to inject [L] with [src]!"))
						if(!do_after(user, inject_wait, L))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						L.visible_message(span_danger("[user] uses the [src] on [L]!"), \
										span_userdanger("[user] uses the [src] on [L]!"))
					else
						if(!do_after(user, inject_self, L))
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
				to_chat(user, span_notice("You inject [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units."))

			if(HYPO_SPRAY)
				if(L) //living mob
					if(L != user)
						L.visible_message(span_danger("[user] is trying to spray [L] with [src]!"), \
										span_userdanger("[user] is trying to spray [L] with [src]!"))
						if(!do_after(user, spray_wait, L))
							return
						if(!penetrates && !L.can_inject(user, 1))
							return
						if(!vial.reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						L.visible_message(span_danger("[user] uses the [src] on [L]!"), \
										span_userdanger("[user] uses the [src] on [L]!"))
					else
						if(!do_after(user, spray_self, L))
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
				to_chat(user, span_notice("You spray [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units."))
	else
		to_chat(user, span_notice("[src] doesn't work here!"))
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
	. = ..()
	var/mob/M = usr
	if(!M.canUseTopic(src, BE_CLOSE))
		return
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
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5.5, /datum/reagent/medicine/hunter_extract = 3, /datum/reagent/drug/methamphetamine = 2, /datum/reagent/medicine/morphine = 0.5, /datum/reagent/medicine/leporazine = 6, /datum/reagent/medicine/salglu_solution = 8, /datum/reagent/medicine/ysiltane = 5, /datum/reagent/medicine/silfrine = 5)

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
