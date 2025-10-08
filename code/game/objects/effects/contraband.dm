// This is synced up to the poster placing animation.
#define PLACE_SPEED 3.7 SECONDS
#define POSTER_NORANDOM 0 //no random poster
#define POSTER_SUBTYPES 1 //chooses from subtypes of the poster_type var
#define POSTER_LIST 2 // chooses from a list
#define POSTER_ADD_FROM_LIST 3 //adds to the subtypes pool from list
// The poster item

/obj/item/poster
	name = "poorly coded poster"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = 0
	resistance_flags = FLAMMABLE
	var/poster_type
	var/obj/structure/sign/poster/poster_structure

/obj/item/poster/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	poster_structure = new_poster_structure
	if(!new_poster_structure && poster_type)
		poster_structure = new poster_type(src)

	// posters store what name and description they would like their
	// rolled up form to take.
	if(poster_structure)
		name = poster_structure.poster_item_name
		desc = poster_structure.poster_item_desc
		icon_state = poster_structure.poster_item_icon_state

		name = "[name] - [poster_structure.original_name]"

/obj/item/poster/Destroy()
	poster_structure = null
	. = ..()

// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "random contraband poster"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_official
	name = "random official poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

/obj/item/poster/random_retro
	name = "random retro poster"
	poster_type = /obj/structure/sign/poster/retro/random
	icon_state = "rolled_legit"

/obj/item/poster/random_solgov
	name = "random solarian poster"
	poster_type = /obj/structure/sign/poster/solgov/random
	icon_state = "rolled_solgov"

/obj/item/poster/random_minutemen
	name = "random clip poster"
	poster_type = /obj/structure/sign/poster/clip/random
	icon_state = "rolled_legit"

/obj/item/poster/random_rilena
	name = "random rilena poster"
	poster_type = /obj/structure/sign/poster/rilena/random
	icon_state = "rolled_rilena"

// The poster sign/structure

/obj/structure/sign/poster
	name = "poster"
	var/original_name
	desc = "A large piece of space-resistant printed paper."
	icon = 'icons/obj/contraband.dmi'
	icon_state = "poster_ripped"
	anchored = TRUE
	var/ruined = FALSE
	/// how do we want to handle the random poster pool? POSTER_SUBTYPES chooses randomly from subtypes, AKA how it was handled before
	var/random_type = POSTER_NORANDOM
	///if above is POSTER_SUBTYPES then what which subtypes we want to pull from?
	var/random_basetype
	///if random_type is either POSTER_LIST or POSTER_ADD_FROM_LIST then what is the pool of posters we want to pull from/ add from?
	var/list/random_pool
	/// Do we want to never appear in the random poster pool? Used in the random subtype to prevent infinite loops of random posters, and the NO ERP poster to make it effectively admin only.
	var/never_random = FALSE

	var/poster_item_name = "hypothetical poster"
	var/poster_item_desc = "This hypothetical poster item should not exist, let's be honest here."
	var/poster_item_icon_state = "rolled_poster"
	var/poster_item_type = /obj/item/poster

/obj/structure/sign/poster/Initialize()
	. = ..()
	if(random_type)
		randomise()
	if(!ruined)
		original_name = name // can't use initial because of random posters
		name = "poster - [name]"
		desc = "A large piece of space-resistant printed paper. [desc]"

	AddElement(/datum/element/beauty, 300)

/obj/structure/sign/poster/proc/randomise()
	var/obj/structure/sign/poster/selected

	if(random_type == POSTER_LIST)// i feel like im making the problem worse instead of fixing it
		if(!random_pool)
			CRASH("A poster is set to select from a list, but has none!")
		selected = pick(random_pool)
	if(random_type == POSTER_SUBTYPES || random_type == POSTER_ADD_FROM_LIST)
		var/list/poster_types = subtypesof(random_basetype)
		var/list/approved_types = list()
		if(random_type == POSTER_ADD_FROM_LIST)
			if(!random_pool)
				CRASH("A poster is set to select from a list, but has none!")
			LAZYADD(poster_types, random_pool)
		for(var/obj/structure/sign/poster/current_poster as anything in poster_types)
			if(initial(current_poster.icon_state) && !initial(current_poster.never_random))
				approved_types |= current_poster
		selected = pick(approved_types)

	name = initial(selected.name)
	desc = initial(selected.desc)
	icon_state = initial(selected.icon_state)
	poster_item_name = initial(selected.poster_item_name)
	poster_item_desc = initial(selected.poster_item_desc)
	poster_item_icon_state = initial(selected.poster_item_icon_state)
	ruined = initial(selected.ruined)


/obj/structure/sign/poster/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		I.play_tool_sound(src, 100)
		if(ruined)
			to_chat(user, span_notice("You remove the remnants of the poster."))
			qdel(src)
		else
			to_chat(user, span_notice("You carefully remove the poster from the wall."))
			roll_and_drop(user.loc)

/obj/structure/sign/poster/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(ruined)
		return
	if(user.a_intent != INTENT_HARM)
		to_chat(user, span_danger("You aren't HARMFUL enough to rip the poster off the wall.")) //preventing accidental ripping posters off wall if not on harm intent
		return

	visible_message(span_danger("[user] rips [src] in a single, decisive motion!") )
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, TRUE)

	var/obj/structure/sign/poster/ripped/R = new(loc)
	R.pixel_y = pixel_y
	R.pixel_x = pixel_x
	R.add_fingerprint(user)
	qdel(src)

/obj/structure/sign/poster/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/poster/proc/roll_and_drop(loc)
	pixel_x = 0
	pixel_y = 0
	var/obj/item/poster/P = new poster_item_type(loc, src)
	forceMove(P)
	return P

