/////////////
//MAP GUIDE//
/////////////
// a guide of how to add subtypes of existing hazards, such as electrical/thing or atmospherics/plasma

/*
Hi there, mapper. this isn't as hard as it looks! follow these steps, and feel free to ask for help!

1. Go to _examples.dm in the hazards folder
2. Look through the examples, and find one that fits what you want, or could be tweaked into what you need.
3. spawn the example in ingame using the admin tab, going to Game, then selecting Game Panel > create object and search "structure/hazard"
4. make a new [thing].dm file in the hazards folder
5. subtype the hazard you want based on an example!

example:

thing.dm

/obj/structure/hazard/electrical/thing
	name = "new thing for my cool map"
	desc = "cool description"
	icon_state = "hazard" //get a sprite!

	random_sparks = TRUE
	random_min = 20 SECONDS
	random_max = 30 SECONDS

6. Save and spawn it ingame!
7. Add cool new thing to your map and watch as people get very frustrated about it.

again, feel free to ask for help! this is made to be (hopefully) easy enough for adventurous mappers to use.


///////////////////////////////
//NEW HAZARD/THING TYPE GUIDE//
///////////////////////////////
An explanation of the code needed to make new hazard types, such as the base type electrical and atmospheric.

look at hazard/electrical for starters, its got a wide array of examples
make a new file for this new thing

do_random_effect() repeats with a cooldown set randomly between random_min and random_max, if do_random_effect = TRUE

contact() is sent when the hazard is entered or bumped, based on density. Ensure enter_activated is set if the hazard uses contact()

requires_client_nearby and client_range are used for optimization purposes and for player reactive traps.
If set, only mobs with clients within client_range will enable the hazard.

the disabled var is used to track if the hazard has been disabled.
disabled hazards cannot be renabled as the code intentionally stops calling itself.
can_be_disabled determines if the hazard can be disabled
time_to_disable only applies if the hazard can be disabled AND if the hazard uses this time for it's disable state.
generally, requiring another do_after with double the time of time_to_disable to remove (delete) the hazard is standard.
disable_text is added to the examine text if can_be_disabled is true. needs to be set!

the on var and id var are used with hazard shutoffs
if a hazard is off, contact and random effects aren't sent.
ids should only be set on maps, and are used to link shutoffs and hazards. Yes this is global, no I don't know how to do it better while keeping it simple.

slowdown is used on all hazards to add slowdown to the turf the hazard is on. higher slowdown leads to slower players
*/
