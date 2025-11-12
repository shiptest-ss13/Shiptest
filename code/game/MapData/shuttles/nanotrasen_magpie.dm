//holodisk stuff

/datum/preset_holoimage/vi_director
	species_type = /datum/species/lizard
	outfit_type = /datum/outfit/job/nanotrasen/captain/vi


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
	DELAY 40
	SAY Elaboration on that last point, you're permitted to distribute equipment as you deem necessary; but the fault will lie with you if a new leaf causes an incident with one of *our* arms, get me?
	DELAY 50
	SAY ...Alright.
	DELAY 40
	SAY Try to get along with the other company staff, including the captain. They're not your direct superiors, but they *do* belong to our client company.
	DELAY 40
	SAY It's in our best interest to keep relations smooth. Only situation you should step in is if they're putting the vessel in unnecessary amounts of danger.
	DELAY 40
	SAY Remember that danger is just the nature of things out here. Use your best judgement in the matter.
	DELAY 40
	SAY That's all we need to go over. Good luck on your shift, we'll debrief after.
	DELAY 30
	"}

/datum/preset_holoimage/ns_director
	species_type = /datum/species/elzuose
	outfit_type = /datum/outfit/job/nanotrasen/quartermaster


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
	DELAY 40
	SAY This means at minimum, excavating fuel for the ship's generators, supplying the engineer with material for their projects, and carrying out general outside work.
	DELAY 40
	SAY You'll often be one of the first pair of boots outside the vessel, so it's critical you can take care of yourself.
	DELAY 40
	SAY Inside this room are your tools of the trade. Make use of them and refer to the safety posters for further guidance.
	SOUND keyboard
	DELAY 40
	SAY Good luck, Miner, director out.
	DELAY 30
	"}