//separated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/closed/wall/proc/place_poster(obj/item/poster/P, mob/user)
	if(!P.poster_structure)
		to_chat(user, span_warning("[P] has no poster... inside it? Inform a coder!"))
		return

	// Deny placing posters on currently-diagonal walls, although the wall may change in the future.
	if (smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		for (var/O in overlays)
			var/image/I = O
			if(copytext(I.icon_state, 1, 3) == "d-") //3 == length("d-") + 1
				return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O, /obj/structure/sign/poster))
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return

	to_chat(user, span_notice("You start placing the poster on the wall...")	)

	var/obj/structure/sign/poster/D = P.poster_structure

	var/temp_loc = get_turf(user)
	flick("poster_being_set",D)
	D.forceMove(src)
	qdel(P)	//delete it now to cut down on sanity checks afterwards. Agouri's code supports rerolling it anyway
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, TRUE)

	if(do_after(user, PLACE_SPEED, target=src))
		if(!D || QDELETED(D))
			return

		if(iswallturf(src) && user && user.loc == temp_loc)	//Let's check if everything is still there
			to_chat(user, span_notice("You place the poster!"))
			return

	to_chat(user, span_notice("The poster falls down!"))
	D.roll_and_drop(temp_loc)

// Various possible posters follow

/obj/structure/sign/poster/ripped
	ruined = TRUE
	icon_state = "poster_ripped"
	name = "ripped poster"
	desc = "You can't make out anything from the poster's original print. It's ruined."

//begin contraband pool, Expect anything, really. Mostly used by indies.
/obj/structure/sign/poster/random
	name = "random poster" // could even be ripped
	icon_state = "random_anything"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/contraband
	poster_item_name = "contraband poster"
	poster_item_desc = "This poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface. Its vulgar themes have marked it as contraband aboard Nanotrasen space facilities."
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband
	random_type = POSTER_ADD_FROM_LIST // what this does is add the SUNS poster, which would usually only be in the solgov poster pool to the contraband pool.
	random_pool = list(
		/obj/structure/sign/poster/solgov/suns,
		/obj/structure/sign/poster/official/ion_carbine,
		/obj/structure/sign/poster/official/mini_energy_gun,
		)


/obj/structure/sign/poster/contraband/free_tonto
	name = "Free Tonto"
	desc = "You're... not exactly sure what this is. In fact, nobody knows what it is, but its one of the few pieces of non-digital media that was found intact after the Night of Fire, making it a popular aesthetic, even if nobody knows what it is."
	icon_state = "poster_2012"

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "Atmosia Declaration of Independence"
	desc = "A relic of a failed rebellion on a Nanotrasen station, highly ridiculed due to the absurdity of it."
	icon_state = "poster_independence"

/obj/structure/sign/poster/contraband/fun_police
	name = "Fun Police"
	desc = "A poster condemning Nanotrasen's corporate security forces about being the 'fun police.' The creator of this poster is currently in jail for 2 counts of manslaughter and 1 murder."
	icon_state = "poster_fun_police"

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "Lusty Xenomorph"
	desc = "A heretical poster depicting the titular star of an equally heretical book. Wow, this would be extremely offensive to anyone in CLIP."
	icon_state = "poster_xeno" //i dont even know how to redo this one

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "ACLF Recruitment"
	desc = "A old poster urging people to join the ACLF for not only the right cause, but to explore the galaxy. This is probably outdated."
	icon_state = "poster_aclf_enlistment"

/obj/structure/sign/poster/contraband/smoke
	name = "Smoke"
	desc = "A poster advertising some brand of cigarettes."
	icon_state = "poster_smoke"

/obj/structure/sign/poster/contraband/grey_tide
	name = "Grey Tide"
	desc = "A rebellious poster symbolizing the grey horde."
	icon_state = "poster_greytide"

/obj/structure/sign/poster/contraband/missing_gloves
	name = "Missing Gloves"
	desc = "This poster references the uproar that followed Nanotrasen's financial cuts toward insulated-glove purchases."
	icon_state = "poster_insul_gloves"

/obj/structure/sign/poster/contraband/hacking_guide
	name = "Hacking Guide"
	desc = "This poster details the internal workings of the common airlock. Sadly, it appears out of date."
	icon_state = "poster_airlock_hack"

/obj/structure/sign/poster/contraband/rip_badger
	name = "RIP Badgers"
	desc = "A advertisement for a documentary about how some animal called 'badgers' went extinct after the Night of Fire."
	icon_state = "poster_rip_badgers"

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "Ambrosia Vulgaris"
	desc = "This poster is lookin' pretty trippy man."
	icon_state = "poster_ambrosia"

/obj/structure/sign/poster/contraband/donut_corp
	name = "Donut Corp."
	desc = "This poster is an unauthorized advertisement for Donut Corp."
	icon_state = "poster_donut"

/obj/structure/sign/poster/contraband/eat
	name = "EAT."
	desc = "This poster promotes rank gluttony."
	icon_state = "poster_eat"

/obj/structure/sign/poster/contraband/tools
	name = "Tools"
	desc = "This poster looks like an advertisement for tools, but is in fact a subliminal jab at the tools on Nanotrasen stations."
	icon_state = "poster_tools"

/obj/structure/sign/poster/contraband/power
	name = "Power"
	desc = "A poster that details the dangerously unsafe power generation methods of most stations."
	icon_state = "poster_power"

/obj/structure/sign/poster/contraband/space_cube
	name = "Space Cube"
	desc = "Ignorant of Nature's Harmonic 6 Side Space Cube Creation, the Spacemen are Dumb, Educated Singularity Stupid and Evil."
	icon_state = "poster_cube"

/obj/structure/sign/poster/contraband/gec
	name = "GEC poster"
	desc = "The logo of the good old Galactic Engineer's Concordat. The poster itself is pretty robust."
	icon_state = "poster_gec"

/obj/structure/sign/poster/contraband/xenofauna_parasite
	name = "Xenofauna parasite"
	desc = "This poster details all the dangers of xenofauna infestation and how to avoid a infestation whenever possible."
	icon_state = "poster_facehugger"

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "Borg Fancy"
	desc = "Being fancy can be for any borg, just need a suit."
	icon_state = "poster_borg"

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "Borg Fancy v2"
	desc = "Borg Fancy, Now only taking the most fancy."
	icon_state = "poster_fancy_borg"

