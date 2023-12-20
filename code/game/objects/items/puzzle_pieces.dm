//**************
//*****Keys*******************
//**************		**  **
/obj/item/keycard
	name = "security keycard"
	desc = "This feels like it belongs to a door."
	icon = 'icons/obj/puzzle_small.dmi'
	icon_state = "keycard"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 7
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	var/puzzle_id = null

//Two test keys for use alongside the two test doors.
/obj/item/keycard/cheese
	name = "cheese keycard"
	desc = "Look, I still don't understand the reference. What the heck is a keyzza?"
	color = "#f0da12"
	puzzle_id = "cheese"

/obj/item/keycard/swordfish
	name = "titanic keycard"
	desc = "Smells like it was at the bottom of a harbor."
	color = "#3bbbdb"
	puzzle_id = "swordfish"

/obj/item/keycard/gatedrop
	icon_state = "golden_key"

/obj/item/keycard/gatedrop/drakelair
	name = "Drake's Key"
	desc = "A dull, golden key originally kept by a menacing ash drake."
	puzzle_id = "drakelairkey"

/obj/item/keycard/gatedrop/disciple
	name = "Altar Key"
	desc = "A key held dear by the late Disciple of The Priest. Only by shutting themselves in with their stone idol were they able to spare those they love most from their madness and obsession."
	puzzle_id = "disciplekey"

/obj/item/keycard/gatedrop/guard
	name = "Armory Key"
	desc = "A golden key entrusted to the Captain of the Holy Guard of The Priest. Entrusted by His Holiness to guard the greatest weapon in His arsenal"
	puzzle_id = "guardcap"

/obj/item/keycard/gatedrop/heathen
	name = "Heathen's Key"
	desc = "And thus the Heathen stole away with the key to the forbidden gates. Hiding with his sect of followers until death cometh."
	puzzle_id = "heathen"

/obj/item/keycard/gatedrop/gatekeeper
	name = "GateKeeper's Key"
	desc = "Only by slaying the keeper of the gates may one path through into the depths of The Priest's holiest sanctums."
	puzzle_id = "gatekeeper"

/obj/item/keycard/gatedrop/bishop
	name = "Key of the lost"
	desc = "A key held only by the warring Bishop, forever lost to the Golden City of old."
	puzzle_id = "bishopkey"

/obj/item/keycard/gatedrop/priest
	name = "The Priest's Key"
	desc = "A key belonging to a once peaceful scholar, brought to death and ruin through means of violence by savage outsider."
	puzzle_id = "priestkey"


//***************
//*****Doors*****
//***************

/obj/machinery/door/keycard
	name = "locked door"
	desc = "This door only opens when a keycard is swiped. It looks virtually indestructable."
	icon = 'icons/obj/doors/doorpuzzle.dmi'
	icon_state = "door_closed"
	explosion_block = 3
	heat_proof = TRUE
	max_integrity = 600
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	var/puzzle_id = null	//Make sure that the key has the same puzzle_id as the keycard door!

//Standard Expressions to make keycard doors basically un-cheeseable
/obj/machinery/door/keycard/Bumped(atom/movable/AM)
	return !density && ..()

/obj/machinery/door/keycard/emp_act(severity)
	return

/obj/machinery/door/keycard/ex_act(severity, target)
	return

/obj/machinery/door/keycard/try_to_activate_door(mob/user)
	add_fingerprint(user)
	if(operating)
		return

/obj/machinery/door/keycard/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I,/obj/item/keycard))
		var/obj/item/keycard/key = I
		if((!puzzle_id || puzzle_id == key.puzzle_id)  && density)
			to_chat(user, "<span class='notice'>The door rattles, and slides opens.</span>")
			open()
			return
		else if(puzzle_id != key.puzzle_id)
			to_chat(user, "<span class='notice'>[src] shakes. This must not be the right key.</span>")
			return
		else
			to_chat(user, "<span class='notice'>This door doesn't appear to close.</span>")
			return

//Test doors. Gives admins a few doors to use quickly should they so choose.
/obj/machinery/door/keycard/cheese
	name = "blue airlock"
	desc = "Smells like... pizza?"
	puzzle_id = "cheese"

/obj/machinery/door/keycard/swordfish
	name = "blue airlock"
	desc = "If nautical nonsense be something you wish."
	puzzle_id = "swordfish"

