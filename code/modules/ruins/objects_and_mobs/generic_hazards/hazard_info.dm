/////////////
//MAP GUIDE//
/////////////
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
look at hazard/electrical for starters, its got a wide array of examples
make a new file for this new thing

do_random_effect() occurs randomly, with random_min to random_max between

TODO Finish later!

TODO (GET RID OF THIS BEFORE THE PR GETS MERGED OR SO HELP ME -helmcrab 21 july 2024)
X-Spike pits! :) done
X-low hanging debris? have to crawl or walk through done
X-icon stuff done
X-electrified area, used to make water scary done
X-fusebox for turning off hazards. Also could be a hazard :) done
X-chem smoke types //needs testing. done
X-make floor hazards rely less on components. Not customizable enough. Floor hazards are just going to be like that I think. done
X-grav tiles! needs to move objects as well because itll look good and tell players 'hey this is fucked up' even more done
X-burst pipes that emit gas? could just be More Smoke (smoke sucks ass) atmos easy peasy. done.
x-MORE SMOKE TYPES!!! YEAH!!! (smoke really needs to be uh, differentiable I think(not my problem for now) (could wait for cl hcl to do goggles check) chem smoke good enough. done
-falling debris? not sure how to represent this ingame.
X-acid pits
-biological hazards (foam is a good start)
-electrical makes light (probably pretty easy. I dont feel like it.)
X-remove caltrop component and write something based on it. caltrop is janky for this use. done
-let floor hazards have seperate warnings and damage texts
-better guide on how to make these hazards, maybe on the wiki?

" HC
maybe something roughly like the medipen ruin vault
where if you supply (or fail to supply) something with power, for enough time, it toggles the state
"

IDEAS - GOING TO NEED A SPRITER OR MAKE BAD SPRITES MYSELF
sparking wallmount (fusebox, old APC, conduit)
X power conduits, broken/frayed/decorative (stun version, spark on step, random spark)
X wire tangle w/ stun
broken machines
tesla something or other
broken SMES/generator tesla

*/
