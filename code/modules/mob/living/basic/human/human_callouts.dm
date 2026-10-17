// What human mobs say in a fight, for /datum/component/ai_callouts. The base set any human might say first, then each faction's, which build on it

/datum/ai_callout_set/noncombatant
	lines = list(
		AI_CALLOUT_MELEE = list("Get away from me!", "Back off!", "Leave me alone!", "Don't touch me!", "Somebody help!"),
		AI_CALLOUT_HURT = list("Help!", "Stop! Please!", "Please, no!", "I'm not armed!"),
		AI_CALLOUT_DEATH_RATTLE = list("I didn't... even...", "Why...", "I just... worked here...", "Tell them... I tried..."),
		AI_CALLOUT_GRENADE = list("Bomb!", "It's gonna blow!", "Run!", "Get away from it!"),
	)
	chances = list(
		AI_CALLOUT_MELEE = 50, // they're not ones for fighting, so it's worth a word when they do
	)

// Base callout lines for humans. If extending this, missing ones will fall back to these.
/datum/ai_callout_set/human
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact!", "We've got company!", "Intruders!", "Hostile spotted!", "Eyes up, we've got one!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!", "Incoming!", "We're under fire!"),
		AI_CALLOUT_GRENADE = list("Grenade!", "Get clear!", "Explosive!", "Move, move!", "It's gonna blow!"),
		AI_CALLOUT_THROW_BACK = list("Sending it back!", "Return to sender!", "Catch!", "Throwing it back!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!", "Damn it!", "I'm bleeding!"),
		AI_CALLOUT_TARGET_DOWN = list("They're down!", "Got one!", "I think I got 'em!", "Down they go!", "Target's on the ground!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "That's one less.", "They're dead.", "That one's done.", "Not getting back up."),
		AI_CALLOUT_ALLY_DOWN = list("Ally down!", "They got one of ours!", "Man down!", "We lost one!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost sight of them!", "Anyone got eyes on them?", "They slipped away!"),
		AI_CALLOUT_FLANKING = list("Going around!", "Flanking!", "I'll take the side!", "Circling around!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Stay in cover!", "Keep your position!", "Nobody move up yet!"),
		AI_CALLOUT_SUPPRESSING = list("Suppressing fire!", "Keeping them pinned!", "Covering fire!", "Keep shooting, don't let them peek!"),
		AI_CALLOUT_DEATH_RATTLE = list("Not... like this...", "Tell the crew... I...", "Damn... it...", "Can't... see...", "Just... a scratch..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me, reloading!", "Changing mags!", "Out! Reloading!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired, I'll check it out!", "Did you hear that?", "Gunfire! Moving to check it.", "Someone's shooting nearby!", "That was close. Stay sharp."),
		AI_CALLOUT_PUSHING = list("Moving up!", "Pushing in!", "Move, move!", "Close the distance!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, backing off!", "Give me some room!", "Backing up!"),
		AI_CALLOUT_WARY = list("Stay down, they're good!", "Careful, keep your heads down!", "Nobody be a hero!", "Slow down, we just lost one!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them!", "Press the attack!", "They're breaking!", "Keep it up, we're winning!"),
		AI_CALLOUT_TAUNT = list("Come on, then!", "Nowhere to run!", "That all you've got?", "Give it up!"),
		AI_CALLOUT_MELEE = list("Take this!", "Hold still!", "Come here!", "Hah!", "Out of my way!", "Gotcha!"),
		AI_CALLOUT_BAD_AIR = list("We're venting! Get out of here!", "Can't stay here, move!", "Find some air!", "Air's going bad, move!", "I can't breathe in here!"),
		AI_CALLOUT_TOO_HOT = list("It's burning up in here!", "Too hot, get out!", "Out of the heat, move!", "This place is cooking!", "Get clear of the heat!"),
		AI_CALLOUT_TOO_COLD = list("It's freezing, get inside!", "Too cold out here, move!", "Can't feel my fingers, get somewhere warm!", "My hands are going numb!", "We'll freeze out here, move!"),
		AI_CALLOUT_BROKEN = list("Fall back! Fall back!", "We can't hold them!", "There's too many of them!", "Pull back, pull back!", "Run for it!", "Get out, get out!"),
		AI_CALLOUT_RALLIED = list("Okay... okay. Regroup!", "Pull it together, we're not done yet!", "Form up, we hold here!", "Back on your feet!", "Steady... we can still do this!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! Get me out of here!", "Help me!"),
			AI_CALLOUT_RELOADING = list("I'm out, I'm out!"),
			AI_CALLOUT_ALLY_DOWN = list("They're dropping like flies!", "Another one down! Go, go!"),
			AI_CALLOUT_MELEE = list("Get away from me!", "Back off!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_RELOADING = list("Reloading, keep me covered!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "You're all going down!"),
			AI_CALLOUT_RELOADING = list("Reloading, keep pushing!"),
		),
	)