/obj/structure/sign/poster/contraband/ss13
	name = "Space Station 13 Does Not Exist"
	desc = "A poster mocking CentCom's extreme cover and secrecy up of NTRSS-13, that was so extensive that not even CentCom themselves knows what happened to it."
	icon_state = "poster_ss13"

/obj/structure/sign/poster/contraband/engis_unite
	name = "Engineers Unite!"
	desc = "A poster sponsered by the Galactic Engineer's Concordat urging to vote YES to the formation of a engineers union on NT Shipyard 22-A."
	icon_state = "poster_unite"

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "Cobra 20"
	desc = "A poster advertising the Scarborough Arms C-20r. It seems the company is trying to distance itself from the syndicate by using the civillian name rather than the Syndicate name."
	icon_state = "poster_cobra"

/obj/structure/sign/poster/contraband/have_a_puff
	name = "Have a Puff"
	desc = "Who cares about lung cancer when you're high as a kite?"
	icon_state = "poster_puff"

/obj/structure/sign/poster/contraband/peacemaker
	name = "Peacemaker"
	desc = "A poster advertising the Hunter's Pride Peacemaker and .38 Caliber bullets."
	icon_state = "poster_peacemaker"

/obj/structure/sign/poster/contraband/twelve_gauge
	name = "12 Gauge"
	desc = "A poster advertising Hunter's Pride manufactored 12 gauge shells and shotguns."
	icon_state = "poster_12g"

/obj/structure/sign/poster/contraband/d_day_promo
	name = "D-Day Promo"
	desc = "A promotional poster for some rapper. Famous for complaining about getting 'canceled' over supporting the Syndicate, but in reality she was banned from almost every internet and organization for praising the nuclear attack on Ares IV, responsible for the death of 96% of its population."
	icon_state = "poster_dday" // human sprite by quin

/obj/structure/sign/poster/contraband/stechkin
	name = "Ringneck Pistol"
	desc = "A poster advertising the Scarborough Arms Ringneck conealable pistol. It has a silencer attached, showing off the stealth capablities, while also looking badass as all hell."
	icon_state = "poster_stechkin"

/obj/structure/sign/poster/contraband/energy_swords
	name = "Energy Swords"
	desc = "All the colors of your favorite hardlight murder rainbows."
	icon_state = "poster_esword"

/obj/structure/sign/poster/contraband/red_rum
	name = "Red Rum"
	desc = "Looking at this poster makes you want to kill."
	icon_state = "poster_red_rum"

/obj/structure/sign/poster/contraband/ntos
	name = "Ntos V"
	desc = "A advertisement for Ntos V. Unlike earlier iterations of the system, Nanotrasen has opted to update this version continously, instead of release a new version every so often, much to the dismay of older system users."
	icon_state = "poster_ntos"

/obj/structure/sign/poster/contraband/punch_shit
	name = "Punch Shit!"
	desc = "Fight things for no reason, like a man!"
	icon_state = "poster_punch"

/obj/structure/sign/poster/contraband/the_griffin
	name = "The Griffin"
	desc = "The Griffin commands you to be the worst you can be. Will you?"
	icon_state = "poster_griffin"

/obj/structure/sign/poster/contraband/pgf
	name = "PGF Marine"
	desc = "This poster depicts a PGF marine with a E-40. \"The Pan-Gezena Federation fights for not only YOUR freedom, but the freedom of the whole galaxy!\""
	icon_state = "poster_pgf"

/obj/structure/sign/poster/contraband/free_drone
	name = "Free Drone"
	desc = "This poster is advertising a seller selling a free syndidrone. It is so obviously a scam."
	icon_state = "poster_free_drone"

/obj/structure/sign/poster/contraband/backdoor_xeno_babes_6
	name = "Backdoor Xeno Babes 6"
	desc = "... You don't even know where to start with this. Wow, this would be extremely offensive to anyone in CLIP."
	icon_state = "poster_xeno_maid"

/obj/structure/sign/poster/contraband/robustmore_drinkfoods
	name = "Robustmore Drinkfoods"
	desc = "The unholy merger between Robust Softdrinks and Getmore Chocoalate Corp: Twice the robust for half a toolbox!"
	icon_state = "poster_robustmore"

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "Shambler's Juice"
	desc = "~Shake me up some of that Shambler's Juice!~"
	icon_state = "poster_shambler"

/obj/structure/sign/poster/contraband/pwr_game
	name = "Pwr Game"
	desc = "The POWER that gamers CRAVE! In partnership with Vlad's Salad."
	icon_state = "poster_pwr"

/obj/structure/sign/poster/contraband/starkist
	name = "Star-kist"
	desc = "Drink the stars!"
	icon_state = "poster_starkist"

/obj/structure/sign/poster/contraband/space_cola
	name = "Space Cola"
	desc = "Your favorite cola, in space."
	icon_state = "poster_cola"

/obj/structure/sign/poster/contraband/space_up
	name = "Space-Up!"
	desc = "Sucked out into space by the FLAVOR!"
	icon_state = "poster_spaceup"

/obj/structure/sign/poster/contraband/kudzu
	name = "Kudzu"
	desc = "A poster advertising a movie about plants. How dangerous could they possibly be?"
	icon_state = "poster_kudzu"

/obj/structure/sign/poster/contraband/masked_men
	name = "Bumba"
	desc = "A poster advertising the movie 'Bumba,' staring a mysterous group of masked men attempting to avenge their mentor, only to uncover a conspiracy all the way to the top."
	icon_state = "poster_bumba"

/obj/structure/sign/poster/contraband/inteq
	name = "Inteq Risk Management"
	desc = "A poster advertising the IRMG's services. \"I hear you got a problem. You won't have one with us. No bullshit, guranteed.\""
	icon_state = "poster_inteq"

