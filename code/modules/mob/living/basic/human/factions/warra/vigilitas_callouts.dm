// ---------- VI ----------
// VI Security: guards, mall cops and armored delivery. By the book, mostly, and not paid enough for this
/datum/ai_callout_set/human/vigilitas
	lines = list(
		AI_CALLOUT_IDLE = list(
			"All clear on my end.",
			"Keep it by the book.",
			"Shift's nearly over.",
			"Logging another quiet hour.",
			"Stay sharp, people.",
			"Check your corners.",
			"Watch your back.",
			"%Sometimes it gets so hard without you~",
		),
		AI_CALLOUT_SPOTTED = list(
			"Halt! Vigilitas Security!",
			"Unauthorized personnel on site!",
			"This is a restricted area!",
			"Security! Stop right there!",
			"Trespasser on site!",
			"Hands up! Now!"
		),
		AI_CALLOUT_TAKING_FIRE = list(
			"Shots fired! Shots fired!",
			"Taking fire, requesting backup!",
			"Under fire! Need support!",
			"They're armed! Taking fire!",
			"Suspects are shooting at us!"
		),
		AI_CALLOUT_GRENADE = list(
			"Grenade! Clear the area!",
			"Explosive device, fall back!",
			"Ordnance! Disperse!",
			"Take cover, live grenade!",
			"They brought grenades?!"
		),
		AI_CALLOUT_THROW_BACK = list(
			"Returning the device!",
			"Throwing it back, cover!",
			"Sending it downrange!"
		),
		AI_CALLOUT_GRENADE_OUT = list(
			"Deploying stingbang!",
			"Bang out!",
			"Less-lethal out, cover!",
			"Stingbang, heads down!"
		),
		AI_CALLOUT_TARGETS_STUNNED = list(
			"Suspect's down, move in!",
			"Suspects incapacitated, close in!",
			"They're stunned, go go go!",
			"Suspects are stunned, move it!"
		),
		AI_CALLOUT_SHOOTING_THROUGH_ALLY = list(
			"Hostage situation, taking the shot!",
			"Sorry! Engaging through!",
			"No clear shot, firing anyway!",
			"We got insurance for this! Firing!"
		),
		AI_CALLOUT_HURT = list(
			"I'm hit!",
			"Agh! That's coming out of my hazard pay!",
			"Ow! This wasn't in the job posting!",
			"I'm hurt!",
			"Is that my blood?!"
		),
		AI_CALLOUT_TARGET_DOWN = list(
			"Suspect down!",
			"Suspect is down, keep them covered!",
			"Suspect's down!",
			"Got them, stay back!",
			"%ADJ suspect is down!",
			"Downed the %SPECIES!"
		),
		AI_CALLOUT_TARGET_KILLED = list(
			"Hostile neutralized.",
			"Threat eliminated. I'll file the report.",
			"Suspect neutralized.",
			"Call it in. Hostile down for good."
		),
		AI_CALLOUT_HEADSHOT = list(
			"Headshot confirmed!",
			"Suspect hit, head!",
			"Head hit, suspect still active!",
			"Struck the suspect's head!"
		),
		AI_CALLOUT_HEADSHOT_DOWN = list(
			"Headshot, suspect down!",
			"Suspect down, head hit! Keep them covered!",
			"Head hit, suspect is down!",
			"Suspect down from a headshot!"
		),
		AI_CALLOUT_HEADSHOT_KILLED = list(
			"Headshot. Suspect neutralized.",
			"Fatal head hit. I'll file the report.",
			"Threat eliminated, head shot.",
			"Suspect neutralized, one to the head."
		),
		AI_CALLOUT_TARGET_DROPPED = list(
			"Suspect has collapsed!",
			"Suspect's collapsed, approach with caution!",
			"Hostile's down, keep them covered!",
			"Suspect is on the ground!"
		),
		AI_CALLOUT_TARGET_DIED = list(
			"Suspect is unresponsive. Mark it.",
			"No vitals on the suspect.",
			"Suspect's gone. Call it in.",
			"Hostile deceased. Logging it."
		),
		AI_CALLOUT_ALLY_DOWN = list(
			"Man down!",
			"We've got one down!",
			"Officer down!",
			"Guard down, need assistance!"
		),
		AI_CALLOUT_LOST_THEM = list(
			"Lost visual on the suspect!",
			"Where'd they go?",
			"Suspect's gone dark!",
			"Lost them, sweep the area!"
		),
		AI_CALLOUT_FLANKING = list(
			"Moving to cut them off!",
			"Going around, keep them busy!",
			"Taking the side route!",
			"Going around to box them in!"
		),
		AI_CALLOUT_HOLDING = list(
			"Hold the line!",
			"Stay in cover, wait for backup!",
			"Hold position!",
			"Keep them contained!"
		),
		AI_CALLOUT_SUPPRESSING = list(
			"Covering fire!",
			"Keep them pinned!",
			"Laying down cover!",
			"Keep their heads down!"
		),
		AI_CALLOUT_DEATH_RATTLE = list(
			"They don't... pay me enough for this...",
			"Should've stayed... on the desk...",
			"Tell the client... I...",
			"Should've... taken... the night shift...",
			"Report... this..."
		),
		AI_CALLOUT_RELOADING = list(
			"Reloading!",
			"Changing mags!",
			"Reloading, cover me!",
			"Need a mag!"
		),
		AI_CALLOUT_HEARD_GUNFIRE = list(
			"Shots fired nearby, moving to investigate!",
			"Did you hear that? Checking it out.",
			"Possible shots fired, checking it out!",
			"Got a disturbance, moving to respond!"
		),
		AI_CALLOUT_PUSHING = list(
			"Moving in!",
			"Advancing on the suspect!",
			"Closing in on the suspect!",
			"Move in, stay together!"
		),
		AI_CALLOUT_FALLING_BACK = list(
			"Falling back!",
			"Too close, give me room!",
			"Backing off!",
			"Give me distance!"
		),
		AI_CALLOUT_WARY = list(
			"We lost one, nobody be a hero!",
			"Stay behind cover, they're dangerous!",
			"Don't get careless, we just lost one!",
			"Stay safe, wait for them to come out!",
			"Eyes up, remember our training!"
		),
		AI_CALLOUT_EMBOLDENED = list(
			"We've got them, close in!",
			"They're outnumbered, move in!",
			"Suspect's cornered!",
			"Keep the pressure on!",
			"Lets move in and get them!"
		),
		AI_CALLOUT_TAUNT = list(
			"Drop your weapon!",
			"This is private property!",
			"Stop resisting!",
			"You're under arrest!",
			"Last warning!"
		),
		AI_CALLOUT_MELEE = list(
			"Stop resisting!",
			"Down! Get down!",
			"Hands where I can see them!",
			"Get on the ground!",
			"Don't move!"
		),
		AI_CALLOUT_BROKEN = list(
			"This isn't worth it! Fall back!",
			"We're outgunned! Pull back!",
			"Retreat! Wait for backup!",
			"Forget this, let's get out of here!",
			"Call it in, we're pulling out!",
			"I'm not paid enough for this!"
		),
		AI_CALLOUT_RALLIED = list(
			"Okay, okay... regroup, by the book!",
			"Pull it together, hold the line!",
			"Alright, back to it!",
			"Regroup, keep them contained!"
		),
		AI_CALLOUT_NO_COVER = list(
			"No cover, I'm exposed!",
			"Nowhere to go, I'm pinned!",
			"I'm in the open, need support!",
			"Pinned down, no cover!"
		),
		AI_CALLOUT_LAST_STANDING = list(
			"Requesting backup, I'm alone here!",
			"Anyone on this channel? Respond!",
			"I'm the last one, send backup!",
			"Need reinforcements, now!"
		),
		AI_CALLOUT_CANT_REACH = list(
			"Can't reach the suspect!",
			"No access to their position!",
			"Suspect's out of reach!",
			"I can't get to them from here!"
		),
		AI_CALLOUT_ALL_CLEAR = list(
			"Area secure.",
			"All hostiles neutralized. Area secure.",
			"Site's clear, I'll file the report.",
			"Clear. Back to patrol."
		),
		AI_CALLOUT_GOT_AWAY = list(
			"Suspect has fled the scene.",
			"Lost the suspect. Logging it.",
			"Suspect's gone, stay alert.",
			"They're gone. Somebody write this up."
		),
		AI_CALLOUT_GETTING_UP = list(
			"Suspect is back on their feet!",
			"Suspect's up, re-engage!",
			"They're getting up, watch it!",
			"Suspect's mobile again!"
		),
		AI_CALLOUT_RAISING_ALARM = list(
			"All units, hostile on site!",
			"Up, up! We've got a situation!",
			"Wake up, we've got a trespasser!",
			"Everyone up, intruder alert!"
		),
		AI_CALLOUT_BREACHING = list(
			"Breaching!",
			"Forcing entry!",
			"Suspect's barricaded, breaking through!",
			"Coming in, stand clear!"
		),
		AI_CALLOUT_CHECK_IN = list(
			"Status?",
			"You hit?",
			"You okay? Talk to me!",
			"Report, are you hurt?"
		),
		AI_CALLOUT_STATUS_OK = list(
			"I'm okay!",
			"Just a graze, still on duty!",
			"I'm good, stay on them!",
			"Fine! Keep going!"
		),
		AI_CALLOUT_STATUS_BAD = list(
			"I'm hit bad, need a medic!",
			"Not good, I need evac!",
			"I'm bleeding out here!",
			"Requesting medical, I'm hurt!",
			"I'm bleeding badly!"
		),
		AI_CALLOUT_LAST_SEEN = list(
			"Suspect last seen heading %DIRECTION!",
			"They went %DIRECTION!",
			"Check %DIRECTION!",
			"Last visual was %DIRECTION!"
		),
		AI_CALLOUT_NO_SIGN = list(
			"Negative, no visual.",
			"Didn't see where they went.",
			"Nothing on my end.",
			"No sign of the suspect."
		),
		AI_CALLOUT_COVERING = list(
			"Covering!",
			"Go, I've got you!",
			"Covering, move!",
			"I've got eyes on, go!",
			"Watching your back, move!"
		),
		AI_CALLOUT_ENEMY_RELOADING = list(
			"Suspect's reloading, move in!",
			"They're dry, close in now!",
			"Suspect's weapon is empty, go!",
			"They're reloading, take them down!"
		),
		AI_CALLOUT_CHARGE = list(
			"All units, move in!",
			"Go, go, go!",
			"Converge on the suspect!",
			"Move in, together!"
		),
		AI_CALLOUT_SUSPICIOUS = list(
			"...Did that box just move?",
			"Hold on. That box.",
			"Huh. Movement?",
			"Checking something out."
		),
		AI_CALLOUT_LOST_INTEREST = list(
			"False alarm. Just a box.",
			"Nothing. Logging it anyway.",
			"Area's clear, it's a box.",
			"I need a longer break.",
			"We gotta get an energy drink machine.."
		),
		AI_CALLOUT_FOUND_HIDING = list(
			"Suspect concealed in a container!",
			"Out of the box, hands up!",
			"Found the suspect, in the box!",
			"Got one hiding, move in!",
			"Suspect was trying the box trick!"
		),
		AI_CALLOUT_ORDER_PUSH = list(
			"All units, advance!",
			"Move up, keep them contained!",
			"Push in!",
			"Advance on the suspect!",
			"Move in on the suspects!"
		),
		AI_CALLOUT_ORDER_HOLD = list(
			"Hold position!",
			"Hold the line, wait for backup!",
			"Nobody advance!",
			"Stay in cover, hold!",
			"Don't move! It's too dangerous!"
		),
		AI_CALLOUT_ORDER_RETREAT = list(
			"All units, fall back!",
			"Pull back, we're outgunned!",
			"Fall back and regroup!",
			"Retreat, wait for backup!"
		),
		AI_CALLOUT_PROTECT_COMMANDER = list(
			"Supervisor under fire!",
			"Cover the supervisor!",
			"Engage whoever's on the supervisor!",
			"Protect the supervisor!"
		),
		AI_CALLOUT_COMMANDER_DOWN = list(
			"Supervisor down!",
			"We lost the supervisor!",
			"Who's in command now?!",
			"Supervisor's down, need direction!",
			"Supervisor's dead! Who's next in command?!"
		),
	)
	solo_lines = list(
		AI_CALLOUT_LOST_THEM = list(
			"Lost visual on the suspect.",
			"Come out, this is Vigilitas Security!",
			"I know you're in here!"
		),
		AI_CALLOUT_FLANKING = list(
			"Moving to cut them off.",
			"Going around.",
			"Taking the side route."
		),
		AI_CALLOUT_HOLDING = list(
			"Holding position. Come out with your hands up!",
			"I can wait for backup.",
			"Holding. Don't make this worse."
		),
		AI_CALLOUT_RELOADING = list(
			"Reloading.",
			"Changing mags.",
			"Reloading, stay where you are!"
		),
		AI_CALLOUT_PUSHING = list(
			"Moving in on the suspect!",
			"You're under arrest!",
			"Closing in!"
		),
		AI_CALLOUT_WARY = list(
			"Easy... by the book.",
			"Careful. Wait for backup."
		),
		AI_CALLOUT_BROKEN = list(
			"Not paid enough for this!",
			"I'm out, I'm out!",
			"Retreating, requesting backup!"
		),
		AI_CALLOUT_RALLIED = list(
			"Okay... by the book. By the book.",
			"Deep breaths. Back to it.",
			"Alright. Still on shift."
		),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_RAISING_ALARM = list(
				"Suspect's right behind me! Help!",
				"Requesting assistance, they're on me!"
			),
			AI_CALLOUT_HURT = list(
				"I'm hit! I need a medic!",
				"Agh! Get me out of here!"
			),
			AI_CALLOUT_RELOADING = list(
				"I'm dry! I'm dry!",
				"They didn't give us enough bullets for this!!"
			),
			AI_CALLOUT_ALLY_DOWN = list(
				"Another one down! Get out of here!",
				"We're losing people!"
			),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list(
				"Surrender now and this goes easier!",
				"Give it up, you're done!"
			),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_TAUNT = list(
				"Just drop it, nobody else needs to get hurt!",
				"Stop running from the law!"
			),
		),
	)

