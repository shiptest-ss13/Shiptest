//These objects are used in the cardinal sin-themed ruins (i.e. Gluttony, Pride...)

/obj/structure/cursed_slot_machine //Greed's slot machine: Used in the Greed ruin. Deals clone damage on each use, with a successful use giving a d20 of fate.
	name = "greed's slot machine"
	desc = "High stakes, high rewards."
	icon = 'icons/obj/economy.dmi'
	icon_state = "slots1"
	anchored = TRUE
	density = TRUE
	var/win_prob = 5

/obj/structure/cursed_slot_machine/interact(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(obj_flags & IN_USE)
		return
	if(isipc(user))
		user.visible_message("<span class='warning'> As [user] tries to pull \the [src]'s lever, the machine seems to hesitate a bit.</span>", "<span class='warning'>You feel as if you are trying to put at stake something you don't even have...\ You suddenly feel your mind... Suboptimal?</span>")
		user.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	else
		user.adjustCloneLoss(20)
	obj_flags |= IN_USE

	if(user.stat)
		to_chat(user, "<span class='userdanger'>No... just one more try...</span>")
		user.gib()
	else
		user.visible_message("<span class='warning'>[user] pulls [src]'s lever with a glint in [user.p_their()] eyes!</span>", "<span class='warning'>You feel a draining as you pull the lever, but you \
		know it'll be worth it.</span>")
	icon_state = "slots2"
	playsound(src, 'sound/lavaland/cursed_slot_machine.ogg', 50, FALSE)
	addtimer(CALLBACK(src, PROC_REF(determine_victor), user), 50)

/obj/structure/cursed_slot_machine/proc/determine_victor(mob/living/user)
	icon_state = "slots1"
	obj_flags &= ~IN_USE
	if(prob(win_prob))
		playsound(src, 'sound/lavaland/cursed_slot_machine_jackpot.ogg', 50, FALSE)
		new/obj/structure/cursed_money(get_turf(src))
		if(user)
			to_chat(user, "<span class='boldwarning'>You've hit jackpot. Laughter echoes around you as your reward appears in the machine's place.</span>")
		qdel(src)
	else
		if(user)
			to_chat(user, "<span class='boldwarning'>Fucking machine! Must be rigged. Still... one more try couldn't hurt, right?</span>")


/obj/structure/cursed_money
	name = "bag of money"
	desc = "RICH! YES! YOU KNEW IT WAS WORTH IT! YOU'RE RICH! RICH! RICH!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "moneybag"
	anchored = FALSE
	density = TRUE

/obj/structure/cursed_money/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(collapse)), 600)

/obj/structure/cursed_money/proc/collapse()
	visible_message("<span class='warning'>[src] falls in on itself, \
		canvas rotting away and contents vanishing.</span>")
	qdel(src)

/obj/structure/cursed_money/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.visible_message("<span class='warning'>[user] opens the bag and \
		and removes a die. The bag then vanishes.</span>",
		"<span class='boldwarning'>You open the bag...!</span>\n\
		<span class='danger'>And see a bag full of dice. Confused, \
		you take one... and the bag vanishes.</span>")
	var/turf/T = get_turf(user)
	var/obj/item/dice/d20/fate/one_use/critical_fail = new(T)
	user.put_in_hands(critical_fail)
	qdel(src)

/obj/structure/mirror/magic/pride //Pride's mirror: Used in the Pride ruin.
	name = "pride's mirror"
	desc = "Pride cometh before the..."
	icon_state = "magic_mirror"

/obj/structure/mirror/magic/pride/New()
	for(var/speciestype in subtypesof(/datum/species))
		var/datum/species/S = speciestype
		if(initial(S.changesource_flags) & MIRROR_PRIDE)
			choosable_races += initial(S.id)
	..()

/obj/structure/mirror/magic/pride/curse(mob/user)
	user.visible_message("<span class='danger'><B>The ground splits beneath [user] as [user.p_their()] hand leaves the mirror!</B></span>", \
	"<span class='notice'>Perfect. Much better! Now <i>nobody</i> will be able to resist yo-</span>")

	var/turf/T = get_turf(user)
	var/datum/virtual_level/vlevel = pick(SSmapping.virtual_levels_by_trait(ZTRAIT_SPACE_RUINS))
	var/turf/dest
	if (vlevel)
		dest = vlevel.get_random_position()

	T.ChangeTurf(/turf/open/chasm, flags = CHANGETURF_INHERIT_AIR)
	var/turf/open/chasm/C = T
	C.set_target(dest)
	C.drop(user)
