/obj/item/retractor
	name = "retractor"
	desc = "Features a tensile pivot that helps train slow, precise manipulation. It can even be locked in place."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "retractor-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/surgery2_pickup.ogg'
	drop_sound = 'sound/items/handling/knife2_drop.ogg'
	item_state = "clamps-1"
	custom_materials = list(/datum/material/iron=6000, /datum/material/glass=3000)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 1

/obj/item/retractor/augment
	desc = "Micro-mechanical manipulator for retracting stuff."
	toolspeed = 0.5


/obj/item/hemostat
	name = "hemostat"
	desc = "A tiny needle-eye has been machined into one of the clamps to streamline the application of ligature."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "hemostat-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/surgery2_pickup.ogg'
	drop_sound = 'sound/items/handling/knife2_drop.ogg'
	item_state = "clamps-1"
	custom_materials = list(/datum/material/iron=5000, /datum/material/glass=2500)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("attacked", "pinched")
	tool_behaviour = TOOL_HEMOSTAT
	toolspeed = 1

/obj/item/hemostat/augment
	desc = "Tiny servos power a pair of pincers to stop bleeding."
	toolspeed = 0.5


/obj/item/cautery
	name = "cautery"
	desc = "An obtuse, rectangular design is just big enough to accomodate this cautery's incredibly durable battery."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "cautery-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/surgery2_pickup.ogg'
	drop_sound = 'sound/items/handling/knife2_drop.ogg'
	item_state = "cautery-1"
	custom_materials = list(/datum/material/iron=2500, /datum/material/glass=750)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("burnt")
	tool_behaviour = TOOL_CAUTERY
	toolspeed = 1

/obj/item/cautery/augment
	desc = "A heated element that cauterizes wounds."
	toolspeed = 0.5


/obj/item/surgicaldrill
	name = "surgical drill"
	desc = "The ergonomic foregrip is actually horrible for your hands, however the drill never sees enough use for it to be realized."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "drill-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/surgery1_pickup.ogg'
	drop_sound = 'sound/items/handling/metal_drop.ogg'
	hitsound = 'sound/weapons/circsawhit.ogg'
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=6000)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL | EYE_STAB
	force = 10		//WS Edit - Makes drill weaker than circular saw
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("drilled")
	sharpness = IS_SHARP		//WS Edit - Makes the Drill sharp
	tool_behaviour = TOOL_DRILL
	toolspeed = 1

/obj/item/surgicaldrill/Initialize()		//WS Edit Start - Trying to butcher with a drill is a bad idea
	. = ..()
	AddComponent(/datum/component/butchering, 300 * toolspeed, 30, 0, 'sound/weapons/circsawhit.ogg')		// Only technically works - WS Edit End

/obj/item/surgicaldrill/augment
	desc = "Effectively a small power drill contained within your arm, edges dulled to prevent tissue damage. May or may not pierce the heavens."
	hitsound = 'sound/weapons/circsawhit.ogg'
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5


/obj/item/scalpel
	name = "scalpel"
	desc = "The handle of the scalpel is an awkward ergonomic mold, designed to encourage proper form. A blade release button on the end allows for easy cleaning and replacement."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "scalpel-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/knife1_pickup.ogg'
	drop_sound = 'sound/items/handling/knife2_drop.ogg'
	item_state = "scalpel-1"
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL | EYE_STAB
	force = 10
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=4000, /datum/material/glass=1000)
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP_ACCURATE
	tool_behaviour = TOOL_SCALPEL
	toolspeed = 1

/obj/item/scalpel/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 * toolspeed, 100, 0)

/obj/item/scalpel/augment
	desc = "Ultra-sharp blade attached directly to your bone for extra-accuracy."
	toolspeed = 0.5

/obj/item/circular_saw
	name = "circular saw"
	desc = "The protective drill cover often becomes crusted with blood after a few uses, giving this saw a reputation for being high-maintenance."
	icon = 'icons/obj/surgery.dmi' //SHIPTEST edit: cool and new tools
	icon_state = "saw-1"
	item_state = "saw-1"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	pickup_sound =  'sound/items/handling/surgery1_pickup.ogg'
	drop_sound = 'sound/items/handling/metal_drop.ogg'
	hitsound = 'sound/weapons/circsawhit.ogg'
	mob_throw_hit_sound =  'sound/weapons/pierce.ogg'
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 9
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=6000)
	attack_verb = list("attacked", "slashed", "sawed", "cut")
	sharpness = IS_SHARP
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/circular_saw/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 40 * toolspeed, 100, 5, 'sound/weapons/circsawhit.ogg') //saws are very accurate and fast at butchering

