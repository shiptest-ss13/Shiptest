/obj/item/toy/plush
	name = "plush"
	desc = "This is the special coder plush, do not steal."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "debug"
	attack_verb = list("thumped", "whomped", "bumped")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	var/list/squeak_override //Weighted list; If you want your plush to have different squeak sounds use this
	var/should_squeak = TRUE //WS edit: really shitty spritercode
	var/stuffed = TRUE //If the plushie has stuffing in it
	var/obj/item/grenade/grenade //You can remove the stuffing from a plushie and add a grenade to it for *nefarious uses*
	//--love ~<3--
	gender = NEUTER
	var/obj/item/toy/plush/lover
	var/obj/item/toy/plush/partner
	var/obj/item/toy/plush/plush_child
	var/obj/item/toy/plush/paternal_parent	//who initiated creation
	var/obj/item/toy/plush/maternal_parent	//who owns, see love()
	var/static/list/breeding_blacklist = typecacheof(/obj/item/toy/plush/carpplushie/dehy_carp) // you cannot have sexual relations with this plush
	var/list/scorned	= list()	//who the plush hates
	var/list/scorned_by	= list()	//who hates the plush, to remove external references on Destroy()
	var/heartbroken = FALSE
	var/vowbroken = FALSE
	var/young = FALSE
///Prevents players from cutting stuffing out of a plushie if true
	var/divine = FALSE
	var/mood_message
	var/list/love_message
	var/list/partner_message
	var/list/heartbroken_message
	var/list/vowbroken_message
	var/list/parent_message
	var/normal_desc
	//--end of love :'(--

/obj/item/toy/plush/Initialize()
	. = ..()
	if(should_squeak)
		AddComponent(/datum/component/squeak, squeak_override)
	AddElement(/datum/element/bed_tuckable, 6, -5, 90, FALSE, FALSE)

	//have we decided if Pinocchio goes in the blue or pink aisle yet?
	if(gender == NEUTER)
		if(prob(50))
			gender = FEMALE
		else
			gender = MALE

	love_message		= list("\n[src] is so happy, \he could rip a seam!")
	partner_message		= list("\n[src] has a ring on \his finger! It says bound to my dear [partner].")
	heartbroken_message	= list("\n[src] looks so sad.")
	vowbroken_message	= list("\n[src] lost \his ring...")
	parent_message		= list("\n[src] can't remember what sleep is.")

	normal_desc = desc

/obj/item/toy/plush/Destroy()
	QDEL_NULL(grenade)

	//inform next of kin and... acquaintances
	if(partner)
		partner.bad_news(src)
		partner = null
		lover = null
	else if(lover)
		lover.bad_news(src)
		lover = null

	if(paternal_parent)
		paternal_parent.bad_news(src)
		paternal_parent = null

	if(maternal_parent)
		maternal_parent.bad_news(src)
		maternal_parent = null

	if(plush_child)
		plush_child.bad_news(src)
		plush_child = null

	var/i
	var/obj/item/toy/plush/P
	for(i=1, i<=scorned.len, i++)
		P = scorned[i]
		P.bad_news(src)
	scorned = null

	for(i=1, i<=scorned_by.len, i++)
		P = scorned_by[i]
		P.bad_news(src)
	scorned_by = null

	//null remaining lists
	squeak_override = null

	love_message = null
	partner_message = null
	heartbroken_message = null
	vowbroken_message = null
	parent_message = null

	return ..()

/obj/item/toy/plush/handle_atom_del(atom/A)
	if(A == grenade)
		grenade = null
	..()

/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed || grenade)
		to_chat(user, span_notice("You pet [src]. D'awww."))
		if(grenade && !grenade.active)
			log_game("[key_name(user)] activated a hidden grenade in [src].")
			grenade.preprime(user, msg = FALSE, volume = 10)
	else
		to_chat(user, span_notice("You try to pet [src], but it has no stuffing. Aww..."))