/datum/ai_callout_set/human/frontier
	lines = list(
		AI_CALLOUT_SPOTTED = list("We got company!", "Hostiles! Get 'em!", "Somebody's poking around!", "Eyes up, crew! Visitors!", "Somebody wandered in!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!", "They're shooting! Get down!", "Incoming, crew!"),
		AI_CALLOUT_GRENADE = list("Grenade! Scatter, crew!", "Bomb! Get clear!", "Move it, it's live!", "Nade! Off the line!"),
		AI_CALLOUT_THROW_BACK = list("Sending it back, crew!", "Here, have it back!", "Not on my watch!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!", "Ah, that one stung!", "Damn it, I'm bleeding!"),
		AI_CALLOUT_TARGET_DOWN = list("Got one!", "They're down!", "Dropped 'em!", "One down! Keep at it!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "Check 'em for anything good later.", "Shouldn't have got in the way.", "Nobody's paying for that one.", "Should've kept walking."),
		AI_CALLOUT_ALLY_DOWN = list("They got one of ours!", "Crewman down!", "They'll pay for that!", "Someone's down!", "We'll make this right!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost 'em!", "Anybody got eyes?", "They ducked out!"),
		AI_CALLOUT_FLANKING = list("I'll get behind 'em!", "Going around!", "Swinging wide!", "Get round their side!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Dig in!", "Hold, crew! Let 'em come!", "Keep your heads in cover!"),
		AI_CALLOUT_SUPPRESSING = list("Keep 'em pinned!", "Keep their heads down!", "Pour it on!", "Don't let 'em peek!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the crew... I..." = 3, "Wasn't... worth the cut..." = 3, "Should've... stayed a salvager..." = 3, "Free... Frontier..." = 1, "Not... like this..." = 3, "No..." = 3),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me!", "Out! Need a second!", "Swapping mags!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired! Go check it!", "You hear that? Someone's here.", "Someone's shooting! Crew, with me!", "That's not one of ours. Go look."),
		AI_CALLOUT_PUSHING = list("Rush 'em!", "Move up!", "Close in!", "Crew, push!"),
		AI_CALLOUT_FALLING_BACK = list("Fall back!", "Back up, back up!", "Get back, crew!", "Give 'em room!"),
		AI_CALLOUT_WARY = list("Careful, they got teeth!", "Keep your head down, nobody else is dying today!", "Slow it down, we lost one already!", "Stay in cover, crew!"),
		AI_CALLOUT_EMBOLDENED = list("They're running! After 'em!", "We got 'em now!", "Keep it up, crew!", "They're folding!"),
		AI_CALLOUT_TAUNT = list("Wrong place, wrong time!" = 3, "Nothing personal, you're just in the way!" = 3, "Nowhere to run!" = 3, "Keep the Frontier free!" = 1, "Should've picked another rock!" = 3, "The Frontier is ours!" = 3),
		AI_CALLOUT_MELEE = list("Should've run!", "Down you go!", "That's for the crew!", "Nothing personal!", "Out of the way!"),
		AI_CALLOUT_BROKEN = list("Pull back!!", "We can't hold 'em! Get out!", "Fall back!", "Run!", "We're done here! Move!"),
		AI_CALLOUT_RALLIED = list("Alright, crew, form up!", "Everyone here? Good. Let's go again.", "Crew's together, we go again!", "Let's go, we're not done!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! Don't leave me!", "Somebody drag me out!"),
			AI_CALLOUT_RELOADING = list("I'm out! Somebody cover me!"),
			AI_CALLOUT_ALLY_DOWN = list("We're losing people! Go, go!", "Get 'em out of there, we're leaving!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "Should've stayed home!"),
		),
	)

/datum/ai_callout_set/human/hermit
	lines = list(
		AI_CALLOUT_SPOTTED = list("Strangers!", "Outsiders! Get them!", "Someone's here!", "Who's there?!", "They've come for our things!"),
		AI_CALLOUT_TAKING_FIRE = list("They're shooting at us!", "Get down! Get down!", "Bullets! Hide!", "They're attacking!"),
		AI_CALLOUT_GRENADE = list("Fire-rock! Run!", "It's gonna blow! Away!", "Bomb! Scatter!", "Get away from it!"),
		AI_CALLOUT_THROW_BACK = list("Take it back!", "Not ours! Yours!", "Back to you!"),
		AI_CALLOUT_HURT = list("Grah!", "It hurts!", "Argh!", "Gah! It burns!", "Not again...!"),
		AI_CALLOUT_TARGET_DOWN = list("Got one!", "They're down!", "Down in the dirt!", "They fell!"),
		AI_CALLOUT_TARGET_KILLED = list("Strip them. Waste nothing.", "Should've stayed away.", "One less mouth out here.", "Nothing goes to waste.", "The wastes can have them."),
		AI_CALLOUT_ALLY_DOWN = list("They got one of us!", "No! Not them too!", "They hurt one of ours!", "Not another one!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?!", "They're hiding! Find them!", "They're out here somewhere!", "Gone! Look everywhere!"),
		AI_CALLOUT_FLANKING = list("Going around!", "Cut them off!", "Around the back!", "Surround them!"),
		AI_CALLOUT_HOLDING = list("Stay low!", "Hold here!", "Stay hidden!", "Let them come to us!"),
		AI_CALLOUT_SUPPRESSING = list("Keep shooting!", "Pin them down!", "Shoot! Keep shooting!", "Don't let them move!"),
		AI_CALLOUT_DEATH_RATTLE = list("Finally... quiet...", "Should've... left... this rock...", "No....", "Back... to the dirt...", "Home..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Need a second!", "Hold on, hold on!", "Bullets, where are my bullets?!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Gunfire! Someone's out there!", "Hear that? Go look!", "Noise! Out there!", "Someone's shooting near!"),
		AI_CALLOUT_PUSHING = list("Drive them out!", "Get them!", "Chase them out!", "Run them down!"),
		AI_CALLOUT_FALLING_BACK = list("Back! Get back!", "Too close!", "Away! Away!", "Back to camp!"),
		AI_CALLOUT_WARY = list("Careful... they're dangerous.", "Keep your heads down!", "Stay hidden, they're strong!", "Don't let them see you!"),
		AI_CALLOUT_EMBOLDENED = list("They're weak! Drive them off!", "This is our home!", "They're running! Chase them!", "Our ground! Ours!"),
		AI_CALLOUT_TAUNT = list("This is our land!" = 3, "You won't take anything from us!" = 3, "Get off our rock!" = 3, "HAHAHAHA!" = 1, "Nothing here for you!" = 3, "Leave! Leave now!" = 3),
		AI_CALLOUT_MELEE = list("Get out! Get out!", "Off our land!", "HAHAHA!", "Mine! Mine!", "Go away!"),
		AI_CALLOUT_BROKEN = list("Scatter! Scatter!", "Run! Hide!", "We can't stop them!", "Let's get outta here!", "Hide! Everyone hide!"),
		AI_CALLOUT_RALLIED = list("Come back! Hold together!", "We stand together or we die out here!", "Alright, let's go!", "Together! Stay together!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("Don't leave me out here!", "Help me!"),
			AI_CALLOUT_ALLY_DOWN = list("They're killing us all!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "Nobody takes what's ours!"),
		),
	)

/datum/ai_callout_set/human/ramzi
	lines = list(
		AI_CALLOUT_SPOTTED = list("Fresh meat!", "Someone's come to die!", "Intruders! Gut them!", "Visitors! Let's give 'em a welcome!", "Look what wandered in!"),
		AI_CALLOUT_TAKING_FIRE = list("Who's shooting?!", "Find that shooter!", "Someone's got a death wish!", "They're shooting at us! Return fire!"),
		AI_CALLOUT_GRENADE = list("Frag out, scatter!", "Grenade, break left, break right!", "Live one! Clear the blast!", "Explosive! Move!"),
		AI_CALLOUT_THROW_BACK = list("Return to sender!", "Your toy, take it back!", "Back at you!"),
		AI_CALLOUT_HURT = list("Is that all you've got?!", "You'll pay for that!", "Argh!", "That just made me angry!", "Lucky shot!"),
		AI_CALLOUT_TARGET_DOWN = list("They're on the floor!", "One down!", "Weak.", "Down you go!", "Look at 'em crawl!"),
		AI_CALLOUT_TARGET_KILLED = list("Too weak to keep breathing.", "Strip them later.", "That's what you get.", "Pathetic.", "Dibs on their gear."),
		AI_CALLOUT_ALLY_DOWN = list("One less share to split.", "Should've been faster.", "They were weak anyway.", "Bigger cut for me.", "Idiot got themselves killed."),
		AI_CALLOUT_LOST_THEM = list("Where'd the coward go?!", "Running won't save you!", "Come out, come out!", "Hiding won't help!"),
		AI_CALLOUT_FLANKING = list("I'll take them from the side!", "Going around!", "I'll come at them sideways!", "Circling round, keep 'em busy!"),
		AI_CALLOUT_HOLDING = list("Let them come to us!", "Stay put!", "Make them come to us!", "Sit tight and let them bleed!"),
		AI_CALLOUT_SUPPRESSING = list("Light them up!", "Keep their heads down!", "Shred them!", "Don't let them breathe!"),
		AI_CALLOUT_DEATH_RATTLE = list("Nobody's... taking me alive...", "Heh... at least... I died free...", "Should've... been stronger...", "Worth... it...", "Damn... you..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me! Or don't, see if I care!", "Reloading! Don't die before I'm back!", "Out! Somebody shoot something!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Gunfire! Someone wants to die!", "Shots! Go see who's poking around!", "Hear that? Fresh meat!", "Someone's making noise. Go shut them up."),
		AI_CALLOUT_PUSHING = list("Push in! Kill them!", "Moving up!", "Get in there!", "Charge! Take them!"),
		AI_CALLOUT_FALLING_BACK = list("Back off!", "Too close!", "Get off me!", "Give me room to work!"),
		AI_CALLOUT_WARY = list("Watch it, this one bites!", "Stay down, they're no pushover!", "Careful, this one's not soft!", "Don't get greedy, stay down!"),
		AI_CALLOUT_EMBOLDENED = list("They're breaking! Finish them!", "They're weak! Push!", "Run them down!", "They're done! Take everything!"),
		AI_CALLOUT_TAUNT = list("Nobody's coming to save you!", "If you can't keep it, it isn't yours!", "Come on, then!", "FUCK YOU!!", "The strong take, the weak bleed!", "Scream for me!"),
		AI_CALLOUT_MELEE = list("Bleed for me!", "I'll gut you!", "Squeal!", "Stay down, meat!", "Hold still, meat!", "This'll hurt!"),
		AI_CALLOUT_BROKEN = list("Screw this, I'm out!", "Every one for themselves!", "I'm not dying for a share!", "Run! They're too strong!", "Not worth the cut! Run!", "Save your own skin!"),
		AI_CALLOUT_RALLIED = list("Fine! Let's finish this!", "Get back here, cowards! We're not done!", "Get back in there!", "Quit running, we're not done!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("Get me out of here!", "Somebody help me, damn it!"),
			AI_CALLOUT_RELOADING = list("I'm empty! Cover me, damn it!"),
			AI_CALLOUT_ALLY_DOWN = list("Another one gone! Run!", "They're butchering us!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "The strong take everything!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_TAUNT = list("Come out and fight, coward!"),
		),
	)

	// the Supercollider, stimmed up and half feral, in it for the hurting
/datum/ai_callout_set/human/ramzi/supercollider
	lines = list(
		AI_CALLOUT_SPOTTED = list("There you are!", "I see you...", "Mine! That one's mine!", "Come here! Come HERE!", "Oh, you'll do nicely!"),
		AI_CALLOUT_TAUNT = list("Run! I like it when they run!", "Hold still!", "I can hear your heart going!", "Nowhere left to hide!", "I'm going to break every bone you've got!"),
		AI_CALLOUT_MELEE = list("CRACK!", "Again! AGAIN!", "Break!", "Hah!", "Scream for me!"),
		AI_CALLOUT_HURT = list("More! Give me more!", "That tickles!", "Hah! Is that it?!", "I don't feel a thing!", "Yes! YES!"),
		AI_CALLOUT_TARGET_DOWN = list("Get up! I'm not done!", "Down you go!", "Crawl! Go on, crawl!", "Not yet, not yet..."),
		AI_CALLOUT_TARGET_KILLED = list("Too quick...", "Next!", "Broke that one.", "Who's next?!", "Aw, it stopped moving."),
		AI_CALLOUT_ALLY_DOWN = list("Weak!", "More for me!", "Should've been faster!", "Their loss!"),
		AI_CALLOUT_LOST_THEM = list("Come out, come out!", "I'll find you!", "I can smell you!", "Hiding won't save you!"),
		AI_CALLOUT_PUSHING = list("Here I come!", "Coming for you!", "Out of my way!", "RAAAAH!", "MOTHERFUCCCKKKEERR!!!"),
		AI_CALLOUT_GRENADE = list("Ooh, a loud one!", "Fireworks!", "Hah, boom!"),
		AI_CALLOUT_DEATH_RATTLE = list("Not... done...", "More...", "Hah... hah...", "Worth it..."),
	)



// ---------- VI ----------
// VI Security: guards, mall cops and armored delivery. By the book, mostly, and not paid enough for this
/datum/ai_callout_set/human/vigilitas
	lines = list(
		AI_CALLOUT_SPOTTED = list("Halt! Vigilitas Security!", "Unauthorized personnel on site!", "This is a restricted area!", "Security! Stop right there!", "Trespasser on site!"),
		AI_CALLOUT_TAKING_FIRE = list("Shots fired! Shots fired!", "Taking fire, requesting backup!", "Under fire! Need support!", "They're armed! Taking fire!"),
		AI_CALLOUT_GRENADE = list("Grenade! Clear the area!", "Explosive device, fall back!", "Ordnance! Disperse!", "Take cover, live grenade!"),
		AI_CALLOUT_THROW_BACK = list("Returning the device!", "Throwing it back, cover!", "Sending it downrange!"),
		AI_CALLOUT_HURT = list("I'm hit!", "Agh! That's coming out of my hazard pay!", "Ow! This wasn't in the job posting!", "I'm hurt!"),
		AI_CALLOUT_TARGET_DOWN = list("Suspect down!", "Suspect is down, keep them covered!", "Suspect's down!", "Got them, stay back!"),
		AI_CALLOUT_TARGET_KILLED = list("Hostile neutralized.", "Threat eliminated. I'll file the report.", "Suspect neutralized.", "Call it in. Hostile down for good."),
		AI_CALLOUT_ALLY_DOWN = list("Man down!", "We've got one down!", "Officer down!", "Guard down, need assistance!"),
		AI_CALLOUT_LOST_THEM = list("Lost visual on the suspect!", "Where'd they go?", "Suspect's gone dark!", "Lost them, sweep the area!"),
		AI_CALLOUT_FLANKING = list("Moving to cut them off!", "Going around, keep them busy!", "Taking the side route!", "Going around to box them in!"),
		AI_CALLOUT_HOLDING = list("Hold the line!", "Stay in cover, wait for backup!", "Hold position!", "Keep them contained!"),
		AI_CALLOUT_SUPPRESSING = list("Covering fire!", "Keep them pinned!", "Laying down cover!", "Keep their heads down!"),
		AI_CALLOUT_DEATH_RATTLE = list("They don't... pay me enough for this...", "Should've stayed... on the desk...", "Tell the client... I...", "Should've... taken... the night shift...", "Report... this..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Changing mags!", "Reloading, cover me!", "Need a mag!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired nearby, moving to investigate!", "Did you hear that? Checking it out.", "Possible shots fired, checking it out!", "Got a disturbance, moving to respond!"),
		AI_CALLOUT_PUSHING = list("Moving in!", "Advancing on the suspect!", "Closing in on the suspect!", "Move in, stay together!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, give me room!", "Backing off!", "Give me distance!"),
		AI_CALLOUT_WARY = list("We lost one, nobody be a hero!", "Stay behind cover, they're dangerous!", "Don't get careless, we just lost one!", "Stay safe, wait for them to come out!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them, close in!", "They're outnumbered, move in!", "Suspect's cornered!", "Keep the pressure on!"),
		AI_CALLOUT_TAUNT = list("Drop your weapon!", "This is private property!", "Stop resisting!", "You're under arrest!", "Last warning!"),
		AI_CALLOUT_MELEE = list("Stop resisting!", "Down! Get down!", "Hands where I can see them!", "Get on the ground!", "Don't move!"),
		AI_CALLOUT_BROKEN = list("This isn't worth it! Fall back!", "We're outgunned! Pull back!", "Retreat! Wait for backup!", "Forget this, let's get out of here!", "Call it in, we're pulling out!", "I'm not paid enough for this!"),
		AI_CALLOUT_RALLIED = list("Okay, okay... regroup, by the book!", "Pull it together, hold the line!", "Alright, back to it!", "Regroup, keep them contained!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! I need a medic!", "Agh! Get me out of here!"),
			AI_CALLOUT_RELOADING = list("I'm dry! I'm dry!"),
			AI_CALLOUT_ALLY_DOWN = list("Another one down! Get out of here!", "We're losing people!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Surrender now and this goes easier!", "Give it up, you're done!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_TAUNT = list("Just drop it, nobody else needs to get hurt!"),
		),
	)

// VI Crisis Reaction Units: a tactical response team, part SWAT
/datum/ai_callout_set/human/vigilitas/crisis
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact! Hostile in sight!", "Crisis Reaction, show me your hands!", "Hostile on site, engaging!", "Visual on a hostile!", "Hostile contact, weapons free!"),
		AI_CALLOUT_TARGET_DOWN = list("Hostile down, keep them covered!", "One down, stay sharp!", "Hostile's down!", "Suspect down, secure them!"),
		AI_CALLOUT_TARGET_KILLED = list("Threat neutralized.", "Hostile neutralized, moving on.", "Hostile won't be getting up.", "Neutralized. Clear and continue."),
		AI_CALLOUT_ALLY_DOWN = list("Responder down!", "We've got a casualty!", "Need medical on that responder!", "Responder down, cover them!"),
		AI_CALLOUT_FLANKING = list("Flanking, cover me!", "Taking the side!", "Moving to their flank!", "Taking the alternate route!"),
		AI_CALLOUT_HOLDING = list("Hold position!", "Stack up and hold!", "Hold and cover!", "Stay on the line!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the... others...", "Mark... my position...", "Not... how this drill went...", "Keep... the line...", "Get... the others... out..."),
		AI_CALLOUT_PUSHING = list("Breaching! Move, move!", "Pushing up!", "Entry, entry!", "Advance and clear!"),
		AI_CALLOUT_TAUNT = list("Weapons down, now!", "You're not leaving this site!", "Get on the ground!", "Drop it! Drop it!", "Hands up, now!"),
		AI_CALLOUT_BROKEN = list("Abort! Abort! Fall back!", "Too many hostiles, pull out!", "Fall back! We're compromised!", "Pull out, regroup!", "Mission's blown, fall back!"),
		AI_CALLOUT_RALLIED = list("Regroup and reset!", "Rally up, we go again!", "Reset and push again!", "Back in formation!"),
	)

// VI Intervention Services: paramilitary, well-paid professionals for clients with exacting needs and substantial opposition
/datum/ai_callout_set/human/vigilitas/intervention
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact.", "Hostile in sector. Engaging.", "Target acquired.", "Visual.", "Hostile. Engaging."),
		AI_CALLOUT_TAKING_FIRE = list("Under fire. Locating shooter.", "Incoming.", "Taking fire.", "Contact, under fire."),
		AI_CALLOUT_GRENADE = list("Grenade. Clear.", "Explosive. Move.", "Ordnance, disperse."),
		AI_CALLOUT_THROW_BACK = list("Returning it.", "Handled.", "Sending it back."),
		AI_CALLOUT_HURT = list("Hit. Still in it.", "Armor's holding.", "Hit. Continuing.", "Minor wound."),
		AI_CALLOUT_TARGET_DOWN = list("Target down.", "Hostile incapacitated.", "Down.", "Target's on the floor."),
		AI_CALLOUT_TARGET_KILLED = list("Liability removed.", "Target eliminated.", "That's billable.", "Confirmed.", "Contract terms met."),
		AI_CALLOUT_ALLY_DOWN = list("Operator down.", "We've lost one. Adjust.", "Man down.", "Lost an operator."),
		AI_CALLOUT_LOST_THEM = list("Lost line of sight.", "Target's broken contact.", "No visual.", "Target's gone to ground."),
		AI_CALLOUT_FLANKING = list("Repositioning.", "Moving to their flank.", "Flanking.", "Taking an angle."),
		AI_CALLOUT_HOLDING = list("Holding.", "Hold and observe.", "Holding position.", "Watching the approach."),
		AI_CALLOUT_SUPPRESSING = list("Suppressing.", "Fire on their position.", "Fire on them.", "Keep them pinned."),
		AI_CALLOUT_DEATH_RATTLE = list("Contract's... not done...", "Mission... compromised...", "Worth... every credit...", "Not... on the... schedule...", "Finish... the job..."),
		AI_CALLOUT_RELOADING = list("Reloading.", "Mag change.", "Reloading. Cover.", "Changing."),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots nearby. Investigating.", "Gunfire. Moving to check.", "Shots. Moving.", "Gunfire off-sector. Checking."),
		AI_CALLOUT_PUSHING = list("Advancing.", "Closing in.", "Moving up.", "Pushing."),
		AI_CALLOUT_FALLING_BACK = list("Making distance.", "Backing off.", "Repositioning back.", "Opening distance."),
		AI_CALLOUT_WARY = list("They're competent. Tighten up.", "Slow down. They've got teeth.", "Careful. They're good.", "Don't rush it."),
		AI_CALLOUT_EMBOLDENED = list("They're folding. Finish it.", "Press them.", "They're done. Close it out.", "Finish the job."),
		AI_CALLOUT_TAUNT = list("Nothing personal.", "You're not on the contract.", "You should have stayed home.", "You were warned.", "Wrong job to walk into."),
		AI_CALLOUT_MELEE = list("Close quarters.", "Engaging hand to hand.", "Hands on.", "Close in."),
	)
	morale_lines = list(
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("This won't take long.", "Clean this up."),
		),
	)