/obj/item/circular_saw/augment
	desc = "A small but very fast spinning saw. Edges dulled to prevent accidental cutting inside of the surgeon."
	w_class = WEIGHT_CLASS_SMALL
	force = 10
	toolspeed = 0.5

//CODED BY CODY, AGE 7
/obj/item/circular_saw/best//BESTESTWEPON
	name = "swabw"
//spases 4 legibilititie

	icon_state = "swa"
	icon = 'icons/obj/items.dmi'

	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'

	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	desc = "Fwo hevy dute cuttinge :)))."

	hitsound = 'sound/items/shitty_drill.ogg'
	toolspeed = 100//BIIGER NUBER BERTTER
	force = 11.2345678//see? buig numba. Lots of VALUE!!1!
	throw_speed = 100



	attack_verb = list("KILDED", "CUTTED ALL OF THE WAY IN HALF", "STOPPED LIVINGE", "MADE NOT LIFE")

	custom_materials = list(/datum/material/diamond=1)

/obj/item/organ_storage //allows medical cyborgs to manipulate organs without hands
	name = "organ storage bag"
	desc = "A container for holding body parts."
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidenceobj"
	item_flags = SURGICAL_TOOL

/obj/item/organ_storage/afterattack(obj/item/I, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(contents.len)
		to_chat(user, "<span class='warning'>[src] already has something inside it!</span>")
		return
	if(!isorgan(I) && !isbodypart(I))
		to_chat(user, "<span class='warning'>[src] can only hold body parts!</span>")
		return

	user.visible_message("<span class='notice'>[user] puts [I] into [src].</span>", "<span class='notice'>You put [I] inside [src].</span>")
	icon_state = "evidence"
	var/xx = I.pixel_x
	var/yy = I.pixel_y
	I.pixel_x = 0
	I.pixel_y = 0
	var/image/img = image("icon"=I, "layer"=FLOAT_LAYER)
	img.plane = FLOAT_PLANE
	I.pixel_x = xx
	I.pixel_y = yy
	add_overlay(img)
	add_overlay("evidence")
	desc = "An organ storage container holding [I]."
	I.forceMove(src)
	w_class = I.w_class

/obj/item/organ_storage/attack_self(mob/user)
	if(contents.len)
		var/obj/item/I = contents[1]
		user.visible_message("<span class='notice'>[user] dumps [I] from [src].</span>", "<span class='notice'>You dump [I] from [src].</span>")
		cut_overlays()
		I.forceMove(get_turf(src))
		icon_state = "evidenceobj"
		desc = "A container for holding body parts."
	else
		to_chat(user, "<span class='notice'>[src] is empty.</span>")
	return

/obj/item/surgical_processor //allows medical cyborgs to scan and initiate advanced surgeries
	name = "\improper Surgical Processor"
	desc = "A device for scanning and initiating surgeries from a disk or operating computer."
	icon = 'icons/obj/device.dmi'
	icon_state = "spectrometer"
	item_flags = NOBLUDGEON
	var/list/advanced_surgeries = list()

/obj/item/surgical_processor/afterattack(obj/item/O, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(O, /obj/item/disk/surgery))
		to_chat(user, "<span class='notice'>You load the surgery protocol from [O] into [src].</span>")
		var/obj/item/disk/surgery/D = O
		if(do_after(user, 10, target = O))
			advanced_surgeries |= D.surgeries
		return TRUE
	if(istype(O, /obj/machinery/computer/operating))
		to_chat(user, "<span class='notice'>You copy surgery protocols from [O] into [src].</span>")
		var/obj/machinery/computer/operating/OC = O
		if(do_after(user, 10, target = O))
			advanced_surgeries |= OC.advanced_surgeries
		return TRUE
	return

/obj/item/scalpel/advanced
	name = "laser scalpel"
	desc = "This updated design was released on a fast schedule, aiming to lower the amount of circular saws being turned into makeshift weaponry."
	icon_state = "advscalpel"
	item_state = "advscalpel"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/weapons/blade1.ogg'
	force = 16
	toolspeed = 0.7
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_color = LIGHT_COLOR_GREEN
	sharpness = IS_SHARP_ACCURATE


/obj/item/scalpel/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCALPEL)
		tool_behaviour = TOOL_SAW
		balloon_alert(user, "saw mode")
		set_light_range(2)
		force += 1 //we don't want to ruin sharpened stuff
		icon_state = "advsaw"
	else
		tool_behaviour = TOOL_SCALPEL
		balloon_alert(user, "scalpel mode")
		set_light_range(1)
		force -= 1
		icon_state = "advscalpel"

/obj/item/scalpel/advanced/examine()
	. = ..()
	. += " It's set to [tool_behaviour == TOOL_SCALPEL ? "scalpel" : "saw"] mode."