/obj/item/toy/plush/attackby(obj/item/I, mob/living/user, params)
	if(I.get_sharpness())
		if(!grenade)
			if(!stuffed)
				to_chat(user, span_warning("You already murdered it!"))
				return
			if(!divine)
				user.visible_message(span_notice("[user] tears out the stuffing from [src]!"), span_notice("You rip a bunch of the stuffing from [src]. Murderer."))
				I.play_tool_sound(src)
				stuffed = FALSE
			else
				to_chat(user, span_notice("What a fool you are. [src] is a god, how can you kill a god? What a grand and intoxicating innocence."))
				if(iscarbon(user))
					var/mob/living/carbon/C = user
					C.adjust_drunk_effect(20, up_to = 50)
				var/turf/current_location = get_turf(user)
				var/area/current_area = current_location.loc //copied from hand tele code
				if(current_location && current_area && (current_area.area_flags & NOTELEPORT))
					to_chat(user, span_notice("There is no escape. No recall or intervention can work in this place."))
				else
					to_chat(user, span_notice("There is no escape. Although recall or intervention can work in this place, attempting to flee from [src]'s immense power would be futile."))
				user.visible_message(span_notice("[user] lays down their weapons and begs for [src]'s mercy!"), span_notice("You lay down your weapons and beg for [src]'s mercy."))
				user.drop_all_held_items()
		else
			to_chat(user, span_notice("You remove the grenade from [src]."))
			user.put_in_hands(grenade)
			grenade = null
		return
	if(istype(I, /obj/item/grenade))
		if(stuffed)
			to_chat(user, span_warning("You need to remove some stuffing first!"))
			return
		if(grenade)
			to_chat(user, span_warning("[src] already has a grenade!"))
			return
		if(!user.transferItemToLoc(I, src))
			return
		user.visible_message(span_warning("[user] slides [grenade] into [src]."), \
		span_danger("You slide [I] into [src]."))
		grenade = I
		var/turf/grenade_turf = get_turf(src)
		log_game("[key_name(user)] added a grenade ([I.name]) to [src] at [AREACOORD(grenade_turf)].")
		return
	if(istype(I, /obj/item/toy/plush))
		love(I, user)
		return
	return ..()

/obj/item/toy/plush/proc/love(obj/item/toy/plush/Kisser, mob/living/user)	//~<3
	var/chance = 100	//to steal a kiss, surely there's a 100% chance no-one would reject a plush such as I?
	var/concern = 20	//perhaps something might cloud true love with doubt
	var/loyalty = 30	//why should another get between us?
	var/duty = 50		//conquering another's is what I live for

	//we are not catholic
	if(young == TRUE || Kisser.young == TRUE)
		user.show_message(span_notice("[src] plays tag with [Kisser]."), MSG_VISUAL,
			span_notice("They're happy."), NONE)
		Kisser.cheer_up()
		cheer_up()

	//never again
	else if(Kisser in scorned)
		//message, visible, alternate message, neither visible nor audible
		user.show_message(span_notice("[src] rejects the advances of [Kisser]!"), MSG_VISUAL,
			span_notice("That didn't feel like it worked."), NONE)
	else if(src in Kisser.scorned)
		user.show_message(span_notice("[Kisser] realises who [src] is and turns away."), MSG_VISUAL,
			span_notice("That didn't feel like it worked."), NONE)

	//first comes love
	else if(Kisser.lover != src && Kisser.partner != src)	//cannot be lovers or married
		if(Kisser.lover)	//if the initiator has a lover
			Kisser.lover.heartbreak(Kisser)	//the old lover can get over the kiss-and-run whilst the kisser has some fun
			chance -= concern	//one heart already broken, what does another mean?
		if(lover)	//if the recipient has a lover
			chance -= loyalty	//mustn't... but those lips
		if(partner)	//if the recipient has a partner
			chance -= duty	//do we mate for life?

		if(prob(chance))	//did we bag a date?
			user.visible_message(span_notice("[user] makes [Kisser] kiss [src]!"),
									span_notice("You make [Kisser] kiss [src]!"))
			if(lover)	//who cares for the past, we live in the present
				lover.heartbreak(src)
			new_lover(Kisser)
			Kisser.new_lover(src)
		else
			user.show_message(span_notice("[src] rejects the advances of [Kisser], maybe next time?"), MSG_VISUAL,
								span_notice("That didn't feel like it worked, this time."), NONE)

	//then comes marriage
	else if(Kisser.lover == src && Kisser.partner != src)	//need to be lovers (assumes loving is a two way street) but not married (also assumes similar)
		user.visible_message(span_notice("[user] pronounces [Kisser] and [src] married! D'aw."),
									span_notice("You pronounce [Kisser] and [src] married!"))
		new_partner(Kisser)
		Kisser.new_partner(src)

	//then comes a baby in a baby's carriage, or an adoption in an adoption's orphanage
	else if(Kisser.partner == src && !plush_child)	//the one advancing does not take ownership of the child and we have a one child policy in the toyshop
		user.visible_message(span_notice("[user] is going to break [Kisser] and [src] by bashing them like that."),
									span_notice("[Kisser] passionately embraces [src] in your hands. Look away you perv!"))
		user.client.give_award(/datum/award/achievement/misc/rule8, user)
		if(plop(Kisser))
			user.visible_message(span_notice("Something drops at the feet of [user]."),
							span_notice("The miracle of oh god did that just come out of [src]?!"))

	//then comes protection, or abstinence if we are catholic
	else if(Kisser.partner == src && plush_child)
		user.visible_message(span_notice("[user] makes [Kisser] nuzzle [src]!"),
									span_notice("You make [Kisser] nuzzle [src]!"))

	//then oh fuck something unexpected happened
	else
		user.show_message(span_warning("[Kisser] and [src] don't know what to do with one another."), NONE)

