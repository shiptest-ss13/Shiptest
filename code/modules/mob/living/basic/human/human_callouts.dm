// What human mobs say in a fight, for /datum/component/ai_callouts. The base set any human might say, and noncombatants'. Each faction's own set builds on the base one, in that faction's folder under factions/

/datum/ai_callout_set/noncombatant
	lines = list(
		AI_CALLOUT_IDLE = list("Just a few more hours...", "I should've taken that other job.", "Did anyone else hear that?", "I hate this place.", "Is it break time yet?"),
		AI_CALLOUT_MELEE = list("Get away from me!", "Back off!", "Leave me alone!", "Don't touch me!", "Somebody help!"),
		AI_CALLOUT_HURT = list("Help!", "Stop! Please!", "Please, no!", "I'm not armed!"),
		AI_CALLOUT_DEATH_RATTLE = list("I didn't... even...", "Why...", "I just... worked here...", "Tell them... I tried..."),
		AI_CALLOUT_GRENADE = list("Bomb!", "It's gonna blow!", "Run!", "Get away from it!"),
		AI_CALLOUT_KNOCKED_DOWN = list("Ow! Please, stop!", "Don't hurt me!", "I'm down, I'm down!", "Okay! Okay!"),
		AI_CALLOUT_FLASHED = list("I can't see!", "What was that?!", "My eyes!", "Help, I can't see!"),
		AI_CALLOUT_GASSED = list("It burns!", "I can't breathe!", "Help! Gas!", "My eyes!"),
	)
	chances = list(
		AI_CALLOUT_MELEE = 50, // they're not ones for fighting, so it's worth a word when they do
	)