/obj/item/retractor/advanced
	name = "mechanical pinches"
	desc = "The innate need for surgeons to show off to their peers has made this wired glove the source of many broken coffee cups."
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "advretractor"
	item_state = "advclamps"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	toolspeed = 0.7
	force = 10 //this is in essence a hunk of metal strapped to someone's hand, it's gonna hurt

/obj/item/retractor/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_RETRACTOR)
		tool_behaviour = TOOL_HEMOSTAT
		balloon_alert(user, "hemostat mode")
		icon_state = "advhemostat"
	else
		tool_behaviour = TOOL_RETRACTOR
		balloon_alert(user, "retractor mode")
		icon_state = "advretractor"

/obj/item/retractor/advanced/examine()
	. = ..()
	. += " It resembles a [tool_behaviour == TOOL_RETRACTOR ? "retractor" : "hemostat"]."

/obj/item/surgicaldrill/advanced
	name = "searing tool"
	desc = "The hollow central grip allows for a precise, push-dagger holding style. Affectionately referred to as the Kunai by doctors of stealthier inclinations."
	icon_state = "advdrill"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	item_state = "advcautery"
	hitsound = 'sound/items/welder.ogg'
	toolspeed = 0.7
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_color = COLOR_SOFT_RED


/obj/item/surgicaldrill/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/weapons/tap.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_DRILL)
		tool_behaviour = TOOL_CAUTERY
		balloon_alert(user, "cautery mode")
		icon_state = "advcautery"
	else
		tool_behaviour = TOOL_DRILL
		balloon_alert(user, "drill mode")
		icon_state = "advdrill"

/obj/item/surgicaldrill/advanced/examine()
	. = ..()
	. += " It's set to [tool_behaviour == TOOL_DRILL ? "drilling" : "mending"] mode."

/obj/item/shears
	name = "amputation shears"
	desc = "A type of heavy duty surgical shears used for achieving a clean separation between limb and patient. Keeping the patient still is imperative to be able to secure and align the shears."
	icon = 'icons/obj/surgery.dmi' //SHiIPTEST AWESOME
	icon_state = "shears"
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	toolspeed  = 1
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 6
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=8000, /datum/material/titanium=6000)
	attack_verb = list("sheared", "snipped")
	sharpness = IS_SHARP
	custom_premium_price = 1800

/obj/item/shears/attack(mob/living/M, mob/user)
	if(!iscarbon(M) || user.a_intent != INTENT_HELP)
		return ..()

	if(user.zone_selected == BODY_ZONE_CHEST)
		return ..()

	var/mob/living/carbon/patient = M

	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		to_chat(user, "<span class='warning'>The patient's limbs look too sturdy to amputate.</span>")
		return

	var/candidate_name
	var/obj/item/organ/tail_snip_candidate
	var/obj/item/bodypart/limb_snip_candidate

	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		tail_snip_candidate = patient.getorganslot(ORGAN_SLOT_TAIL)
		if(!tail_snip_candidate)
			to_chat(user, "<span class='warning'>[patient] does not have a tail.</span>")
			return
		candidate_name = tail_snip_candidate.name

	else
		limb_snip_candidate = patient.get_bodypart(check_zone(user.zone_selected))
		if(!limb_snip_candidate)
			to_chat(user, "<span class='warning'>[patient] is already missing that limb, what more do you want?</span>")
			return
		candidate_name = limb_snip_candidate.name

	var/amputation_speed_mod

	patient.visible_message("<span class='danger'>[user] begins to secure [src] around [patient]'s [candidate_name].</span>", "<span class='userdanger'>[user] begins to secure [src] around your [candidate_name]!</span>")
	playsound(get_turf(patient), 'sound/items/ratchet.ogg', 20, TRUE)
	if(patient.stat >= UNCONSCIOUS || patient.IsStun()) //Stun is used by paralytics like curare it should not be confused with the more common paralyze.
		amputation_speed_mod = 0.5
	else if(patient.jitteriness >= 1)
		amputation_speed_mod = 1.5
	else
		amputation_speed_mod = 1

	if(do_after(user,  toolspeed * 150 * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/weapons/bladeslice.ogg', 250, TRUE)
		if(user.zone_selected == BODY_ZONE_PRECISE_GROIN) //OwO
			tail_snip_candidate.Remove(patient)
			tail_snip_candidate.forceMove(get_turf(patient))
		else
			limb_snip_candidate.dismember()
		user.visible_message("<span class='danger'>[src] violently slams shut, amputating [patient]'s [candidate_name].</span>", "<span class='notice'>You amputate [patient]'s [candidate_name] with [src].</span>")