/obj/item/toy/plush/proc/heartbreak(obj/item/toy/plush/Brutus)
	if(lover != Brutus)
		to_chat(world, "lover != Brutus")
		return	//why are we considering someone we don't love?

	scorned.Add(Brutus)
	Brutus.scorned_by(src)

	lover = null
	Brutus.lover = null	//feeling's mutual

	heartbroken = TRUE
	mood_message = pick(heartbroken_message)

	if(partner == Brutus)	//oh dear...
		partner = null
		Brutus.partner = null	//it'd be weird otherwise
		vowbroken = TRUE
		mood_message = pick(vowbroken_message)

	update_desc()

/obj/item/toy/plush/proc/scorned_by(obj/item/toy/plush/Outmoded)
	scorned_by.Add(Outmoded)

/obj/item/toy/plush/proc/new_lover(obj/item/toy/plush/Juliet)
	if(lover == Juliet)
		return	//nice try
	lover = Juliet

	cheer_up()
	lover.cheer_up()

	mood_message = pick(love_message)
	update_desc()

	if(partner)	//who?
		partner = null	//more like who cares

/obj/item/toy/plush/proc/new_partner(obj/item/toy/plush/Apple_of_my_eye)
	if(partner == Apple_of_my_eye)
		return	//double marriage is just insecurity
	if(lover != Apple_of_my_eye)
		return	//union not born out of love will falter

	partner = Apple_of_my_eye

	heal_memories()
	partner.heal_memories()

	mood_message = pick(partner_message)
	update_desc()

/obj/item/toy/plush/proc/plop(obj/item/toy/plush/Daddy)
	if(partner != Daddy)
		return	FALSE //we do not have bastards in our toyshop

	if(is_type_in_typecache(Daddy, breeding_blacklist))
		return FALSE // some love is forbidden

	if(prob(50))	//it has my eyes
		plush_child = new type(get_turf(loc))
	else	//it has your eyes
		plush_child = new Daddy.type(get_turf(loc))

	plush_child.make_young(src, Daddy)

/obj/item/toy/plush/proc/make_young(obj/item/toy/plush/Mama, obj/item/toy/plush/Dada)
	if(Mama == Dada)
		return	//cloning is reserved for plants and spacemen

	maternal_parent = Mama
	paternal_parent = Dada
	young = TRUE
	name = "[Mama] Jr"	//Icelandic naming convention pending
	normal_desc = "[src] is a little baby of [maternal_parent] and [paternal_parent]!"	//original desc won't be used so the child can have moods
	update_desc()

	Mama.mood_message = pick(Mama.parent_message)
	Mama.update_desc()
	Dada.mood_message = pick(Dada.parent_message)
	Dada.update_desc()

