/datum/blackmarket_item/tech
	category = "Technology"

/datum/blackmarket_item/tech/ripley_mk_4
	name = "Ripley Mk IV Upgrade Kit"
	desc = "Pimp out your Ripley to the CLIP Mark IV Rogue Model today! Killjoy bureaucrats not included, thank god."
	item = /obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley/clip

	price_min = 1500
	price_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/tech/chem_master
	name = "Chem Master Board"
	desc = "A Chem Master board, capable of seperating and packaging reagents. Perfect for any aspiring at home chemist."
	item = /obj/item/circuitboard/machine/chem_master

	price_min = 1000
	price_max = 3000
	stock = 1
	availability_prob = 30

/datum/blackmarket_item/tech/mrs_pacman
	name = "MRSPACMAN-type Generator Board"
	desc = "A ridiciously overclocked PACMAN generator that somehow burns diamonds as fuel."
	item = /obj/item/circuitboard/machine/pacman/mrs

	price_min = 2000
	price_max = 3000
	stock = 1
	availability_prob = 30

/datum/blackmarket_item/tech/ai_core
	name = "AI Core Board"
	desc = "The future is now! Become one with your ship with this AI core board! (Some assembly required.)"
	item = /obj/item/circuitboard/aicore
	pair_item = list(/datum/blackmarket_item/tech/boris, /datum/blackmarket_item/tech/mmi, /datum/blackmarket_item/tech/borg)

	price_min = 5000
	price_max = 8000
	stock = 1
	availability_prob = 5
	spawn_weighting =  = FALSE

/datum/blackmarket_item/tech/boris
	name = "B.O.R.I.S Module"
	desc = "A Bluespace Optimi-blah blah blah, I'm bored already. This module will convert a cyborg frame into an AI compatible shell."
	item = /obj/item/borg/upgrade/ai

	price_min = 500
	price_max = 1000
	stock = 1
	availability_prob = 0

/datum/blackmarket_item/tech/mmi
	name = "Man Machine Interface"
	desc = "Transcend the weakness of your flesh with this man machine interface, compatible with AIs, Cyborgs and Mechs!"
	item = /obj/item/mmi
	pair_item = list(/datum/blackmarket_item/tech/borg)

	price_min = 250
	price_max = 750
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/tech/borg
	name = "Cyborg Construction Kit"
	desc = "This durable and verastile cyborg frame is capable of fufilling a number of roles and survive situations that would kill the average person. Brain sold seperately."
	item = /obj/structure/closet/crate/cyborg

	price_min = 1000
	price_max = 2000
	stock_max = 2
	availability_prob = 0

/datum/blackmarket_item/tech/t4_capacitor
	name = "Quadratic Capacitor"
	desc = "A top grade quadractic capacitor. These highly effiecent capacitors are capable of storing massive amounts of electricity. Keep away from open plugs."
	item = /obj/item/stock_parts/capacitor/quadratic

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 20

/datum/blackmarket_item/tech/t4_scanner
	name = "Triphasic Scanning Module"
	desc = "A top grade triphasic scanning module. These finely tuned scanning modules are usually reserved for vital systems like early warning defence radars against raiders and pirates. We decided to put it to better use."
	item = /obj/item/stock_parts/scanning_module/triphasic

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 20

/datum/blackmarket_item/tech/t4_manip
	name = "Femto Manipulator"
	desc = "A top grade femto manipulator. These insanely precise manipuators are capable of manipulating particles up to a quadtillionth of a meter. Still not precise enough to find a single braincell in an NT exec's head though."
	item = /obj/item/stock_parts/manipulator/femto

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 20

/datum/blackmarket_item/tech/t4_laser
	name = "Quad-Ultra Microlaser"
	desc = "A top grade quad-ultra microlaser. A bit too micro of a laser to actually kill anyone with, but more than enough to get the most out of your materials."
	item = /obj/item/stock_parts/micro_laser/quadultra

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 20

/datum/blackmarket_item/tech/t4_bin
	name = "Bluespace Matter Bin"
	desc = "A top grade bluespace matter bin. Uses the power of bluespace to contain tons of matter without all the hassle of actually needing to carry literal tons with only a miniscule chance of ripping a hole in reality."
	item = /obj/item/stock_parts/matter_bin/bluespace

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 20

/datum/blackmarket_item/tech/crew_monitor
	name = "Crew Monitor Board"
	desc = "A crew monitor computer board, for watching your hapless crew die in real time."
	item = /obj/machinery/computer/crew

	price_min = 750
	price_max = 1250
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/tech/sec_cam
	name = "Camera Console Board"
	desc = "A camera console computer board, for when you want to invade your crew's privacy."
	item = /obj/item/circuitboard/computer/security

	price_min = 750
	price_max = 1250
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/tech/emag_limited
	name = "Limited Cryptographic Sequencer"
	desc = "These cryptographic sequencers are perfect for bypassing any mechanical safties or just breaking shit in general. They're pretty old though, and will probably burn out after a single use. Do not keep in the same wallet as your credit card."
	item = /obj/item/card/emag/limited

	price_min = 750
	price_max = 1500
	stock_min = 2
	stock_max = 7
	availability_prob = 30

/datum/blackmarket_item/tech/joywire
	name = "Pleasure Vivifier Neural Implant"
	desc = "Midi-Sim's ever popular pleasure vivifier implant promises a constant rush of dopamine to get you high on life."
	item = /obj/item/organ/cyberimp/brain/joywire

	price_min = 500
	price_max = 1000
	stock_min = 3
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/tech/joywire/spawn_item(loc)
	if(prob(10))
		var/obj/item/organ/cyberimp/brain/mindscrew/implant = ..()
		implant.name = "\improper Midi-Sed pleasure vivifier"
		implant.desc = "A widely popular (and addictive) implant produced by Miditeke-Sedari Tokoce that \
		stimulates the brain's pleasure centers. \
		Dramatically increases mood, but interferes with taste reception even if uninstalled. \
		It's wires seem a little loose."
		return new implant(loc)
	return ..()

/datum/blackmarket_item/tech/mindscrew
	name = "MNDFCK Neural Implant"
	desc = "Death is too good for your enemies. This aftermarket modification of Midi-Sim's pleasure vivifier instead triggers every single pain neuron in the poor sucker's head. Each MNDFCK has been extensively tested by our lovely volunteers to ensure the maximum quantity of suffering."
	item = /obj/item/organ/cyberimp/brain/mindscrew

	price_min = 500
	price_max = 1500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/tech/arm_gun
	name = "Arm Mounted Laser Cannon Implant"
	desc = "A retractable laser cannon that fits inside your arm for concealment. You won't be passing any metal detector scans though."
	item = /obj/item/organ/cyberimp/arm/gun/laser

	price_min = 2000
	price_max = 4000
	stock = 1
	availability_prob = 15
	spawn_weight = FALSE