/obj/structure/sign/poster/contraband/space_cops
	name = "Space Cops."
	desc = "A poster advertising the television show that showcases all the hip and cool ways how the colonial police on Nagaski City abuse their power. Suprisingly effective in keeping the Nagaski City colonial police popular."
	icon_state = "poster_spacecops"

/obj/structure/sign/poster/contraband/steppyflag
	name = "Steppy Flag"
	desc = "A poster making a simple statement: \"Fuck around, Find out.\" These posters are suspiciously popular in the Northwind Shipping offices."
	icon_state = "poster_steppy"

/obj/structure/sign/poster/contraband/syndicate
	name = "Syndicate Logo"
	desc = "A poster depicting the Syndicate logo. How times have changed."
	icon_state = "poster-syndicate"

/obj/structure/sign/poster/contraband/cybersun
	name = "Cybersun Virtual Solutions"
	desc = "Cybersun, the pioneer in cybernetics and cybersecurity tech."
	icon_state = "poster-cybersun"

/obj/structure/sign/poster/contraband/cybersun_borg
	name = "Cybersun ARBITRATOR"
	desc = "An advertisement for the Cybersun \"ARBITRATOR\" line of combat medic cyborgs, targeted at private military contractors and military groups. Includes a side diagram of the internals."
	icon_state = "poster-cybersun-borg"

/obj/structure/sign/poster/contraband/cybersun_med
	name = "Cybersun Medical Solutions"
	desc = "An advertisement for various cybersun medical products, targeted at medical groups and companies. Includes a picture of the famous Medical Beamgun."
	icon_state = "poster-cybersun-med"

/obj/structure/sign/poster/contraband/aclf
	name = "Syndicate Support Poster"
	desc = "An poster made by ACLF protestors in support of the Syndicate, listing Nanotrasen's abuses of their workers. While this poster was made during for the ICW, it seems like some keep it up as it still resonates with them."
	icon_state = "poster-aclf_antint"

/obj/structure/sign/poster/contraband/bulldog
	name = "Bulldog Shotgun"
	desc = "A poster advertising the Scarborough Arms Bulldog Automatic Shotgun. \"No need to pump it, simply load the drum, and pull away.\""
	icon_state = "poster-bulldog"

/obj/structure/sign/poster/contraband/m90
	name = "M90 SMG"
	desc = "A poster advertising the Scarborough M90. Burst action with a grenade launcher, for some reason."
	icon_state = "poster-m90"

/obj/structure/sign/poster/contraband/inteq_nt
	name = "Inteq Recruitment"
	desc = "Tired of your underpaying and abusive job at Nanotrasen? Join the IRMG Artificers! You won't get bullshit from us. Retrofit spacecraft and weaponry, field test weaponry, and earn higher pay!"
	icon_state = "poster-inteq_poaching_nt"

/obj/structure/sign/poster/contraband/inteq_gec
	name = "Inteq Recruitment"
	desc = "Tired of your boring union job at the GEC? Join the IRMG Artificers! You won't get bullshit from us. Retrofit spacecraft and weaponry, field test weaponry, and earn higher pay!"
	icon_state = "poster-inteq_poaching_gec"

/obj/structure/sign/poster/contraband/winchester
	name = "Winchester"
	desc = "A poster advertising the Hunter's Pride Winchester lever action rifle and .38 Caliber bullets."
	icon_state = "poster_winchester"

/obj/structure/sign/poster/contraband/eoehoma
	name = "Eoehoma Firearms"
	desc = "Eoehoma Firearms, the galaxy's favorite laser firearm manufacturer*. \n\
	*DEFUNCT SINCE F.S. 450"
	icon_state = "poster-eoehoma"

/obj/structure/sign/poster/contraband/cardinal_fore_aft
	name = "Captain Cardinal Fore and Aft"
	desc = "Captain Cardinal would like to remind you that the front of the ship is fore, and the back of the ship is aft! Easy, right?"
	icon_state = "poster-cardinal-1"

/obj/structure/sign/poster/contraband/cardinal_port_starboard
	name = "Captain Cardinal Port and Starbird"
	desc = "Captain Cardinal would like to remind you that the left of the ship is port, and the right of the ship is starBIRD! Get it, right?"
	icon_state = "poster-cardinal-2"

//beginning of Nanotrasen approved posters. Expect corprate propaganda and motavation. You will usually only see this on Nanotrasen ships and stations
/obj/structure/sign/poster/official
	poster_item_name = "motivational poster"
	poster_item_desc = "An official Nanotrasen-issued poster to foster a compliant and obedient workforce. It comes with state-of-the-art adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/official/random
	name = "random official poster"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/official/here_for_your_safety
	name = "Here For Your Safety"
	desc = "A poster glorifying the Nanotrasen private security forces."
	icon_state = "poster_saftey"

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "\improper Nanotrasen logo"
	desc = "A poster depicting the Nanotrasen logo."
	icon_state = "poster_nanotrasen"

/obj/structure/sign/poster/official/cleanliness
	name = "Cleanliness"
	desc = "A poster warning of the dangers of poor hygiene."
	icon_state = "poster_cleanhands"

/obj/structure/sign/poster/official/help_others
	name = "Help Others"
	desc = "A poster encouraging you to help fellow crewmembers."
	icon_state = "poster_help"

/obj/structure/sign/poster/official/build
	name = "Build"
	desc = "A poster glorifying the engineering team."
	icon_state = "poster_build"

/obj/structure/sign/poster/official/bless_this_spess
	name = "Bless This Spess"
	desc = "A poster blessing this area."
	icon_state = "poster_bless"

/obj/structure/sign/poster/official/science
	name = "Science"
	desc = "A poster depicting an beaker."
	icon_state = "poster_science"

/obj/structure/sign/poster/official/ian
	name = "Ian"
	desc = "Arf arf. Yap."
	icon_state = "poster_arf"