/obj/item/toy/plush/proc/bad_news(obj/item/toy/plush/Deceased)	//cotton to cotton, sawdust to sawdust
	var/is_that_letter_for_me = FALSE
	if(partner == Deceased)	//covers marriage
		is_that_letter_for_me = TRUE
		partner = null
		lover = null
	else if(lover == Deceased)	//covers lovers
		is_that_letter_for_me = TRUE
		lover = null

	//covers children
	if(maternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		maternal_parent = null

	if(paternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		paternal_parent = null

	//covers parents
	if(plush_child == Deceased)
		is_that_letter_for_me = TRUE
		plush_child = null

	//covers bad memories
	if(Deceased in scorned)
		scorned.Remove(Deceased)
		cheer_up()	//what cold button eyes you have

	if(Deceased in scorned_by)
		scorned_by.Remove(Deceased)

	//all references to the departed should be cleaned up by now

	if(is_that_letter_for_me)
		heartbroken = TRUE
		mood_message = pick(heartbroken_message)
		update_desc()

/obj/item/toy/plush/proc/cheer_up()	//it'll be all right
	if(!heartbroken)
		return	//you cannot make smile what is already
	if(vowbroken)
		return	//it's a pretty big deal

	heartbroken = !heartbroken

	if(mood_message in heartbroken_message)
		mood_message = null
	update_desc()

/obj/item/toy/plush/proc/heal_memories()	//time fixes all wounds
	if(!vowbroken)
		vowbroken = !vowbroken
		if(mood_message in vowbroken_message)
			mood_message = null
	cheer_up()

/obj/item/toy/plush/update_desc()
	desc = normal_desc
	. = ..()
	if(mood_message)
		desc += mood_message

/obj/item/toy/plush/carpplushie
	name = "space carp plushie"
	desc = "An adorable stuffed toy that resembles a space carp."
	icon_state = "carpplush"
	item_state = "carp_plushie"
	attack_verb = list("bitten", "eaten", "fin slapped")
	squeak_override = list('sound/weapons/bite.ogg'=1)

/obj/item/toy/plush/bubbleplush
	name = "\improper Bubblegum plushie"
	desc = "The friendly red demon that gives good miners gifts."
	icon_state = "bubbleplush"
	attack_verb = list("rent")
	squeak_override = list('sound/magic/demon_attack1.ogg'=1)

/obj/item/toy/plush/plushvar
	name = "\improper Ratvar plushie"
	desc = "An adorable plushie of the clockwork justiciar himself with new and improved spring arm action."
	icon_state = "plushvar"
	divine = TRUE
	var/obj/item/toy/plush/narplush/clash_target
	gender = MALE	//he's a boy, right?

/obj/item/toy/plush/plushvar/Moved()
	. = ..()
	if(clash_target)
		return
	var/obj/item/toy/plush/narplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clashing)
		clash_of_the_plushies(P)

/obj/item/toy/plush/plushvar/proc/clash_of_the_plushies(obj/item/toy/plush/narplush/P)
	clash_target = P
	P.clashing = TRUE
	say("YOU.")
	P.say("Ratvar?!")
	var/obj/item/toy/plush/a_winnar_is
	var/victory_chance = 10
	for(var/i in 1 to 10) //We only fight ten times max
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(!Adjacent(P))
			visible_message(span_warning("The two plushies angrily flail at each other before giving up."))
			clash_target = null
			P.clashing = FALSE
			return
		playsound(src, 'sound/magic/clockwork/ratvar_attack.ogg', 50, TRUE, frequency = 2)
		sleep(2.4)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = src
			break
		P.SpinAnimation(5, 0)
		sleep(5)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		playsound(P, 'sound/magic/clockwork/narsie_attack.ogg', 50, TRUE, frequency = 2)
		sleep(3.3)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = P
			break
		SpinAnimation(5, 0)
		victory_chance += 10
		sleep(5)
	if(!a_winnar_is)
		a_winnar_is = pick(src, P)
	if(a_winnar_is == src)
		say(pick("DIE.", "ROT."))
		P.say(pick("Nooooo...", "Not die. To y-", "Die. Ratv-", "Sas tyen re-"))
		playsound(src, 'sound/magic/clockwork/anima_fragment_attack.ogg', 50, TRUE, frequency = 2)
		playsound(P, 'sound/magic/demon_dies.ogg', 50, TRUE, frequency = 2)
		explosion(P, 0, 0, 1)
		qdel(P)
		clash_target = null
	else
		say("NO! I will not be banished again...")
		P.say(pick("Ha.", "Ra'sha fonn dest.", "You fool. To come here."))
		playsound(src, 'sound/magic/clockwork/anima_fragment_death.ogg', 62, TRUE, frequency = 2)
		playsound(P, 'sound/magic/demon_attack1.ogg', 50, TRUE, frequency = 2)
		explosion(src, 0, 0, 1)
		qdel(src)
		P.clashing = FALSE

/obj/item/toy/plush/narplush
	name = "\improper Nar'Sie plushie"
	desc = "A small stuffed doll of the elder goddess Nar'Sie. Who thought this was a good children's toy?"
	icon_state = "narplush"
	divine = TRUE
	var/clashing
	gender = FEMALE	//it's canon if the toy is

/obj/item/toy/plush/narplush/Moved()
	. = ..()
	var/obj/item/toy/plush/plushvar/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clash_target && !clashing)
		P.clash_of_the_plushies(src)

