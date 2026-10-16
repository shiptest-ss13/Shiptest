// What human mobs say in a fight, for /datum/component/ai_callouts. The base set any human might say first, then each faction's, which build on it

/datum/ai_callout_set/noncombatant
	lines = list(
		AI_CALLOUT_MELEE = list("Get away from me!", "Back off!", "Leave me alone!"),
		AI_CALLOUT_HURT = list("Help!", "Stop! Please!"),
		AI_CALLOUT_DEATH_RATTLE = list("I didn't... even...", "Why..."),
	)
	chances = list(
		AI_CALLOUT_MELEE = 50, // they're not ones for fighting, so it's worth a word when they do
	)

// Base callout lines for humans. If extending this, missing ones will fall back to these.
/datum/ai_callout_set/human
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact!", "We've got company!", "Intruders!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!"),
		AI_CALLOUT_TARGET_DOWN = list("They're down!", "Got one!", "I think I got 'em!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "That's one less.", "They're dead."),
		AI_CALLOUT_ALLY_DOWN = list("Ally down!", "They got one of ours!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost sight of them!"),
		AI_CALLOUT_FLANKING = list("Going around!", "Flanking!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Stay in cover!"),
		AI_CALLOUT_SUPPRESSING = list("Suppressing fire!", "Keeping them pinned!"),
		AI_CALLOUT_DEATH_RATTLE = list("Not... like this...", "Tell the crew... I...", "Damn... it..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me, reloading!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired, I'll check it out!", "Did you hear that?", "Gunfire! Moving to check it."),
		AI_CALLOUT_PUSHING = list("Moving up!", "Pushing in!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, backing off!"),
		AI_CALLOUT_WARY = list("Stay down, they're good!", "Careful, keep your heads down!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them!", "Press the attack!"),
		AI_CALLOUT_TAUNT = list("Come on, then!", "Nowhere to run!"),
		AI_CALLOUT_MELEE = list("Take this!", "Hold still!", "Come here!", "Hah!"),
		AI_CALLOUT_BAD_AIR = list("We're venting! Get out of here!", "Can't stay here, move!", "Find some air!"),
		AI_CALLOUT_TOO_HOT = list("It's burning up in here!", "Too hot, get out!", "Out of the heat, move!"),
		AI_CALLOUT_TOO_COLD = list("It's freezing, get inside!", "Too cold out here, move!", "Can't feel my fingers, get somewhere warm!"),
		AI_CALLOUT_BROKEN = list("Fall back! Fall back!", "We can't hold them!", "There's too many of them!", "Pull back, pull back!"),
		AI_CALLOUT_RALLIED = list("Okay... okay. Regroup!", "Pull it together, we're not done yet!", "Form up, we hold here!"),
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
		AI_CALLOUT_SPOTTED = list("We got company!", "Hostiles! Get 'em!", "Somebody's poking around!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!"),
		AI_CALLOUT_TARGET_DOWN = list("Got one!", "They're down!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "Check 'em for anything good later.", "Shouldn't have got in the way."),
		AI_CALLOUT_ALLY_DOWN = list("They got one of ours!", "Crew down!", "They'll pay for that!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost 'em!"),
		AI_CALLOUT_FLANKING = list("I'll get behind 'em!", "Going around!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Dig in!"),
		AI_CALLOUT_SUPPRESSING = list("Keep 'em pinned!", "Keep their heads down!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the crew... I..." = 3, "Wasn't... worth the cut..." = 3, "Should've... stayed a salvager..." = 3, "Free... Frontier..." = 1),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired! Go check it!", "You hear that? Someone's here."),
		AI_CALLOUT_PUSHING = list("Rush 'em!", "Move up!"),
		AI_CALLOUT_FALLING_BACK = list("Fall back!", "Back up, back up!"),
		AI_CALLOUT_WARY = list("Careful, they got teeth!", "Keep your head down, nobody else is dying today!"),
		AI_CALLOUT_EMBOLDENED = list("They're running! After 'em!", "We got 'em now!"),
		AI_CALLOUT_TAUNT = list("Wrong place, wrong time!" = 3, "Nothing personal, you're just in the way!" = 3, "Nowhere to run!" = 3, "Keep the Frontier free!" = 1),
		AI_CALLOUT_MELEE = list("Should've run!", "Down you go!", "That's for the crew!"),
		AI_CALLOUT_BROKEN = list("Pull back! Grab the wounded!", "We can't hold 'em! Get the crew out!", "Fall back, nobody gets left behind!"),
		AI_CALLOUT_RALLIED = list("Alright, crew, form up!", "Everyone here? Good. Let's go again."),
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
		AI_CALLOUT_SPOTTED = list("Strangers!", "Outsiders! Get them!", "Someone's here!"),
		AI_CALLOUT_TAKING_FIRE = list("They're shooting at us!", "Get down! Get down!"),
		AI_CALLOUT_HURT = list("Grah!", "It hurts!", "Argh!"),
		AI_CALLOUT_TARGET_DOWN = list("Got one!", "They're down!"),
		AI_CALLOUT_TARGET_KILLED = list("Strip them. Waste nothing.", "Should've stayed away.", "One less mouth out here."),
		AI_CALLOUT_ALLY_DOWN = list("They got one of us!", "No! Not them too!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?!", "They're hiding! Find them!"),
		AI_CALLOUT_FLANKING = list("Going around!", "Cut them off!"),
		AI_CALLOUT_HOLDING = list("Stay low!", "Hold here!"),
		AI_CALLOUT_SUPPRESSING = list("Keep shooting!", "Pin them down!"),
		AI_CALLOUT_DEATH_RATTLE = list("Finally... quiet...", "Should've... left... this rock...", "No...."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Need a second!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Gunfire! Someone's out there!", "Hear that? Go look!"),
		AI_CALLOUT_PUSHING = list("Drive them out!", "Get them!"),
		AI_CALLOUT_FALLING_BACK = list("Back! Get back!", "Too close!"),
		AI_CALLOUT_WARY = list("Careful... they're dangerous.", "Keep your heads down!"),
		AI_CALLOUT_EMBOLDENED = list("They're weak! Drive them off!", "This is our home!"),
		AI_CALLOUT_TAUNT = list("This is our land!" = 3, "You won't take anything from us!" = 3, "Get off our rock!" = 3, "HAHAHAHA!" = 1),
		AI_CALLOUT_MELEE = list("Get out! Get out!", "Off our land!", "HAHAHA!"),
		AI_CALLOUT_BROKEN = list("Scatter! Scatter!", "Run! Hide!", "We can't stop them!"),
		AI_CALLOUT_RALLIED = list("Come back! Hold together!", "We stand together or we die out here!"),
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
		AI_CALLOUT_SPOTTED = list("Fresh meat!", "Someone's come to die!", "Intruders! Gut them!"),
		AI_CALLOUT_TAKING_FIRE = list("Who's shooting?!", "Find that shooter!"),
		AI_CALLOUT_HURT = list("Is that all you've got?!", "You'll pay for that!", "Argh!"),
		AI_CALLOUT_TARGET_DOWN = list("They're on the floor!", "One down!", "Weak."),
		AI_CALLOUT_TARGET_KILLED = list("Too weak to keep breathing.", "Strip them later.", "That's what you get."),
		AI_CALLOUT_ALLY_DOWN = list("One less share to split.", "Should've been faster.", "They were weak anyway."),
		AI_CALLOUT_LOST_THEM = list("Where'd the coward go?!", "Running won't save you!"),
		AI_CALLOUT_FLANKING = list("I'll take them from the side!", "Going around!"),
		AI_CALLOUT_HOLDING = list("Let them come to us!", "Stay put!"),
		AI_CALLOUT_SUPPRESSING = list("Light them up!", "Keep their heads down!"),
		AI_CALLOUT_DEATH_RATTLE = list("Nobody's... taking me alive...", "Heh... at least... I died free...", "Should've... been stronger..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me! Or don't, see if I care!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Gunfire! Someone wants to die!", "Shots! Go see who's poking around!"),
		AI_CALLOUT_PUSHING = list("Push in! Kill them!", "Moving up!"),
		AI_CALLOUT_FALLING_BACK = list("Back off!", "Too close!"),
		AI_CALLOUT_WARY = list("Watch it, this one bites!", "Stay down, they're no pushover!"),
		AI_CALLOUT_EMBOLDENED = list("They're breaking! Finish them!", "They're weak! Push!"),
		AI_CALLOUT_TAUNT = list("Nobody's coming to save you!", "If you can't keep it, it isn't yours!", "Come on, then!", "FUCK YOU!!"),
		AI_CALLOUT_MELEE = list("Bleed for me!", "I'll gut you!", "Squeal!", "Stay down, meat!"),
		AI_CALLOUT_BROKEN = list("Screw this, I'm out!", "Every one for themselves!", "I'm not dying for a share!", "Run! They're too strong!"),
		AI_CALLOUT_RALLIED = list("Fine! Let's finish this!", "Get back here, cowards! We're not done!"),
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

// VI Security: guards, mall cops and armored delivery. By the book, mostly, and not paid enough for this
/datum/ai_callout_set/human/vigilitas
	lines = list(
		AI_CALLOUT_SPOTTED = list("Halt! Vigilitas Security!", "Unauthorized personnel on site!", "This is a restricted area!"),
		AI_CALLOUT_TAKING_FIRE = list("Shots fired! Shots fired!", "Taking fire, requesting backup!"),
		AI_CALLOUT_HURT = list("I'm hit!", "Agh! That's coming out of my hazard pay!"),
		AI_CALLOUT_TARGET_DOWN = list("Suspect down!", "Suspect is down, keep them covered!"),
		AI_CALLOUT_TARGET_KILLED = list("Hostile neutralized.", "Threat eliminated. I'll file the report."),
		AI_CALLOUT_ALLY_DOWN = list("Man down!", "We've got one down!"),
		AI_CALLOUT_LOST_THEM = list("Lost visual on the suspect!", "Where'd they go?"),
		AI_CALLOUT_FLANKING = list("Moving to cut them off!", "Going around, keep them busy!"),
		AI_CALLOUT_HOLDING = list("Hold the line!", "Stay in cover, wait for backup!"),
		AI_CALLOUT_SUPPRESSING = list("Covering fire!", "Keep them pinned!"),
		AI_CALLOUT_DEATH_RATTLE = list("They don't... pay me enough for this...", "Should've stayed... on the desk...", "Tell the client... I..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Changing mags!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired nearby, moving to investigate!", "Did you hear that? Checking it out."),
		AI_CALLOUT_PUSHING = list("Moving in!", "Advancing on the suspect!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, give me room!"),
		AI_CALLOUT_WARY = list("We lost one, nobody be a hero!", "Stay behind cover, they're dangerous!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them, close in!", "They're outnumbered, move in!"),
		AI_CALLOUT_TAUNT = list("Drop your weapon!", "This is private property!", "Stop resisting!"),
		AI_CALLOUT_MELEE = list("Stop resisting!", "Down! Get down!", "Hands where I can see them!"),
		AI_CALLOUT_BROKEN = list("This isn't worth it! Fall back!", "We're outgunned! Pull back!", "Retreat! Wait for backup!", "Forget this, let's get out of here!"),
		AI_CALLOUT_RALLIED = list("Okay, okay... regroup, by the book!", "Pull it together, hold the line!"),
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

// VI Crisis Reaction Units: a tactical response team, part SWAT and part well-armed firefighters
/datum/ai_callout_set/human/vigilitas/crisis
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact! Hostile in sight!", "Crisis Reaction, show me your hands!", "Hostile on site, engaging!"),
		AI_CALLOUT_TARGET_DOWN = list("Hostile down, keep them covered!", "One down, stay sharp!"),
		AI_CALLOUT_TARGET_KILLED = list("Threat neutralized.", "Hostile neutralized, moving on."),
		AI_CALLOUT_ALLY_DOWN = list("Responder down!", "We've got a casualty!"),
		AI_CALLOUT_FLANKING = list("Flanking, cover me!", "Taking the side!"),
		AI_CALLOUT_HOLDING = list("Hold position!", "Stack up and hold!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the... others...", "Mark... my position...", "Not... how this drill went..."),
		AI_CALLOUT_PUSHING = list("Breaching! Move, move!", "Pushing up!"),
		AI_CALLOUT_TAUNT = list("Weapons down, now!", "You're not leaving this site!", "Get on the ground!"),
		AI_CALLOUT_BROKEN = list("Abort! Abort! Fall back!", "Too many hostiles, pull out!", "Fall back to the rally point!"),
		AI_CALLOUT_RALLIED = list("Regroup and reset!", "Rally up, we go again!"),
	)

// VI Intervention Services: paramilitary, well-paid professionals for clients with exacting needs and substantial opposition
/datum/ai_callout_set/human/vigilitas/intervention
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact.", "Hostile in sector. Engaging.", "Target acquired."),
		AI_CALLOUT_TAKING_FIRE = list("Under fire. Locating shooter.", "Incoming."),
		AI_CALLOUT_HURT = list("Hit. Still in it.", "Armor's holding."),
		AI_CALLOUT_TARGET_DOWN = list("Target down.", "Hostile incapacitated."),
		AI_CALLOUT_TARGET_KILLED = list("Liability removed.", "Target eliminated.", "That's billable."),
		AI_CALLOUT_ALLY_DOWN = list("Operator down.", "We've lost one. Adjust."),
		AI_CALLOUT_LOST_THEM = list("Lost line of sight.", "Target's broken contact."),
		AI_CALLOUT_FLANKING = list("Repositioning.", "Moving to their flank."),
		AI_CALLOUT_HOLDING = list("Holding.", "Hold and observe."),
		AI_CALLOUT_SUPPRESSING = list("Suppressing.", "Fire on their position."),
		AI_CALLOUT_DEATH_RATTLE = list("Contract's... not done...", "Mission... compromised...", "Worth... every credit..."),
		AI_CALLOUT_RELOADING = list("Reloading.", "Mag change."),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots nearby. Investigating.", "Gunfire. Moving to check."),
		AI_CALLOUT_PUSHING = list("Advancing.", "Closing in."),
		AI_CALLOUT_FALLING_BACK = list("Making distance.", "Backing off."),
		AI_CALLOUT_WARY = list("They're competent. Tighten up.", "Slow down. They've got teeth."),
		AI_CALLOUT_EMBOLDENED = list("They're folding. Finish it.", "Press them."),
		AI_CALLOUT_TAUNT = list("Nothing personal.", "You're not on the contract.", "You should have stayed home."),
		AI_CALLOUT_MELEE = list("Close quarters.", "Engaging hand to hand."),
	)
	morale_lines = list(
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("This won't take long.", "Clean this up."),
		),
	)