/obj/structure/sign/poster/official/obey
	name = "Obey"
	desc = "A poster instructing the viewer to obey authority."
	icon_state = "poster_obey"

/obj/structure/sign/poster/official/walk
	name = "Walk"
	desc = "A poster instructing the viewer to walk instead of running."
	icon_state = "poster_walk"

/obj/structure/sign/poster/official/love_ian
	name = "Love Ian"
	desc = "Ian is love, Ian is life."
	icon_state = "poster_love_ian"

/obj/structure/sign/poster/official/ue_no
	name = "Ue No."
	desc = "This thing is all in a foreign language."
	icon_state = "poster_anime"

/obj/structure/sign/poster/official/get_your_legs
	name = "Get Your LEGS"
	desc = "LEGS: Leadership, Experience, Genius, Subordination."
	icon_state = "poster_legs"

/obj/structure/sign/poster/official/do_not_question
	name = "Do Not Question"
	desc = "A poster instructing the viewer not to ask about things they aren't meant to know."
	icon_state = "poster_question"

/obj/structure/sign/poster/official/work_for_a_future
	name = "Work For A Future"
	desc = " A poster encouraging you to work for your future."
	icon_state = "poster_future"

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "Soft Cap Pop Art"
	desc = "A poster reprint of some cheap pop art."
	icon_state = "poster_art"

/obj/structure/sign/poster/official/safety_internals
	name = "Safety: Internals"
	desc = "A poster instructing the viewer to wear internals in the rare environments where there is no oxygen or the air has been rendered toxic."
	icon_state = "poster_internals"

/obj/structure/sign/poster/official/safety_eye_protection
	name = "Safety: Eye Protection"
	desc = "A poster instructing the viewer to wear eye protection when dealing with chemicals, smoke, or bright lights."
	icon_state = "poster_goggles"

/obj/structure/sign/poster/official/safety_report
	name = "Safety: Report"
	desc = "A poster instructing the viewer to report suspicious activity to the security force."
	icon_state = "poster_warden"

/obj/structure/sign/poster/official/report_crimes
	name = "Report Crimes"
	desc = "A poster encouraging the swift reporting of crime or seditious behavior to security personnel."
	icon_state = "poster_report_crimes"

/obj/structure/sign/poster/official/ion_carbine
	name = "Ion Carbine"
	desc = "A poster advertising the SL L-791 Carbine."
	icon_state = "poster_l791"

/obj/structure/sign/poster/official/foam_force_ad
	name = "Foam Force Ad"
	desc = "Foam Force, it's Foam or be Foamed!"
	icon_state = "poster_foam_force"

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Cohiba Robusto Ad"
	desc = "Cohiba Robusto, the classy cigar straight from Centcom."
	icon_state = "poster_cohiba"

/obj/structure/sign/poster/official/fruit_bowl
	name = "Fruit Bowl"
	desc = " Simple, yet awe-inspiring."
	icon_state = "poster_fruitbowl"

/obj/structure/sign/poster/official/pda_ad
	name = "PDA Ad"
	desc = "A poster advertising the latest PDA from Nanotrasen suppliers."
	icon_state = "poster_pda"

/obj/structure/sign/poster/official/mini_energy_gun
	name = "Mini energy gun"
	desc = "A poster advertising the new and technically impressive SL X-26. 'Power in a pocket!'"
	icon_state = "poster_x26"

/obj/structure/sign/poster/official/enlist
	name = "Enlist" // but I thought deathsquad was never acknowledged
	// desc = "Enlist in the Nanotrasen Deathsquadron reserves today!" // I refuse to acknowledge this bullshit - Zeta
	desc = "A poster urging all across the NT umbrella to join the Nanotrasen Private Security forces. This was made specifically for the ICW, so someone probably forgot to take this down."
	icon_state = "poster_enlist"

/obj/structure/sign/poster/official/high_class_martini
	name = "High-Class Martini"
	desc = "I told you to shake it, no stirring."
	icon_state = "poster_martini"

/obj/structure/sign/poster/official/the_owl
	name = "The Owl"
	desc = "The Owl would do his best to protect the colonies. Will you?"
	icon_state = "poster_owl"

/obj/structure/sign/poster/official/no_erp
	name = "No ERP"
	desc = "This poster reminds viewers to immediately stop what they are doing right now. Yes, you. You know what you're doing."
	icon_state = "poster_noerp"
	never_random = TRUE //removes from the random  poster pool, effectively admin onlying it

/obj/structure/sign/poster/official/wtf_is_co2
	name = "Carbon Dioxide"
	desc = "This informational poster teaches the viewer what carbon dioxide is."
	icon_state = "poster_co2"

/obj/structure/sign/poster/official/focus
	name = "Focus! Motivational Poster"
	desc = "\"Focus! Let your energy be pinpointed!\""
	icon_state = "poster-focus"

/obj/structure/sign/poster/official/miners
	name = "Nanotrasen Mining-Exploratory Corps Recruitment"
	desc = "A poster recruiting more miners and explorers for new Nanotrasen holdings. It tells about how advanced Nanotrasen mining equipment and how it relates to the history of Nanotrasen."
	icon_state = "posters-minersneeded"

//Retro naontrasen posters. very inspired by the early apple logos and 70s-90s tech logos. Expect to see these on ancient Nanotrasen ships and stations, collectables, or callbacks to retro NT
/obj/structure/sign/poster/retro
	poster_item_name = "retro poster"
	poster_item_desc = "A really old Nanotrasen poster that probably sells for a lot now days. It comes with adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/retro/random
	name = "random retro poster"
	icon_state = "random_retro"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/retro
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/retro/nanotrasen_logo_70s
	name = "\improper Ancient Nanotrasen logo"
	desc = "A poster depicting the Nanotrasen logo. This thing is ancient."
	icon_state = "poster-nanotrasen70s_retro"