/obj/item/toy/plush/lizardplushie
	name = "lizard plushie"
	desc = "An adorable stuffed toy that resembles a lizard."
	icon_state = "plushie_lizard"
	item_state = "plushie_lizard"
	attack_verb = list("clawed", "hissed", "tail slapped")
	squeak_override = list('sound/weapons/slash.ogg' = 1)

/obj/item/toy/plush/snakeplushie
	name = "snake plushie"
	desc = "An adorable stuffed toy that resembles a snake. Not to be mistaken for the real thing."
	icon_state = "plushie_snake"
	item_state = "plushie_snake"
	attack_verb = list("bitten", "hissed", "tail slapped")
	squeak_override = list('sound/weapons/bite.ogg' = 1)

/obj/item/toy/plush/nukeplushie
	name = "operative plushie"
	desc = "A stuffed toy that resembles a syndicate nuclear operative. The tag claims operatives to be purely fictitious."
	icon_state = "plushie_nuke"
	item_state = "plushie_nuke"
	attack_verb = list("shot", "nuked", "detonated")
	squeak_override = list('sound/effects/hit_punch.ogg' = 1)

/obj/item/toy/plush/slimeplushie
	name = "slime plushie"
	desc = "An adorable stuffed toy that resembles a slime. It is practically just a hacky sack."
	icon_state = "plushie_slime"
	item_state = "plushie_slime"
	attack_verb = list("blorbled", "slimed", "absorbed")
	squeak_override = list('sound/effects/blobattack.ogg' = 1)
	gender = FEMALE	//given all the jokes and drawings, I'm not sure the xenobiologists would make a slimeboy

/obj/item/toy/plush/awakenedplushie
	name = "awakened plushie"
	desc = "An ancient plushie that has grown enlightened to the true nature of reality."
	icon_state = "plushie_awake"
	item_state = "plushie_awake"

/obj/item/toy/plush/awakenedplushie/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/edit_complainer)

/obj/item/toy/plush/beeplushie
	name = "bee plushie"
	desc = "A cute toy that resembles an even cuter bee."
	icon_state = "plushie_h"
	item_state = "plushie_h"
	attack_verb = list("stung")
	gender = FEMALE
	squeak_override = list('sound/voice/moth/scream_moth.ogg'=1)

/obj/item/toy/plush/goatplushie
	name = "strange goat plushie"
	icon_state = "goat"
	desc = "Despite its cuddly appearance and plush nature, it will beat you up all the same. Goats never change."

/obj/item/toy/plush/goatplushie/angry
	var/mob/living/carbon/target
	throwforce = 6
	var/cooldown = 0
	var/cooldown_modifier = 20

/obj/item/toy/plush/goatplushie/angry/Initialize()
	. = ..()
	START_PROCESSING(SSprocessing, src)

/obj/item/toy/plush/goatplushie/angry/process(seconds_per_tick)
	if (prob(25) && !target)
		var/list/targets_to_pick_from = list()
		for(var/mob/living/carbon/C in view(7, src))
			if(considered_alive(C.mind) && !faction_check(list("goat"), C.faction, FALSE))
				targets_to_pick_from += C
		if (!targets_to_pick_from.len)
			return
		target = pick(targets_to_pick_from)
		visible_message(span_notice("[src] stares at [target]."))
	if (world.time > cooldown && target)
		ram()

/obj/item/toy/plush/goatplushie/angry/proc/ram()
	if(prob(90) && isturf(loc) && considered_alive(target.mind) && !faction_check(list("goat"), target.faction, FALSE))
		throw_at(target, 10, 10)
		visible_message(span_danger("[src] rams [target]!"))
		cooldown = world.time + cooldown_modifier
	target = null
	visible_message(span_notice("[src] looks disinterested."))