// VI Crisis Reaction Units: a tactical response team, part SWAT
/datum/ai_callout_set/human/vigilitas/crisis
	lines = list(
		AI_CALLOUT_SPOTTED = list(
			"Contact! Hostile in sight!",
			"Crisis Reaction, show me your hands!",
			"Hostile on site, engaging!",
			"Visual on a hostile!",
			"Hostile contact, weapons free!"
		),
		AI_CALLOUT_TARGET_DOWN = list(
			"Hostile down, keep them covered!",
			"One down, stay sharp!",
			"Hostile's down!",
			"Suspect down, secure them!"
		),
		AI_CALLOUT_TARGET_KILLED = list(
			"Threat neutralized.",
			"Hostile neutralized, moving on.",
			"Hostile won't be getting up.",
			"Neutralized. Clear and continue."
		),
		AI_CALLOUT_ALLY_DOWN = list(
			"Responder down!",
			"We've got a casualty!",
			"Need medical on that responder!",
			"Responder down, cover them!",
			"Crisis Reaction lost one!"
		),
		AI_CALLOUT_FLANKING = list(
			"Flanking, cover me!",
			"Taking the side!",
			"Moving to their flank!",
			"Taking the alternate route!",
			"Attempting pincer manuever!"
		),
		AI_CALLOUT_HOLDING = list(
			"Hold position!",
			"Stack up and hold!",
			"Hold and cover!",
			"Stay on the line!"
		),
		AI_CALLOUT_DEATH_RATTLE = list(
			"Tell the... others...",
			"Mark... my position...",
			"Not... how this drill went...",
			"Keep... the line...",
			"Get... the others... out..."
		),
		AI_CALLOUT_PUSHING = list(
			"Breaching! Move, move!",
			"Pushing up!",
			"Entry, entry!",
			"Advance and clear!"
		),
		AI_CALLOUT_TAUNT = list(
			"Weapons down, now!",
			"You're not leaving this site!",
			"Get on the ground!",
			"Drop it! Drop it!",
			"Hands up, now!"
		),
		AI_CALLOUT_BROKEN = list(
			"Abort! Abort! Fall back!",
			"Too many hostiles, pull out!",
			"Fall back! We're compromised!",
			"Pull out, regroup!",
			"Mission's blown, fall back!"
		),
		AI_CALLOUT_RALLIED = list(
			"Regroup and reset!",
			"Rally up, we go again!",
			"Reset and push again!",
			"Back in formation!",
			"Crisis Reaction reforming!"
		),
		AI_CALLOUT_ALL_CLEAR = list(
			"Site secure.",
			"All clear, reset.",
			"Area cleared, hold and reset."
		),
	)