/obj/structure/sign/poster/retro/nanotrasen_logo_80s
	name = "\improper Nanotrasen logo"
	desc = "A poster depicting the Nanotrasen logo. It has a nice aesthetic."
	icon_state = "poster-nanotrasen_retro"

/obj/structure/sign/poster/retro/smile
	name = "Smile"
	desc = "Turn that frown upside down! It has a nice aesthetic."
	icon_state = "poster-smile_retro"

/obj/structure/sign/poster/retro/we_watch
	name = "We Watch"
	desc = "Big Brother is always watching. But instead of controlling you, he's trying to get you to stop loitering. It has a nice aesthetic."
	icon_state = "poster-watch_retro"

/obj/structure/sign/poster/retro/build
	name = "Build"
	desc = "A poster glorifying the engineering team. It has a nice aesthetic."
	icon_state = "poster-build_retro"

/obj/structure/sign/poster/retro/science
	name = "Science"
	desc = "A poster depicting an atom. It has a nice aesthetic."
	icon_state = "poster-science_retro"

/obj/structure/sign/poster/retro/pdaancient
	name = "PDA Ad"
	desc = "A poster advertising the original Thinkitronic PDA after the company was aquired by Nanotrasen. This thing shipped with severe problems such as PDA message 'bombing' and memory errors. Despite this, it's fondly remembered. This thing is ancient."
	icon_state = "poster-pda70_retro"

/obj/structure/sign/poster/retro/lasergun
	name = "Retro Laser Gun"
	desc = "A poster advertising the retro laser gun, back when it was new and called the L-104. This thing is ancient."
	icon_state = "poster-l102_retro"

/obj/structure/sign/poster/retro/lasergun_new
	name = "Old Laser Gun"
	desc = "A poster advertising an older version of the L-704, the L-204 model. It has a nice aesthetic."
	icon_state = "poster-newl204_retro"

/obj/structure/sign/poster/retro/radio
	name = "Radio"
	desc = "A poster advertising one of Nanotrasen's earliest products, a radio. One of its main selling points was a integrated OS and two way automatic translation for Solarian Common and Gezenan, which made it a smash hit. This thing is ancient."
	icon_state = "poster-radio70_retro"

//Safety moth posters, credit to AspEv for the art which the below posters are based on and to Ayy-Robotics for the sprites.

/obj/structure/sign/poster/official/moth
	name = "Safety Moth - Poisoning"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer not to poison important goods, and to be wary of suspect foods. It's signed by 'AspEv'."
	icon_state = "poster_moth_poisoning"

/obj/structure/sign/poster/official/moth/boh
	name = "Safety Moth - BoH"
	desc = "This informational poster uses Safety Moth(TM) to inform the viewer of the dangers of Bags of Holding. It's signed by 'AspEv'."
	icon_state = "poster_moth_boh"

/obj/structure/sign/poster/official/moth/hardhats
	name = "Safety Moth - Hardhats"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to wear hardhats in cautious areas. It's like a lamp for your head! It's signed by 'AspEv'."
	icon_state = "poster_moth_hardhats"

/obj/structure/sign/poster/official/moth/smokey
	name = "Safety Moth - Smokey?"
	desc = "This informational poster uses Safety Moth(TM) to promote safe handling of plasma, or promoting crew to combat plasmafires. We can't tell. It's signed by 'AspEv'."
	icon_state = "poster_moth_smokey"

/obj/structure/sign/poster/official/moth/piping
	name = "Safety Moth - Piping"
	desc = "This informational poster uses Safety Moth(TM) to tell atmospheric technicians correct types of piping to be used. Proper pipe placement prevents poor preformance! It's signed by 'AspEv'."
	icon_state = "poster_moth_piping"

/obj/structure/sign/poster/official/moth/supermatter
	name = "Safety Moth - Supermatter"
	desc = "This informational poster uses Safety Moth(TM) to promote proper safety equipment when working near a Supermatter Crystal. It's signed by 'AspEv'."
	icon_state = "poster_moth_supermatter"

/obj/structure/sign/poster/official/moth/meth
	name = "Safety Moth - Methamphetamine"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to seek CMO approval before cooking methamphetamine. You shouldn't even be making this. It's signed by 'AspEv'."
	icon_state = "poster_moth_meth"

/obj/structure/sign/poster/official/moth/epi
	name = "Safety Moth - Epinephrine"
	desc = "This informational poster uses Safety Moth(TM) to inform the viewer to help injured/deceased crewmen with their epinephrine injectors. It's signed by 'AspEv'."
	icon_state = "poster_moth_epi"

/obj/structure/sign/poster/official/moth/delam
	name = "Safety Moth - Delamination Safety Precautions"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to hide in lockers when the Supermatter Crystal has delaminated. Running away might be a better strategy. It's signed by 'AspEv'."
	icon_state = "poster_moth_delam"

/obj/structure/sign/poster/contraband/syndiemoth
	name = "Syndie Moth - Nuclear Operation"
	desc = "A Syndicate-commissioned poster that uses Syndie Moth(TM?) to tell the viewer to keep the nuclear authentication disk unsecured. It's signed by 'AspEv'."
	icon_state = "poster_moth_syndie"

/obj/structure/sign/poster/contraband/mothpill
	name = "Safety Pill - Methamphetamine"
	desc = "A decommisioned poster that uses Safety Pill(TM?) to promote less-than-legal chemicals. This is one of the reasons Nanotrasen stopped outsourcing their posters. It's partially signed by 'AspEv'."
	icon_state = "poster_moth_pill"

//SolGov poster pool. expect a focus on solarian based products and places. Expect these on solgov ships
/obj/structure/sign/poster/solgov
	poster_item_name = "solarian poster"
	poster_item_desc = "A solarian based poster, made with natural paper! It comes with adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/solgov/random
	name = "random solarian poster"
	icon_state = "random_solgov"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/solgov
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/solgov/solgov_logo
	name = "SolGov"
	desc = "The seal of The Most Serene Solar and Intersolar Confederation, or more boringly known as SolGov. \"The State is a sapling: Waters of change may drown it, and rays of fear may wither it, but well-tended it will one day bear fruit.\""
	icon_state = "poster-solgov"