/obj/item/toy/plush/goatplushie/angry/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/toy/plush/goatplushie
	squeak_override = list('sound/items/goatsound.ogg'=1)

/obj/item/toy/plush/goatplushie/angry/realgoat
	name = "goat plushie"
	icon_state = "realgoat"

/obj/item/toy/plush/realgoat
	name = "goat plushie"
	desc = "Despite its cuddly appearance and plush nature, it will beat you up all the same... or at least it would if it wasn't a normal plushie."
	icon_state = "realgoat"
	squeak_override = list('sound/items/goatsound.ogg'=1)

/obj/item/toy/plush/moth
	name = "moth plushie"
	desc = "A plushie depicting an adorable mothperson, featuring realistic mothperson agony sounds every time you hug it."
	icon_state = "moffplush"
	item_state = "moffplush"
	attack_verb = list("fluttered", "flapped")
	squeak_override = list('sound/voice/moth/scream_moth.ogg'=1)


/obj/item/toy/plush/moth/monarch
	name = "monarch moth plushie"
	desc = "An adorable mothperson plushy. It's an important bug!"
	icon_state = "moffplush_monarch"

/obj/item/toy/plush/moth/luna
	name = "luna moth plushie"
	desc = "An adorable mothperson plushy. It's a lunar bug!"
	icon_state = "moffplush_luna"

/obj/item/toy/plush/moth/atlas
	name = "atlas moth plushie"
	desc = "An adorable mothperson plushy. It's a wide bug!"
	icon_state = "moffplush_atlas"

/obj/item/toy/plush/moth/redish
	name = "redish moth plushie"
	desc = "An adorable mothperson plushy. It's a red bug!"
	icon_state = "moffplush_redish"

/obj/item/toy/plush/moth/royal
	name = "royal moth plushie"
	desc = "An adorable mothperson plushy. It's a royal bug!"
	icon_state = "moffplush_royal"

/obj/item/toy/plush/moth/gothic
	name = "gothic moth plushie"
	desc = "An adorable mothperson plushy. It's a dark bug!"
	icon_state = "moffplush_gothic"

/obj/item/toy/plush/moth/lovers
	name = "lovers moth plushie"
	desc = "An adorable mothperson plushy. It's a lovely bug!"
	icon_state = "moffplush_lovers"

/obj/item/toy/plush/moth/whitefly
	name = "whitefly moth plushie"
	desc = "An adorable mothperson plushy. It's a shy bug!"
	icon_state = "moffplush_whitefly"

/obj/item/toy/plush/moth/punished
	name = "punished moth plushie"
	desc = "An adorable mothperson plushy. It's a sad bug... that's quite sad actually."
	icon_state = "moffplush_punished"

/obj/item/toy/plush/moth/firewatch
	name = "firewatch moth plushie"
	desc = "An adorable mothperson plushy. It's a firey bug!"
	icon_state = "moffplush_firewatch"

/obj/item/toy/plush/moth/deadhead
	name = "deadhead moth plushie"
	desc = "An adorable mothperson plushy. It's a silent bug!"
	icon_state = "moffplush_deadhead"

/obj/item/toy/plush/moth/poison
	name = "poison moth plushie"
	desc = "An adorable mothperson plushy. It's a toxic bug!"
	icon_state = "moffplush_poison"

/obj/item/toy/plush/moth/ragged
	name = "ragged moth plushie"
	desc = "An adorable mothperson plushy. It's a robust bug!"
	icon_state = "moffplush_ragged"

/obj/item/toy/plush/moth/snow
	name = "snow moth plushie"
	desc = "An adorable mothperson plushy. It's a cool bug!"
	icon_state = "moffplush_snow"

/obj/item/toy/plush/moth/clockwork
	name = "clockwork moth plushie"
	desc = "An adorable mothperson plushy. It's a precise bug!"
	icon_state = "moffplush_clockwork"

/obj/item/toy/plush/moth/moonfly
	name = "moonfly moth plushie"
	desc = "An adorable mothperson plushy. It's a nightly bug!"
	icon_state = "moffplush_moonfly"

/obj/item/toy/plush/moth/error
	name = "error moth plushie"
	desc = "An adorable mothperson plushy. It's a debuggable bug!"
	icon_state = "moffplush_random"

