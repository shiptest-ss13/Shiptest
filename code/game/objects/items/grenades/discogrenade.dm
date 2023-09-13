//Ethereal Disco Grenade for Ethereal traitors
//Does not affect ethereals.
//Some basic code pieces taken from flashbang, spawner grenade and ethereal disco ball for functionality (basically a combination of the 3).

//////////////////////
// Primary grenade  //
//////////////////////

/obj/item/grenade/discogrenade
	name = "Ethereal Disco Grenade"
	desc = "An unethical micro-party that will make all non-Ethereal beings dance to its beat!"
	icon_state = "disco"
	item_state = "flashbang"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	var/list/messages = list("This party is great!", "Wooo!!!", "Party!", "Check out these moves!", "Hey, want to dance with me?")
	var/list/message_social_anxiety = list("I want to go home...", "Where are the toilets?", "I don't like this song.")

/obj/item/grenade/discogrenade/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	var/current_turf = get_turf(src)
	if(!current_turf)
		return

	playsound(current_turf, 'sound/weapons/flashbang.ogg', 100, TRUE, 8, 0.9)

	new /obj/structure/etherealball(current_turf)

	for(var/i in 1 to 6)
		new /obj/item/grenade/discogrenade/subgrenade(current_turf, TRUE)

	qdel(src)

//////////////////////
//   Sub grenades   //
//////////////////////

/obj/item/grenade/discogrenade/subgrenade
	name = "Micro Disco"
	desc = "A massive disco contained in a tiny package!"
	icon_state = "disco"
	item_state = "disco"
	var/spawn_new = TRUE
	var/timerID
	var/lightcolor
	var/range = 5
	var/power = 3

/obj/item/grenade/discogrenade/subgrenade/Initialize(mapload, duplicate = FALSE)
	. = ..()
	active = TRUE
	spawn_new = duplicate
	icon_state = initial(icon_state) + "_active"
	var/launch_distance = rand(2, 6)
	for(var/i in 1 to launch_distance)
		step_away(src, loc)
	addtimer(CALLBACK(src, .proc/prime), rand(10, 60))
	randomiseLightColor()

/obj/item/grenade/discogrenade/subgrenade/prime(mob/living/lanced_by)
	update_mob()
	var/current_turf = get_turf(src)
	if(!current_turf)
		return

	playsound(current_turf, 'sound/weapons/flashbang.ogg', 30, TRUE, 8, 0.9)
	playsound(current_turf, pick('sound/runtime/instruments/accordion/Dn2.mid', 'sound/runtime/instruments/bikehorn/Cn3.ogg', 'sound/runtime/instruments/piano/Dn7.ogg', 'sound/runtime/instruments/violin/Cn3.mid'), 100, TRUE, 8, 0.9)

	if(spawn_new)
		for(var/i in 1 to 3)
			new /obj/item/grenade/discogrenade/subgrenade(current_turf)

	//Create the lights
	new /obj/effect/dummy/lighting_obj (current_turf, rand_hex_color(), 4, 1, 10)

	for(var/mob/living/carbon/human/victim in hearers(4, src))
		forcedance(get_turf(victim), victim)
	qdel(src)

/obj/item/grenade/discogrenade/subgrenade/proc/randomiseLightColor()
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	lightcolor = random_color()
	set_light(range, power, lightcolor)
	add_atom_colour("#[lightcolor]", FIXED_COLOUR_PRIORITY)
	update_appearance()
	timerID = addtimer(CALLBACK(src, .proc/randomiseLightColor), 2, TIMER_STOPPABLE)

/obj/item/grenade/discogrenade/subgrenade/proc/forcedance(turf/target_turf , mob/living/carbon/human/target)
	if(!target_turf)
		return
	if(target.stat != CONSCIOUS)	//Only conscious people can dance
		return
	if(!target || isethereal(target))	//Non humans and non etherals can't dance
		return

	var/distance = max(0,get_dist(get_turf(src), target_turf))
	if(distance > 2.5)
		return

	if(target.has_quirk(/datum/quirk/social_anxiety))
		target.say(pick(message_social_anxiety))
		if(rand(3) && target.get_ear_protection() == 0)
			target.drop_all_held_items()
			target.show_message("<span class='warning'>You cover your ears, the music is just too loud for you.</span>", 2)
		return

	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		target.show_message("<span class='warning'>You resist your inner urges to break out your best moves.</span>", 2)
		target.set_drugginess(5)
		return
	if(istype(target.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/foilhat))
		to_chat(target, "<span class = 'userdanger'>THOSE GLOW-IN-THE-DARK NANOTRASEN LIGHTBULBS WON'T CORRUPT ME WITH THEIR AGENDA!</span>")
		target.emote("scream")
		return

	target.set_drugginess(10)
	target.show_message("<span class='warning'>You feel a strong rythme and your muscles spasm uncontrollably, you begin dancing and cannot move!</span>", 2)
	target.Immobilize(30)

	//Special actions
	switch(rand(0, 6))
		if(0)
			target.Knockdown(4)
			target.show_message("<span class='warning'>You [pick("mess", "screw")] up your moves and trip!</span>", 2)
		if(1 to 3)
			target.emote("spin")
		if(3 to 4)
			target.emote("flip")
		if(5)
			target.say(pick(messages))
		if(6)
			target.emote("dance")

/proc/rand_hex_color()
	var/list/colors = list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
	var/picked_color=""
	for (var/i=0;i<6;i++)
		picked_color = picked_color+pick(colors)
	return picked_color