/obj/structure/sign/poster/solgov/terra
	name = "Terra"
	desc = "Terra, or Earth as it's called by inhabitants, the third planet in the Sol system. Home to the only life as humans knew it, until contact with the outside universe. This poster in particular is trying to attract tourists to Terra, listing attractions like the Grand Orrery and Neue Waldstätte."
	icon_state = "poster-solgov-terra"

/obj/structure/sign/poster/solgov/mars
	name = "Mars"
	desc = "Mars, fourth planet in the Sol system. While evidence suggests that Venus and Mars may have once had life, Terra was the only one that kept it. This poster in particular is trying to attract tourists to Mars, listing attractions like skiing resorts and ancient robot exhibits."
	icon_state = "poster-solgov-mars"

/obj/structure/sign/poster/solgov/luna
	name = "Luna"
	desc = "Luna, the only moon of Terra. Culturally significant to the Solarians historically as a symbol of time, harvest, and new frontiers. This poster in particular is trying to attract tourists to Luna, listing attractions like the massive spaceport and white flags scattered across the surface, a relic from ages past."
	icon_state = "poster-solgov-luna"

/obj/structure/sign/poster/solgov/kepler
	name = "Kepler 453b"
	desc = "Kepler 453b, the only colonized planet in the Kepler 453 system. This poster in particular is trying to attract tourists to the planet, listing attractions like the salty desert and dual suns. \"Where your shadow always has company!\""
	icon_state = "poster-solgov-kepler"

/obj/structure/sign/poster/solgov/skiing
	name = "Lo-Fly Skiing Advert"
	desc = "An advertisement for some low-gravity skiing resort on Mars. \"Popular with SUNS groups!\""
	icon_state = "poster-solgov-loskiing"

/obj/structure/sign/poster/solgov/recyle
	name = "Recycle"
	desc = "A popular poster reminding the reader to recycle to keep the planet and ships clean!"
	icon_state = "poster-solgov-recycle"

/obj/structure/sign/poster/solgov/terragov
	name = "TerraGov"
	desc = "The coat of arms of TerraGov and the Terran Regency, which the latter still exists to this day."
	icon_state = "poster-terragov"

/obj/structure/sign/poster/solgov/paperwork
	name = "Paperwork"
	desc = "A poster reminding civil servants that it is their duty to keep detailed records."
	icon_state = "poster-solgov-paperwork"

/obj/structure/sign/poster/solgov/sonnensoldner
	name = "The Sonnensöldners"
	desc = "The symbol of the many Solar Companies."
	icon_state = "poster-solgov-sonnensoldner"

/obj/structure/sign/poster/solgov/alexandria
	name = "Archive of Alexandria"
	desc = "In the great desert \n\
	Lies a great library \n\
	Destroyed twice \n\
	Rebuilt twice \n\
	With the greatest works of all humankind."
	icon_state = "poster-solgov-alexandria"

/obj/structure/sign/poster/solgov/solgov_enlist //much better.
	name = "Enlist"
	desc = "Enlist to be a part of the SolGov Exploration Forces!"
	icon_state = "poster_solgov_enlist_legit"

/obj/structure/sign/poster/solgov/nanomichi_ad
	name = "Nanomichi Ad"
	desc = " A poster advertising a early post-NOF solarian computer. Severely outdated, but the advert is now a pretty nifty decoration."
	icon_state = "poster_nanomichi"

/obj/structure/sign/poster/solgov/suns
	name = "Student Union of Natural Sciences"
	desc = "SUNS, best known for it's diverse variety of top students from various solarian universities, dealing with internal fighting via dueling with swords, and being sued by Nanotrasen for trademark infrigement on their old name \"NSV.\""
	icon_state = "poster-solgov_suns"

//CLIP poster pool. This is quite limited, so don't use more than 3 random ones at once. Expect to see these on CLIP ships.

/obj/structure/sign/poster/clip
	poster_item_name = "clip poster"
	poster_item_desc = "A poster that is produced within CLIP. It comes with adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/clip/random
	name = "random clip poster"
	icon_state = "random_clip"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/clip
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/clip/enlist
	name = "Enlist"
	desc = "\"Do your part for not just CLIP, but Luna Town, Lanchester City, Serene, Star City, Ryunosuke, Lanshuka, Radinska, New Kalixcis, and all of your families! Plus, finance your future; It's a win/win to enlist in the CMM!\""
	icon_state = "poster-clip_enlist"

/obj/structure/sign/poster/clip/bard
	name = "CLIP-BARD"
	desc = "A poster made by soldiers to recruit people into CLIP-BARD, depecting a \"Sergeant Clues\" mowing down waves and waves of xenofauna, and them exploding into blood. Something tells you that service is a lot less interesting than this."
	icon_state = "poster-clip_bard"

/obj/structure/sign/poster/clip/gold
	name = "CLIP-GOLD"
	desc = "A poster listing job positions open in the CLIP-GOLD and asking for applications, listing important but uninteresting benifits like health insurance and such."
	icon_state = "poster-clip_gold"

/obj/structure/sign/poster/clip/lunatown
	name = "Luna-Town"
	desc = "Luna-town, one of the many moons of the gas giant Maxin. The capital of the Confederated League of Independent Planets. This poster is attempting to encounrage tourism with this poster by listing several tourist attractions, including the capital city itself and the remains of the UNSV Lichtenstein, famous for bringing CLIP from the brink into what it is today."
	icon_state = "poster-clip_luna"

/obj/structure/sign/poster/clip/maxin
	name = "Maxin"
	desc = "Maxin, the fourth planet of the Kanler-332 system. It's many moons including Lanchester City make it a popular sightseeing attraction for those enroute to Lanchester City."
	icon_state = "poster-clip_maxin"