/obj/item/toy/plush/moth/rainbow
	name = "rainbow moth plushie"
	desc = "An adorable mothperson plushy. It's a colorful bug!"
	icon_state = "moffplush_rainbow"

/obj/item/toy/plush/spider
	name = "spider plushie"
	desc = "A plushie depicting an adorable rendition of a large spider. Additional legs give it four times the hugging power!"
	icon_state = "spiderplush"
	item_state = "spiderplush"
	attack_verb = list("bites", "skitters")
	squeak_override = list('sound/weapons/bite.ogg' = 10, 'sound/voice/hiss1.ogg' = 1, 'sound/voice/hiss2.ogg' = 1, 'sound/voice/hiss3.ogg' = 1, 'sound/voice/hiss4.ogg' = 1)
	var/spraycharges = 10
	var/max_spraycharges = 10

/obj/item/toy/plush/spider/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/stack/sheet/plastic)) // Om nom
		if(spraycharges >= max_spraycharges)
			to_chat(user, "<span class='notice'>[src] is already stuffed full!")
			return
		var/obj/item/stack/sheet/plastic/p_sheets = I
		var/usedcharges = min(max_spraycharges - spraycharges, p_sheets.get_amount())
		if(p_sheets.use(usedcharges))
			spraycharges += usedcharges
			playsound(src.loc, 'sound/weapons/bite.ogg', 40, TRUE, -6)
			to_chat(user, span_notice("You feed [src] [usedcharges] sheets of plastic."))

/obj/item/toy/plush/spider/afterattack(atom/A, mob/user)
	. = ..()
	if(istype(A, /turf/open/floor))
		if(spraycharges <= 0)
			to_chat(user, span_notice("You squeeze [src] tightly and nothing happens!"))
			return
		if(!in_range(user, A))
			return
		playsound(src.loc, 'sound/effects/spray2.ogg', 30, TRUE, -6)
		user.visible_message(span_notice("[user] sprays plastic webbing out from [src]!"), "<span class='notice'>You squeeze [src] and plastic webbing fires out!")
		new /obj/effect/decal/cleanable/sprayweb(A)
		spraycharges--

/obj/item/toy/plush/hornet
	name = "strange bug plushie"
	desc = "A cute, soft plush of a long-horned bug."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "plushie_hornet"
	attack_verb = list("poked", "shaws")
	squeak_override = list('sound/hornetnoises/hornet_gitgud.ogg'=1, 'sound/hornetnoises/hornet_SHAW.ogg'=10) //i have no clue how this works, the intended effect is that "git gud" will play 1 out of 11 times
	gender = FEMALE

/obj/item/toy/plush/hornet/gay
	name = "gay bug plushie"
	desc = "A cute, soft plush of a long-horned bug. Her cloak is in the colors of the lesbian pride flag."
	icon_state = "plushie_gayhornet"

/obj/item/toy/plush/knight
	name = "odd bug plushie"
	desc = "A cute, soft plush of a little bug. It sounds like this one didn't come with a voice box."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "plushie_knight"
	attack_verb = list("poked")
	should_squeak = FALSE

/obj/item/toy/plush/flushed
	name = "flushed plushie"
	desc = "Hgrgrhrhg cute."
	icon_state = "flushplush"

/obj/item/toy/plush/blahaj
	name = "Solarian Marine Society mascot plushie"
	desc = "The adorable little mascot of the solarian marine society. Popular with vampires."
	icon_state = "blahaj"
	item_state = "blahaj"
	lefthand_file = 'icons/mob/inhands/misc/plushes_lefthand.dmi' //todo: sort the god damn plushie inhands
	righthand_file = 'icons/mob/inhands/misc/plushes_righthand.dmi'

/obj/item/toy/plush/rilena
	name = "Ri plushie"
	desc = "A plush of the protagonist of the popular combination video game series and webcomic RILENA."// Makes the iconic hurt sound from the game!" //sadly does not :pensive:
	icon_state = "rilenaplush_ri"
	attack_verb = list("blasted", "shot", "shmupped")
	//squeak_override = list('sound/voice/ //kepori lack a voice :(
	gender = FEMALE

/obj/item/toy/plush/tali
	name = "T4L1 plushie"
	desc = "A surprisingly soft plushie of a recurring miniboss from the popular combination video game series and webcomic RILENA. The cannon arm does not function."
	icon_state = "rilenaplush_t4l1"
	attack_verb = list("blasted", "shot", "cannoned")
	gender = FEMALE