/obj/machinery/door/keycard/gates
	gender = PLURAL
	name = "locked gates"
	desc = "A gate made out of hard metal. Opens with a key."
	icon = 'icons/obj/doors/gates.dmi'
	icon_state = "closed"
	layer = BLASTDOOR_LAYER
	closingLayer = BLASTDOOR_LAYER
	var/open_sound = 'sound/machines/airlocks/gate.ogg'
	var/close_sound = 'sound/machines/airlocks/gate.ogg'
	glass = TRUE
	opacity = FALSE
	move_resist = MOVE_FORCE_OVERPOWERING

/obj/machinery/door/keycard/gates/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, open_sound, 30, FALSE)
		if("closing")
			flick("closing", src)
			playsound(src, close_sound, 30, FALSE)

/obj/machinery/door/keycard/gates/update_icon_state()
	if(density)
		icon_state = "closed"
		return ..()
	else
		icon_state = "open"
		return ..()

/obj/machinery/door/keycard/gates/drakelair
	puzzle_id = "drakelairkey"

/obj/machinery/door/keycard/gates/disciple
	name = "Tithe Gates"
	desc = "Gates protecting the ritual tithe collected by The Priest and his Disciples."
	puzzle_id = "disciplekey"

/obj/machinery/door/keycard/gates/guard
	name = "Armory Gates"
	desc = "Gates protecting the most versatile and dangerous of The Priest's armory."
	puzzle_id = "guardcap"

/obj/machinery/door/keycard/gates/heathen
	name = "Sect Gates"
	desc = "Gates guarding the forbidden treasures stolen away by the Heathen. Bloody in nature, and hidden from sight."
	puzzle_id = "heathen"

/obj/machinery/door/keycard/gates/gatekeeper
	name = "Sanctum Gates"
	desc = "The Gatekeeper holds the key, only through bloodshed can they be opened."
	puzzle_id = "gatekeeper"

/obj/machinery/door/keycard/gates/bishop
	name = "Lost Golden City Gates"
	desc = "He took their lives and locked their culture and heritage behind indestructible gates of virtue. The Bishop spread conversion through death and swallowed the key."
	puzzle_id = "bishopkey"

/obj/machinery/door/keycard/gates/priest
	name = "The Priest's Treasury"
	desc = "Gates holding The Priest's eternal hoarde. Drakeborn, incapable of avoiding the grand desire to collect and learn."
	puzzle_id = "priestkey"

//*************************
//***Box Pushing Puzzles***
//*************************
//We're working off a subtype of pressureplates, which should work just a BIT better now.
/obj/structure/holobox
	name = "holobox"
	desc = "A hard-light box, containing a secure decryption key."
	icon = 'icons/obj/puzzle_small.dmi'
	icon_state = "laserbox"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF

//Uses the pressure_plate settings for a pretty basic custom pattern that waits for a specific item to trigger. Easy enough to retool for mapping purposes or subtypes.
/obj/item/pressure_plate/hologrid
	name = "hologrid"
	desc = "A high power, electronic input port for a holobox, which can unlock the hologrid's storage compartment. Safe to stand on."
	icon = 'icons/obj/puzzle_small.dmi'
	icon_state = "lasergrid"
	anchored = TRUE
	trigger_mob = FALSE
	trigger_item = TRUE
	specific_item = /obj/structure/holobox
	removable_signaller = FALSE //Being a pressure plate subtype, this can also use signals.
	roundstart_signaller_freq = FREQ_HOLOGRID_SOLUTION //Frequency is kept on it's own default channel however.
	active = TRUE
	trigger_delay = 10
	protected = TRUE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	var/reward = /obj/item/reagent_containers/food/snacks/cookie
	var/claimed = FALSE

/obj/item/pressure_plate/hologrid/Initialize()
	. = ..()

	AddElement(/datum/element/undertile, tile_overlay = tile_overlay) //we remove use_anchor here, so it ALWAYS stays anchored

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/pressure_plate/hologrid/examine(mob/user)
	. = ..()
	if(claimed)
		. += "<span class='notice'>This one appears to be spent already.</span>"

/obj/item/pressure_plate/hologrid/trigger()
	if(!claimed)
		new reward(loc)
	flick("lasergrid_a",src)
	icon_state = "lasergrid_full"
	claimed = TRUE

/obj/item/pressure_plate/hologrid/on_entered(datum/source, atom/movable/AM)
	if(trigger_item && istype(AM, specific_item) && !claimed)
		AM.set_anchored(TRUE)
		flick("laserbox_burn", AM)
		trigger()
		QDEL_IN(AM, 15)