/obj/structure/sign/poster/clip/lanchester
	name = "Lanchester City"
	desc = "Lanchester City, one of the many moons of the gas giant Maxin. A moon well known for it's numerous, massive factories. This poster is attempting to encounrage tourism with this poster by listing several tourist attractions, such as crashed Frontiersmen ships and the massive entertainment industry."
	icon_state = "poster-clip_lanchester"

/obj/structure/sign/poster/clip/serene
	name = "Serene"
	desc = "Serene, the fifth planet of the Druja system. Covered with a thick sheet of snow, the atmosphere has been described as \"Breathable, if it weren't so darn cold.\" This poster is attempting to encounrage tourism with this poster by listing several tourist attractions, such as old Frontiersmen War sites and Xenofauna war sites."
	icon_state = "poster-clip_serene"

// Syndicate posters. Since syndicate are dived lorewise, this would only make sense on pre-split ships.
/obj/structure/sign/poster/syndicate
	poster_item_name = "suspicious looking poster"
	poster_item_desc = "A poster with an ultra adhesive backing that's carefully designed to boost pinning ability. It comes with adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_syndicate"

/obj/structure/sign/poster/syndicate/random
	name = "random syndicate poster"
	icon_state = "random_syndicate"
	never_random = TRUE
	random_type = POSTER_LIST // what this does is only spawn the posters from the list
	random_pool = list(
	/obj/structure/sign/poster/contraband/syndicate,
	/obj/structure/sign/poster/contraband/stechkin,
	/obj/structure/sign/poster/contraband/c20r,
	/obj/structure/sign/poster/contraband/syndiemoth,
	/obj/structure/sign/poster/solgov/suns,
	/obj/structure/sign/poster/contraband/bulldog,
	/obj/structure/sign/poster/contraband/m90,
	/obj/structure/sign/poster/contraband/cybersun,
	/obj/structure/sign/poster/contraband/cybersun_borg,
	/obj/structure/sign/poster/contraband/cybersun_med,
	/obj/structure/sign/poster/contraband/aclf,
	/obj/structure/sign/poster/contraband/engis_unite,
	/obj/structure/sign/poster/contraband/gec,
	/obj/structure/sign/poster/contraband/d_day_promo,
		)

//RILENA poster pool. There are only five of these, so try not to go overboard with the random posters, okay? Expect not to see these mapped onto ships except in rolled up form, since they're supposed to be bought in the RILENA merch crate.

/obj/structure/sign/poster/rilena
	poster_item_name = "rilena poster"
	poster_item_desc = "A poster with a vibrant purple backing, indicating it is for the popular webseries RILENA: LMR. It comes with adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_rilena"

/obj/structure/sign/poster/rilena/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	AddComponent(/datum/component/art/rilena, GOOD_ART)

/obj/structure/sign/poster/rilena/random
	name = "random rilena poster"
	icon_state = "random_rilena"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/rilena
	random_type = POSTER_SUBTYPES

/obj/structure/sign/poster/rilena/rilena
	name = "RILENA"
	desc = "A RILENA: LMR poster featuring two of the more fan favorite characters, Ri and T4L1."
	icon_state = "poster-rilena_rilena"

/obj/structure/sign/poster/rilena/ri
	name = "Ri"
	desc = "A RILENA: LMR poster featuring Ri on her own."
	icon_state = "poster-rilena_ri"

/obj/structure/sign/poster/rilena/tali
	name = "T4L1"
	desc = "A RILENA: LMR poster featuring a fan favorite miniboss, T4L1."
	icon_state = "poster-rilena_tali"

/obj/structure/sign/poster/rilena/run
	name = "Lenelasa Me Refi"
	desc = "A RILENA: LMR poster featuring Ri running, a core mechanic of the series."
	icon_state = "poster-rilena_run"

/obj/structure/sign/poster/rilena/timeline
	name = "Timeline"
	desc = "A RILENA: LMR poster split in two to represent the series' disregard for conventional timeline aspects."
	icon_state = "poster-rilena_timeline"

//PGF Mission Accomplished
/obj/structure/sign/poster/pgf/mission_accomplished_1
	name = "MISSION ACCOMPLISHED! 1"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-1"
	never_random = TRUE

/obj/item/poster/mission_accomplished_1
	name = "Mission Accomplished Poster 1"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_1
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_2
	name = "MISSION ACCOMPLISHED! 2"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-2"
	never_random = TRUE

/obj/item/poster/mission_accomplished_2
	name = "Mission Accomplished Poster 2"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_2
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_3
	name = "MISSION ACCOMPLISHED! 3"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-3"
	never_random = TRUE

/obj/item/poster/mission_accomplished_3
	name = "Mission Accomplished Poster 3"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_3
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_4
	name = "MISSION ACCOMPLISHED! 4"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-4"
	never_random = TRUE

/obj/item/poster/mission_accomplished_4
	name = "Mission Accomplished Poster 4"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_4
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_5
	name = "MISSION ACCOMPLISHED! 5"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-5"
	never_random = TRUE

/obj/item/poster/mission_accomplished_5
	name = "Mission Accomplished Poster 5"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_5
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_6
	name = "MISSION ACCOMPLISHED! 6"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-6"
	never_random = TRUE

/obj/item/poster/mission_accomplished_6
	name = "Mission Accomplished Poster 6"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_6
	icon_state = "rolled_poster"

/obj/structure/sign/poster/pgf/mission_accomplished_7
	name = "MISSION ACCOMPLISHED! 7"
	desc = "MISSION ACCOMPLISHED SOLDIER!"
	icon_state = "poster-mission_accomplished-7"
	never_random = TRUE

/obj/item/poster/mission_accomplished_7
	name = "Mission Accomplished Poster 7"
	poster_type = /obj/structure/sign/poster/pgf/mission_accomplished_7
	icon_state = "rolled_poster"


#undef PLACE_SPEED
#undef POSTER_SUBTYPES
#undef POSTER_LIST
#undef POSTER_ADD_FROM_LIST
