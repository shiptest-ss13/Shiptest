// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/rockplanet
	prefix = "_maps/RandomRuins/RockRuins/"

	ruin_type = RUINTYPE_ROCK

/datum/map_template/ruin/rockplanet/budgetcuts
	name = "Budgetcuts"
	description = "Nanotrasen's gotta lay off some personnel, and this facility hasn't been worth the effort so far"
	id = "rockplanet_budgetcuts"
	suffix = "rockplanet_budgetcuts.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/rockplanet/shippingdock
	name = "Abandoned Shipping Dock"
	description = "An abandoned shipping dock used by small cargo freighters and smugglers alike. Some malicious group seems to have trapped the place to eliminate scavengers."
	id = "rockplanet_shippingdock"
	suffix = "rockplanet_shippingdock.dmm"

/datum/map_template/ruin/rockplanet/distillery
	name = "Frontiersman Distillery"
	description = "A former pre-ICW era Nanotrasen outpost converted into a moonshine distillery by Frontiersman bootleggers."
	id = "rockplanet_distillery"
	suffix = "rockplanet_distillery.dmm"
	ruin_mission_types = list(/datum/mission/ruin/signaled/kill/frontiersmen)

/datum/map_template/ruin/rockplanet/mining_base
	name = "N+S Mining Installation"
	description = "A N+S mining installation recently fallen prey to a band of Ramzi pirates."
	id = "rockplanet_mining_base"
	suffix = "rockplanet_mining_installation.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)
	ruin_mission_types = list(
		/datum/mission/ruin/signaled/drill/mining_base,
		/datum/mission/ruin/ns_manager,
	)

/datum/mission/ruin/signaled/drill/mining_base
	name = "Resume Site Operation"
	desc = "N+S Logistics has lost contact with a recently established mining base. We believe that this base is located upon an extremely lucrative hydrogen-ice vein. \
			Due to loss of contact, N+S has been unable to verify the existence of this vein. Please move to the site, locate the drilling system, and bring us our geological survey results. \
			If an N+S team is still on site, please inform them that their communications system has been damaged, and that the next supply run will be in 3 weeks."
	value = 20000
	faction = list(
		/datum/faction/nt/ns_logi,
	)

/datum/mission/ruin/ns_manager
	name = "Retrieve Manager For Interview"
	desc = "Due to communication failure at one of our remote mining installations, N+S Logistics has been unable to verify the condition of its site and staff. Please travel to the site and locate the manager of the installation. Retrieve them for us so that we may interview on why they have neglected repair of their comms array."
	value = 3000
	faction = list(
		/datum/faction/nt/ns_logi,
	)
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/rockplanet/rust_base
	name = "ISV Rust Base"
	description = "A crashed Ramzi Clique vessel that has since become an isolated pirate outpost."
	id = "rockplanet_rustbase"
	suffix = "rockplanet_rustbase.dmm"
