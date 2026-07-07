//holodisk stuff

/datum/outfit/magpiesecretary
	name = "Magpie Holodisk Secretary"
	uniform = /obj/item/clothing/under/warra/affairs
	suit = /obj/item/clothing/suit/warra/suitjacket
	glasses = /obj/item/clothing/glasses/regular/thin
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/heels/black

/datum/preset_holoimage/magpiesecretary
	species_type = /datum/species/human
	outfit_type = /datum/outfit/magpiesecretary


/obj/item/disk/holodisk/ship/magpie/commandnotice
	name = "holorecord disk - Command Directive"
	preset_image_type = /datum/preset_holoimage/magpiesecretary
	preset_record_text = {"
	NAME MW Administrative Assistant
	DELAY 10
	SAY Greetings, this is a pre-recorded message from the regional director's current administrative assistant!
	DELAY 30
	SAY I'll be ensuring we have all our stars aligned to facilitate a productive day.
	DELAY 40
	SAY Let's circle back to our previous meeting notes and set expectations going forth...
	SOUND keyboard
	DELAY 40
	SAY ...You are in command of one of our Magpie-class exploration crafts!
	DELAY 40
	SAY A small multi-role design, easily adaptable to the dynamic workplace environments of the Frontier.
	DELAY 50
	SAY With this asset and all those inside it assigned to you, you're expected to facilitate our strategic growth in the region through action.
	DELAY 50
	SAY While your vessel lacks specialization in just *one* of our fields, you have bountiful opportunities unfeasible for other vessels.
	DELAY 60
	SAY You are expected to make the best utilization of the assets and staff provided to you to pivot towards these profitable avenues as they arise.
	DELAY 60
	SAY In the process of doing so, it is your responsibility to set a good example for the staff under you and lead them to success through efficient management.
	DELAY 60
	SAY As one of two managerial staff assigned to this vessel, it is typical to discuss division of duties between yourselves.
	DELAY 50
	SAY I encourage you to do so after this message has concluded.
	DELAY 50
	SAY If you are short on managerial staff, it is encouraged to assign the most capable person among your staff to an interim first officer position.
	DELAY 60
	SAY As the second in command, the first officer is expected to act as the bridge between the captain's goals and daily execution.
	DELAY 50
	SAY You advance rough plans to actionable strategy and course correct when necessary.
	DELAY 40
	SAY In private with the captain, you should challenge assumptions to ensure every angle of approach is considered.
	DELAY 50
	SAY Once the captain has decided on an approach to a goal, you present a unified front to the public.
	DELAY 50
	SAY It is common strategy for you two to present yourselves to the crew in a differing manner.
	DELAY 50
	SAY When one is bold, the other is subtle. This manner of approach appeals to the widest demographic, ensuring your staff will feel comfortable approaching either of you.
	DELAY 60
	SAY Utilize these strategies during your command to increase your daily productivity.
	DELAY 50
	SAY Afterwards, I'll reach out and touch base to discuss the results of the day. Hope I helped, I look forward to hearing from you then!
	DELAY 50
	"}


/datum/preset_holoimage/vi_director
	species_type = /datum/species/lizard
	outfit_type = /datum/outfit/job/warra/captain/vi


/obj/item/disk/holodisk/ship/magpie/securitynotice
	name = "holorecord disk - Security Directive"
	preset_image_type = /datum/preset_holoimage/vi_director
	preset_record_text = {"
	NAME Vigilitas Security Director
	DELAY 10
	SAY This is your director speaking, welcome to your jobsite security office.
	DELAY 20
	SAY Little recap of your responsibilities while you're stationed here --ahem, You are to...
	SOUND keyboard
	DELAY 40
	SAY Keep the vessel and company assets safe from threats both internal and external.
	DELAY 30
	SAY Ensure secure storage of the equipment you've been provided, current or future acquisitions.
	DELAY 30
	SAY Regularly inspect your firearms and other equipment to ensure they're in working order.
	DELAY 30
	SAY Train other company personnel on safe handling and use of this equipment...
	SOUND keyboard
	DELAY 50
	SAY Elaboration on that last point, you're permitted to distribute equipment as you deem necessary.
	DELAY 30
	SAY But the fault will lie with you if a new leaf causes an incident with one of *our* arms, get me?
	DELAY 50
	SAY ...Alright.
	DELAY 40
	SAY Try to get along with the other company staff, including the captain. They're not your direct superiors, but they *do* belong to our client company.
	DELAY 50
	SAY It's in our best interest to keep relations smooth. Only situation you should step in is if they're putting the vessel in unnecessary amounts of danger.
	DELAY 50
	SAY Remember that danger is just the nature of things out here. Use your best judgement in the matter.
	DELAY 50
	SAY That's all we need to go over. Good luck on your shift, we'll debrief after.
	DELAY 50
	"}

/datum/preset_holoimage/ns_director
	species_type = /datum/species/elzuose
	outfit_type = /datum/outfit/job/warra/quartermaster


/obj/item/disk/holodisk/ship/magpie/supplynotice
	name = "holorecord disk - Supply Directive"
	preset_image_type = /datum/preset_holoimage/ns_director
	preset_record_text = {"
	NAME N+S Supply Director
	DELAY 10
	SAY Morning, afternoon, or evening, Miner. This is your supply director speaking, welcome to your jobsite equipment room.
	DELAY 40
	SAY Quick rundown of your job here again.
	SOUND keyboard
	DELAY 30
	SAY You're collecting resources and performing extra vehicular labour at behest of our clients.
	DELAY 50
	SAY This means at minimum, excavating fuel for the ship's generators, supplying the engineer with material for their projects, and carrying out general outside work.
	DELAY 60
	SAY You'll often be one of the first pair of boots outside the vessel, so it's critical you can take care of yourself.
	DELAY 50
	SAY Inside this room are your tools of the trade. Make use of them and refer to the safety posters for further guidance.
	SOUND keyboard
	DELAY 50
	SAY Good luck, Miner, director out.
	DELAY 50
	"}

/datum/preset_holoimage/med_director
	species_type = /datum/species/ipc
	outfit_type = /datum/outfit/job/warra/cmo


/obj/item/disk/holodisk/ship/magpie/medicalnotice
	name = "holorecord disk - Medical Directive"
	preset_image_type = /datum/preset_holoimage/med_director
	preset_record_text = {"
	NAME MW Medical Director
	DELAY 10
	SAY Hello there! This is your director and welcome to your medbay. I'm quite busy, so I'll need to keep this brief.
	DELAY 40
	SAY Here is a reminder of your responsibilities and expected conduct while working here.
	SOUND keyboard
	DELAY 40
	SAY You are responsible for the holistic health and safety of the lives aboard this exploration craft with you.
	DELAY 50
	SAY Anxiety and injury is common aboard Frontier-bound vessels such as this.
	DELAY 50
	SAY It is of utmost importance you prepare yourself physically and mentally to care for those who entrust their well-being to you.
	DELAY 50
	SAY You will be the one those around you look towards during moments of vulnerability.
	DELAY 50
	SAY As such, it is important to maintain an empathetic and level-headed approach while addressing those people.
	DELAY 50
	SAY Obtain consent to make physical contact with your patients prior to administering aid, unless their condition is immediately life-threatening.
	DELAY 50
	SAY Talk them through the actions you perform and allow them to ask questions.
	DELAY 60
	SAY You are expected to maintain a reasonable level of confidentiality between your patients and yourself
	DELAY 40
	SAY -unless doing so would risk imminent harm to them or others.
	DELAY 60
	SAY Finally, remember the mantra... an ounce of prevention is worth a pound of cure.
	DELAY 50
	SAY Remind those around you to follow safe workplace practices, to carry the appropriate PPE and enable their vitals monitors and trackers.
	SOUND keyboard
	DELAY 60
	SAY That is all I have time for! Be at your best for yourself and others, and goodbye.
	DELAY 50
	"}

/datum/preset_holoimage/engi_director
	species_type = /datum/species/ipc
	outfit_type = /datum/outfit/job/warra/ce


/obj/item/disk/holodisk/ship/magpie/engineeringnotice
	name = "holorecord disk - Engineering Directive"
	preset_image_type = /datum/preset_holoimage/engi_director
	preset_record_text = {"
	NAME MW Engineering Director
	DELAY 10
	SAY Weeeeelcome to the engineering bay, engi!
	SOUND sparks
	DELAY 30
	SAY Let's go over your job again quick, yes? Grab your tools!
	SOUND sparks
	DELAY 40
	SAY You, lucky you, get to oversee the systems of one of those new co-opted Magpies!
	DELAY 40
	SAY You'll get some treats I didn't back in my day.
	DELAY 40
	SAY This nacelle is home to your office, power gen, and fabrication. Standard-grade stuff for a ship like this.
	DELAY 50
	SAY Over in the portside nacelle, you've got your atmospherics setup.
	DELAY 40
	SAY Starting here, first thing you'll wanna do is get your power flowing all reliable.
	DELAY 40
	SAY Ship's got some fancy new systems, but the generator can struggle to keep up with standard-grade components.
	DELAY 50
	SAY So confer with your power monitor now and then. If she's struggling to keep, best to start turning off non-essential systems like the grav and lights.
	DELAY 50
	SAY Over portside, you'll wanna set the temperature gates for the external intake right.
	DELAY 50
	SAY My go-to settings are a low bar of 290 K and high bar of 300 K.
	DELAY 50
	SAY That'll net you some good intake without pushing your harvest too far out of comfortable room temp for the occupants.
	DELAY 50
	SAY If you're out looking to siphon some fuel up you might need to change that, but take care not to pollute the air supply with extreme temperature gasses.
	DELAY 60
	SAY Setup aside, your hands and expertise will probably be required EVA regularly.
	DELAY 40
	SAY So keep your PPE on you!
	SOUND sparks
	DELAY 60
	SAY Supervision's up to you while you're out there. If you go 'overhauling' any of the systems, you tell me when you're back though, eh?
	DELAY 60
	SAY Now, I'm getting back to my own work and you're getting to yours. Seeya, Hardhat!
	DELAY 50
	"}

/datum/outfit/lioplesintern
	name = "Magpie Holodisk Lioples Intern"
	head = /obj/item/clothing/head/warra/cap/janitor
	uniform = /obj/item/clothing/under/warra/janitor
	gloves = /obj/item/clothing/gloves/nitrile/pink
	shoes = /obj/item/clothing/shoes/sneakers/purple

/datum/preset_holoimage/lioplesintern
	species_type = /datum/species/moth
	outfit_type = /datum/outfit/lioplesintern


/obj/item/disk/holodisk/ship/magpie/caimannotice
	name = "holorecord disk - Caiman Directive"
	preset_image_type = /datum/preset_holoimage/lioplesintern
	preset_record_text = {"
	NAME MW Animal Care Intern
	DELAY 10
	SAY Hello-hello, hello? Uh...I wanted to record a message for you.
	DELAY 30
	SAY I used to uuh...care for that dwarf caiman there before your shift.
	DELAY 30
	SAY and now I gotta tell you what uh, needs to be done on your shift.
	SOUND hiss
	DELAY 50
	SAY ...they need to be fed three times a week. Uh...Wednesday, Friday, and Saturday is the current feeding schedule.
	DELAY 40
	SAY You might need to clean out some uh, scraps from their enclosure every now and then. They have a uh, habit of avoiding eating bones.
	DELAY 30
	SAY Don't know why. Eeh...uh...
	DELAY 50
	SAY ...right, let's see. Uh.
	DELAY 30
	SAY There was an incident tuesday, they uuh-took a bite out of my coworker.
	DELAY 60
	SAY Now- now! I know that sounds bad...but there's really nothing to worry about.
	DELAY 30
	SAY Just try not to put your hands near the sides of Lioples' face.
	DELAY 30
	SAY It gets them quirky. That's their like, uh, strike zone. Lots more likely to get bit like that...
	DELAY 50
	SAY Don't tap the glass either, it's uh. It stresses them out...
	DELAY 60
	SAY ...hh..hhh...
	DELAY 50
	SAY Okay. That's it.
	DELAY 40
	SAY How do I turn this o-
	DELAY 10
	SAY HEY!!
	SOUND hiss
	DELAY 20
	"}