// Base callout lines for humans. If extending this, missing ones will fall back to these.
/datum/ai_callout_set/human
	lines = list(
		AI_CALLOUT_IDLE = list("Quiet out here.", "Anyone got a light?", "My feet are killing me.", "How long's this shift, again?", "Could really use a coffee.", "Keep your eyes open." ,"Wonder what chow is today...", "Fun times.. mhm.."),
		AI_CALLOUT_SPOTTED = list("Contact!", "We've got company!", "Intruders!", "Hostile spotted!", "Eyes up, we've got one!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!", "Incoming!", "We're under fire!"),
		AI_CALLOUT_GRENADE = list("Grenade!", "Get clear!", "Explosive!", "Move, move!", "It's gonna blow!"),
		AI_CALLOUT_THROW_BACK = list("Sending it back!", "Return to sender!", "Catch!", "Throwing it back!"),
		AI_CALLOUT_GRENADE_OUT = list("Frag out!", "Grenade out!", "Fire in the hole!", "Grenade, heads down!"),
		AI_CALLOUT_TARGETS_STUNNED = list("They're down, move in!", "Got them stunned, go!", "They're down! Push, push!"),
		AI_CALLOUT_SUSPICIOUS = list("...Did that box just move?", "Huh?", "Was that box there before?", "What was that?", "...Hello?"),
		AI_CALLOUT_LOST_INTEREST = list("Must've been my imagination.", "Just a box.", "Huh. Nothing.", "I need more sleep."),
		AI_CALLOUT_FOUND_HIDING = list("There's someone in the box!", "Got you! In the box!", "I knew it! Out!", "The box! Get them!"),
		AI_CALLOUT_COMMANDER_DOWN = list("The boss is down!", "They got the boss!", "Who's in charge now?!", "We lost the boss!"),
		AI_CALLOUT_PROTECT_COMMANDER = list("They're going for the boss!", "Protect the boss!", "Cover the boss!", "Get whoever's on the boss!"),
		AI_CALLOUT_ORDER_HOLD = list("Hold position!", "Hold here, don't push!", "Stay put, let them come to us!", "Nobody move up!"),
		AI_CALLOUT_ORDER_RETREAT = list("Fall back! Fall back!", "Pull back, now!", "Regroup, move!", "Back, everyone back!"),
		AI_CALLOUT_ORDER_PUSH = list("Push up!", "Move in, now!", "Forward! Get on them!", "Don't just sit there, push!", "Advance!"),
		AI_CALLOUT_CHARGE = list("Now! Get them!", "Charge!", "All together, go!", "Rush them!", "Go, go, go!"),
		AI_CALLOUT_ENEMY_RELOADING = list("They're reloading!", "They're dry! Go!", "Reloading, push them!", "Now, while they reload!", "They're empty!"),
		AI_CALLOUT_SHOOTING_THROUGH_ALLY = list("Sorry! No other way!", "Forgive me!", "Hold still, I'm taking the shot!", "I'm not waiting any longer!"),
		AI_CALLOUT_KNOCKED_DOWN = list("I'm down!", "Agh, I'm down!", "Knocked me flat!", "Cover me, I'm down!", "Help me up!"),
		AI_CALLOUT_FLASHED = list("I can't see!", "My eyes!", "Flash! I'm blind!", "Everything's white!", "Can't see a thing!"),
		AI_CALLOUT_GASSED = list("Gas! Gas!", "My eyes are burning!", "Can't breathe!", "Get out of the gas!", "Tear gas!"),
		AI_CALLOUT_STAGGERED = list("That all you've got?", "Still standing!", "Not going down!", "Barely felt that!"),
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
		// saying why we're not doing the obvious thing, so it reads as a choice
		AI_CALLOUT_NO_COVER = list("Nowhere to go!", "I'm pinned out here!", "No cover, I'm stuck!", "There's nowhere to hide!"),
		AI_CALLOUT_LAST_STANDING = list("I need backup here!", "Anyone still up? Anyone?", "It's just me! Send help!", "I'm on my own here!", "Need reinforcements, now!"),
		AI_CALLOUT_CANT_REACH = list("Can't get to them!", "No way through!", "They're out of reach!", "How'd they get over there?"),
		AI_CALLOUT_ALL_CLEAR = list("That's the last of them.", "Area's clear.", "All clear. Check the bodies.", "Looks like that's all of them.", "Clear. Stay sharp anyway."),
		AI_CALLOUT_GOT_AWAY = list("They're gone. Stay sharp.", "Lost them. Keep your eyes open.", "They got away.", "Gone. They'll be back."),
		AI_CALLOUT_GETTING_UP = list("They're getting back up!", "Still moving! Put them down!", "They're up again!", "Not dead yet, watch it!"),
		AI_CALLOUT_ON_FIRE = list("I'm on fire!", "I'm burning! Get it off!", "Fire! Put me out!", "It burns!"),
		AI_CALLOUT_PUTTING_OUT = list("Hold still, I've got you!", "Stop moving, I'll put it out!", "Get down, I've got it!"),
		AI_CALLOUT_SPREADING_FIRE = list("Burn with me!", "If I burn, you burn!", "Come here!", "We go together!"),
		AI_CALLOUT_RAISING_ALARM = list("On me, we've got company!", "Wake up, they're here!", "Hostiles inbound, get up!", "They're coming, grab your gear!"),
		AI_CALLOUT_BREACHING = list("Breaking through!", "Glass won't save you!", "Coming through, one way or another!", "I'll make a way in!"),
		// answers, said by an ally a moment after a line. CHECK_IN is an ally asking whoever just got hurt, who answers with STATUS_OK or STATUS_BAD.
		// LAST_SEEN and NO_SIGN answer LOST_THEM, and LAST_SEEN lines need %DIRECTION in them, which is lowercase so be careful where you use it
		AI_CALLOUT_CHECK_IN = list("You hit?", "You good?", "You alright?", "Still with me?", "Talk to me, you okay?"),
		AI_CALLOUT_STATUS_OK = list("I'm fine!", "Just a scratch!", "I'm good, keep shooting!", "Still in it!"),
		AI_CALLOUT_STATUS_BAD = list("I'm hit bad!", "Not good, I'm bleeding!", "I need a medic!", "I won't last long!"),
		AI_CALLOUT_LAST_SEEN = list("Last saw them heading %DIRECTION!", "Try %DIRECTION!", "They went %DIRECTION!", "Check %DIRECTION!"),
		AI_CALLOUT_NO_SIGN = list("Didn't see where they went.", "No sign of them.", "Negative.", "Haven't seen a thing."),
		AI_CALLOUT_COVERING = list("Covering!", "Got you covered!", "Go, I've got you!", "Covering, make it quick!"),
	)
	// lines for when the mob is alone
	solo_lines = list(
		AI_CALLOUT_SPOTTED = list("Someone's here!", "Who's there?!", "Got you!", "Hey! You!"),
		AI_CALLOUT_TAKING_FIRE = list("Who's shooting at me?!", "Where's that coming from?!", "Damn, they're shooting at me!"),
		AI_CALLOUT_GRENADE = list("Grenade!", "Explosive!", "It's gonna blow!"),
		AI_CALLOUT_KNOCKED_DOWN = list("Agh, I'm down!", "Knocked me flat!", "Get up, get up...!"),
		AI_CALLOUT_LOST_THEM = list("Where'd you go?", "I know you're out there!", "Come out where I can see you!", "Hiding won't help you!"),
		AI_CALLOUT_FLANKING = list("Let's see you hide from this side.", "Going around...", "Coming at you from the side!"),
		AI_CALLOUT_HOLDING = list("Come on... show yourself.", "I can wait.", "Waiting for you...", "Stay put. Let them come."),
		AI_CALLOUT_SUPPRESSING = list("Keep your head down!", "Stay down!", "Don't you dare peek!"),
		AI_CALLOUT_RELOADING = list("Reloading...", "Come on, come on...", "Out! Reloading!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Who's there?", "Did I hear something?", "Gunfire... better check it out.", "Someone's out there."),
		AI_CALLOUT_PUSHING = list("I'm coming for you!", "Nowhere to run!", "Here I come!"),
		AI_CALLOUT_WARY = list("Careful... careful.", "Keep your head down...", "Don't be stupid..."),
		AI_CALLOUT_BROKEN = list("I'm getting out of here!", "Not dying here!", "Forget this!", "Run, run!"),
		AI_CALLOUT_RALLIED = list("Okay... okay. I can do this.", "Pull it together...", "Steady... steady."),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_RAISING_ALARM = list("They're right behind me!", "Help! They're coming!"),
			AI_CALLOUT_HURT = list("I'm hit! Get me out of here!", "Help me!"),
			AI_CALLOUT_RELOADING = list("I'm out, I'm out!", "I need more bullets!"),
			AI_CALLOUT_ALLY_DOWN = list("They're dropping like flies!", "Another one down! Go, go!"),
			AI_CALLOUT_MELEE = list("Get away from me!", "Back off!", "Don't touch me!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_RELOADING = list("Reloading, keep me covered!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "You're all going down!"),
			AI_CALLOUT_RELOADING = list("Reloading, keep pushing!"),
		),
	)