// VI Intervention Services: paramilitary, well-paid professionals for clients with exacting needs and substantial opposition
/datum/ai_callout_set/human/vigilitas/intervention
	lines = list(
		AI_CALLOUT_SPOTTED = list(
			"Contact.",
			"Hostile in sector. Engaging.",
			"Target acquired.",
			"Visual.",
			"Hostile. Engaging."
		),
		AI_CALLOUT_TAKING_FIRE = list(
			"Under fire. Locating shooter.",
			"Incoming.",
			"Taking fire.",
			"Contact, under fire."
		),
		AI_CALLOUT_GRENADE = list(
			"Grenade. Clear.",
			"Explosive. Move.",
			"Ordnance, disperse."
		),
		AI_CALLOUT_THROW_BACK = list(
			"Returning it.",
			"Handled.",
			"Sending it back."
		),
		AI_CALLOUT_GRENADE_OUT = list(
			"Frag out.",
			"Grenade.",
			"Fire in the hole."
		),
		AI_CALLOUT_TARGETS_STUNNED = list(
			"Targets stunned. Moving.",
			"They're down. Close in.",
			"Stunned. Go."
		),
		AI_CALLOUT_SHOOTING_THROUGH_ALLY = list(
			"Acceptable risk.",
			"Taking the shot.",
			"Firing through."
		),
		AI_CALLOUT_HURT = list(
			"Hit. Still in it.",
			"Armor's holding.",
			"Hit. Continuing.",
			"Minor wound."
		),
		AI_CALLOUT_TARGET_DOWN = list(
			"Target down.",
			"Hostile incapacitated.",
			"Down.",
			"Target's on the floor."
		),
		AI_CALLOUT_TARGET_KILLED = list(
			"Liability removed.",
			"Target eliminated.",
			"That's billable.",
			"Confirmed.",
			"Contract terms met."
		),
		AI_CALLOUT_ALLY_DOWN = list(
			"Operator down.",
			"We've lost one. Adjust.",
			"Man down.",
			"Lost an operator."
		),
		AI_CALLOUT_LOST_THEM = list(
			"Lost line of sight.",
			"Target's broken contact.",
			"No visual.",
			"Target's gone to ground."
		),
		AI_CALLOUT_FLANKING = list(
			"Repositioning.",
			"Moving to their flank.",
			"Flanking.",
			"Taking an angle."
		),
		AI_CALLOUT_HOLDING = list(
			"Holding.",
			"Hold and observe.",
			"Holding position.",
			"Watching the approach."
		),
		AI_CALLOUT_SUPPRESSING = list(
			"Suppressing.",
			"Fire on their position.",
			"Fire on them.",
			"Keep them pinned."
		),
		AI_CALLOUT_DEATH_RATTLE = list(
			"Contract's... not done...",
			"Mission... compromised...",
			"Worth... every credit...",
			"Not... on the... schedule...",
			"Finish... the job..."
		),
		AI_CALLOUT_RELOADING = list(
			"Reloading.",
			"Mag change.",
			"Reloading. Cover.",
			"Changing."
		),
		AI_CALLOUT_HEARD_GUNFIRE = list(
			"Shots nearby. Investigating.",
			"Gunfire. Moving to check.",
			"Shots. Moving.",
			"Gunfire off-sector. Checking."
		),
		AI_CALLOUT_PUSHING = list(
			"Advancing.",
			"Closing in.",
			"Moving up.",
			"Pushing."
		),
		AI_CALLOUT_FALLING_BACK = list(
			"Making distance.",
			"Backing off.",
			"Repositioning back.",
			"Opening distance."
		),
		AI_CALLOUT_WARY = list(
			"They're competent. Tighten up.",
			"Slow down. They've got teeth.",
			"Careful. They're good.",
			"Don't rush it."
		),
		AI_CALLOUT_EMBOLDENED = list(
			"They're folding. Finish it.",
			"Press them.",
			"They're done. Close it out.",
			"Finish the job."
		),
		AI_CALLOUT_TAUNT = list(
			"Nothing personal.",
			"You're not on the contract.",
			"You should have stayed home.",
			"You were warned.",
			"Wrong job to walk into."
		),
		AI_CALLOUT_MELEE = list(
			"Close quarters.",
			"Engaging hand to hand.",
			"Hands on.",
			"Close in."
		),
		AI_CALLOUT_NO_COVER = list(
			"No cover. Exposed.",
			"Exposed.",
			"Nowhere to go. Holding."
		),
		AI_CALLOUT_LAST_STANDING = list(
			"Last operator standing. Requesting support.",
			"Team's gone. Need extraction.",
			"Alone. Send backup."
		),
		AI_CALLOUT_CANT_REACH = list(
			"No route to target.",
			"Target's out of reach.",
			"Can't reach. Holding."
		),
		AI_CALLOUT_ALL_CLEAR = list(
			"Clear.",
			"Area sanitized.",
			"Sector clear.",
			"Contract site secure."
		),
		AI_CALLOUT_GOT_AWAY = list(
			"Target broke contact.",
			"Target's gone.",
			"Lost them. Resume."
		),
		AI_CALLOUT_GETTING_UP = list(
			"Target's up.",
			"Not down. Re-engaging.",
			"Target's moving again."
		),
		AI_CALLOUT_RAISING_ALARM = list(
			"Contact. On me.",
			"Hostiles. Get up.",
			"Wake up. We have company."
		),
		AI_CALLOUT_BREACHING = list(
			"Breaching.",
			"Making entry.",
			"Forcing a way through."
		),
		AI_CALLOUT_CHECK_IN = list(
			"Status.",
			"You hit?",
			"Condition?",
			"Talk to me."
		),
		AI_CALLOUT_STATUS_OK = list(
			"Operational.",
			"Minor. Continuing.",
			"Still in it.",
			"Fine."
		),
		AI_CALLOUT_STATUS_BAD = list(
			"Badly hit.",
			"Need medical.",
			"Combat ineffective soon.",
			"Bleeding out.",
			"Get me a stim."
		),
		AI_CALLOUT_LAST_SEEN = list(
			"Last seen %DIRECTION.",
			"Moved %DIRECTION.",
			"Check %DIRECTION.",
			"Went %DIRECTION."
		),
		AI_CALLOUT_NO_SIGN = list(
			"Negative.",
			"No visual.",
			"Nothing.",
			"No contact.",
			"No mark."
		),
		AI_CALLOUT_COVERING = list(
			"Covering.",
			"Go.",
			"Got you.",
			"Cover's up."
		),
	)
	morale_lines = list(
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list(
				"This won't take long.",
				"Clean this up."
			),
		),
	)