/obj/item/toy/plush/sharai
	name = "Sharai plushie"
	desc = "A plushie of the four winged kepori boss from the popular combination video game series and webcomic RILENA."
	icon_state = "rilenaplush_sharai"
	attack_verb = list("blasted", "shot", "radial bursted")
	gender = FEMALE

/obj/item/toy/plush/xader
	name = "Xader plushie"
	desc = "A plushie of the recurring transdimensional transgender shopkeep from the popular webseries RILENA."
	icon_state = "rilenaplush_xader"
	gender = FEMALE

/obj/item/toy/plush/mora
	name = "Mora plushie"
	desc = "A plushie of Mora from the popular webseries RILENA."
	icon_state = "rilenaplush_mora"
	gender = FEMALE

/obj/item/toy/plush/kari
	name = "knockoff RILENA plushie"
	desc = "A plushie of a FBP Kepori. The tag calls it 'Kari' and claims it to be from 'RAYALA: RUNNING FROM EVIL'. The cannon arm does not function."
	icon_state = "fbplush"
	gender = FEMALE

/obj/item/toy/plush/among
	name = "amoung pequeño"
	desc = "A little pill shaped guy, with a price tag of 3€."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "plushie_among"
	attack_verb = list("killed","stabbed","shot","slapped","stung", "ejected")
	squeak_override = list('sound/hornetnoises/agoguskill.ogg')
	var/random_among = TRUE //if the (among) uses random coloring
	var/rare_among = 1 //chance for rare color variant


	var/static/list/among_colors = list(\
		"red" = "#c51111",
		"blue" = "#123ed1",
		"green" = "#117f2d",
		"pink" = "#ed54ba",
		"orange" = "#ef7d0d",
		"yellow" = "#f5f557",
		"black" = "#3f474e",
		"white" = "#d6e0f0",
		"purple" = "#6b2fbb",
		"brown" = "#71491e",
		"cyan" = "#39FEDD",
		"lime" = "#4EEF38",
	)
	var/static/list/among_colors_rare = list(\
		"puce" = "#CC8899",
	)

/obj/item/toy/plush/among/Initialize(mapload)
	. = ..()
	among_randomify(rare_among)

/obj/item/toy/plush/among/proc/among_randomify(rare_among)
	if(random_among)
		var/among_color
		if(prob(rare_among))
			among_color = pick(among_colors_rare)
			add_atom_colour(among_colors_rare[among_color], FIXED_COLOUR_PRIORITY)
		else
			among_color = pick(among_colors)
			add_atom_colour(among_colors[among_color], FIXED_COLOUR_PRIORITY)
		add_among_overlay()

/obj/item/toy/plush/among/proc/add_among_overlay()
	if(!random_among)
		return
	cut_overlays()
	var/mutable_appearance/base_overlay_among = mutable_appearance(icon, "plushie_among_visor")
	base_overlay_among.appearance_flags = RESET_COLOR
	add_overlay(base_overlay_among)

/obj/item/toy/plush/frederick
	name = "Frederick plushie"
	desc = "A plushie of Frederick, a lovable dragon head cricket."
	icon_state = "plushie_frederick"
	gender = MALE

/obj/item/toy/plush/landmine
	name = "\improper G-80 Landmine plushie"
	desc = "A plushie depicting an adorable anti-infantry explosive. Just don't step on it."
	icon = 'icons/obj/landmine.dmi'
	icon_state = "mine_armed"
	should_squeak = FALSE

/obj/item/toy/plush/landmine/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/plush/landmine/proc/on_entered(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER
	if(!(arrived.movement_type == GROUND))
		return

	if(ismob(arrived))
		var/mob/living/fool = arrived
		fool.do_alert_animation(fool)
		fool.Immobilize(15 DECISECONDS, TRUE) // Shorter because it's fake
		to_chat(fool, span_userdanger("You step on \the [src] and freeze."))
		visible_message(span_danger("[icon2html(src, viewers(src))] *click*"))
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)

/obj/item/toy/plush/landmine/proc/on_exited(datum/source, atom/movable/gone)
	SIGNAL_HANDLER
	if(!isturf(loc) || iseffect(gone) || istype(gone, /obj/item/mine))
		return
	playsound(src, 'sound/items/mine_activate_short.ogg', 80, FALSE)

