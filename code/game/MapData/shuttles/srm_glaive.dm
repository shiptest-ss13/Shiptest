/obj/item/melee/transforming/cleaving_saw/old
	name = "old cleaving saw"
	desc = "This saw, old and rusted, is still an effective tool at bleeding beasts and monsters."
	force = 10
	force_on = 15 //force when active
	throwforce = 15
	throwforce_on = 15
	faction_bonus_force = 5
	nemesis_factions = list("mining", "boss")
	bleed_stacks_per_hit = 1.5


/obj/structure/closet/secure_closet/medicalsrm
	name = "hunter doctor closet"
	desc = "Everything the Hunter Doctor needs to heal the hurting masses."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/secure_closet/shadow
	name = "shadow's locker"
	desc = "The closet of equipment and attire for the aspiring shadow."
	icon_state = "cabinet"

/obj/structure/closet/secure_closet/hunter
	name = "hunter's locker"
	desc = "Everything a hunter will need, held in one secure closet."
	icon_state = "cabinet"
	req_access = list(ACCESS_SECURITY)

/obj/structure/closet/secure_closet/montagnes
	name = "\proper Hunter Montagnes Locker"
	desc = "The posessions of the owning Hunter Montagnes."
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/miningcloset
	name = "mining equipment locker"
	desc = "The closet of mining equipment."
	icon_state = "mining"

/area/ship/external/dark
	name = "Dark External"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	icon_state = "space_near"

/area/ship/roumain
	name = "Hunter's Glade"
	icon_state = "Sleep"

/datum/preset_holoimage/montagne
	outfit_type = /datum/outfit/job/hos/roumain

/obj/item/disk/holodisk/roumain
	name = "Grand Ideology Sermon"
	desc = "A holodisk containing an SRM sermon."
	preset_image_type = /datum/preset_holoimage/montagne
	preset_record_text = {"
	NAME Montagne Gehrman
	SAY Oh ye followers of the Saint-Roumain.
	DELAY 25
	SAY Men and women of The Militia, Conquerers of nature, montagne, hunter, and shadow alike.
	DELAY 25
	SAY In His name, we maintain dominion over nature,
	DELAY 25
	SAY Dominion over the chaos of our lives and dominion over ourselves.
	DELAY 25
	DAY By defending ourselves and others, we defend His embers.
	DELAY 15
	"}


/obj/item/storage/firstaid/roumain
	name = "Roumain first aid kit"
	desc = "A common first aid kit used amongst the followers of the Ashen Huntsman."
	icon_state = "radfirstaid"
	item_state = "firstaid-rad"
	custom_premium_price = 1100

/obj/item/storage/firstaid/roumain/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/puce = 1,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/reagent_containers/glass/bowl/mushroom_bowl = 1,
		/obj/item/pestle = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/bear = 3,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf = 3,
	)
	generate_items_inside(items_inside, src)

/obj/structure/flora/tree/chapel/srm
	name = "Montagne's Oak"
	desc = "A sturdy oak tree imported directly from the homeworld of the Montagne who runs the ship it resides on. It is planted in soil from the same place."

/obj/item/book/manual/srmlore
	name = "Notes on the SRM"
	icon_state = "book5"
	author = "Montagne Gehrman"
	title = "Notes on the Saint-Roumain Militia"
	dat = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			Notes on the Saint-Roumain Militia:<br>
			The SRM originated on the planet Illestren, a planet colonized early in the
			expansionist period of space exploration by solgov colonists. Formed by large
			group of hunters who banded together to form a sort of citizen's militia.
			When these Solgov colonists came to Illestren, the brought with them the
			tales of the Ashen Hunter, a figure who came to be venerated by this militia.
			The Ashen Huntsman is a religious figure venerated by the SRM, said to be able
			to survive any conditions on their own, and fell any man, creature, or beast
			with just a single shot from their rifle. The origin of this religious figure
			is largely unknown and debated by many scholars within the SRM. But they likely
			originate from a survivalist originating from Sol. The stories of the Ashen
			Huntsman's valor, glorious hunts, extreme survivalism, and dedication to
			ascectic practices are passed around by members of the SRM who wish to
			emulate such glory.<br>
			Many of the SRM are contracted mercenaries, mostly hired aboard independent
			vessels. The religious habits amongst members of the organization make them
			less popular hires for many corporate or government factions. However Nanotrasen
			doesn't disallow veneration of the Ashen Huntsman on their vessels, making
			them one of the more common factions for SRM members to serve.<br>
			The SRM itself is structured around individual companies of hunters. Each SRM
			vessel is led by a Montagne, who usually owns the ship. Around three to five
			Hunters, and three Shadows serve alongside them. Hunters are the stock of the
			SRM, serving as the primary worker and employee. Shadows serve under them,
			studying and practicing the ways of the ship they serve on, and the SRM
			at large.<br>
			The primary source on income for the organization comes from a mix of
			hunting and weapons manufacturing. Hunts by the SRM range from wiping
			out large hordes of unruly beasts that pose a threat to their local
			region, to capturing exotic beasts unharmed for collectors or
			preservation. Farmers and rich landowners are common patrons of the
			SRM. Most SRM vessels and outposts will include a workshop known as
			the "Hunter's Pride". This is where the organization manufactures arms
			in house. For the most part the SRM produce and rely on manual-action
			firearms, relying on accuracy and high-caliber munitions over high rate
			fire or advanced technology. Most old-earth weaponry is produced by
			the SRM.<br>
			The practices of members of the SRM are generally ascectic in nature.
			Automatic and technological firearms are disliked by most hunters
			within the group, typically favoring blades and single-action firearms.
			Lightweight clothing and armors are the favored garb of an SRM hunter,
			with dusters and simple working garbs for safer environments. Resting
			and eating are also important parts of SRM culture. The soil upon an
			SRM ship will be imported from the home planet of the Montagne running it,
			and it serves equally as a place of worship, place of meeting, and a place
			to sleep. Mealtimes often consist of raw or charred meats from animals raised
			or hunted by the crew of an SRM vessel. Sometimes these meals are supplemented
			by simple crops grown in house.<br>
			Ranking amongst the SRM is by and large non-discriminatory. Rank and status
			within the organization is decided solely by skill and dedication. While
			many Montagne lack in skill or time spent within the organization, they
			will almost always be the most dedicated member aboard.
			Finally, the SRM comes with a sort of Grand Ideology, one that is usually
			included aboard SRM vessels in one way or another. The ideology reads thus:
			“In His name, we maintain dominion over nature,
			dominion over the chaos of our lives and dominion over ourselves.
			By defending ourselves and others, we defend His embers.”
			</body>
			</html>"}
