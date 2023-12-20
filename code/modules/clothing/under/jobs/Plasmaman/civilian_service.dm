/obj/item/clothing/under/plasmaman/cargo
	name = "cargo plasma envirosuit"
	desc = "A joint envirosuit used by plasmamen quartermasters and cargo techs alike, due to the logistical problems of differenciating the two with the length of their pant legs."
	icon_state = "cargo_envirosuit"
	item_state = "cargo_envirosuit"

/obj/item/clothing/under/plasmaman/mining
	name = "mining plasma envirosuit"
	desc = "An air-tight khaki suit designed for operations on lavaland by plasmamen."
	icon_state = "explorer_envirosuit"
	item_state = "explorer_envirosuit"

/obj/item/clothing/under/plasmaman/chef
	name = "chef's plasma envirosuit"
	desc = "A white plasmaman envirosuit designed for cullinary practices. One might question why a member of a species that doesn't need to eat would become a chef."
	icon_state = "chef_envirosuit"
	item_state = "chef_envirosuit"

/obj/item/clothing/under/plasmaman/enviroslacks
	name = "enviroslacks"
	desc = "The pet project of a particularly posh plasmaman, this custom suit was quickly appropriated by Nano-Trasen for it's detectives, lawyers, and bar-tenders alike."
	icon_state = "enviroslacks"
	item_state = "enviroslacks"

/obj/item/clothing/under/plasmaman/chaplain
	name = "chaplain's plasma envirosuit"
	desc = "An envirosuit specially designed for only the most pious of plasmamen."
	icon_state = "chap_envirosuit"
	item_state = "chap_envirosuit"

/obj/item/clothing/under/plasmaman/curator
	name = "curator's plasma envirosuit"
	desc = "Made out of a modified voidsuit, this suit was Nano-Trasen's first solution to the *logistical problems* that come with employing plasmamen. Due to the modifications, the suit is no longer space-worthy. Despite their limitations, these suits are still in used by historian and old-styled plasmamen alike."
	icon_state = "prototype_envirosuit"
	item_state = "prototype_envirosuit"

/obj/item/clothing/under/plasmaman/janitor
	name = "janitor's plasma envirosuit"
	desc = "A grey and purple envirosuit designated for plasmamen janitors."
	icon_state = "janitor_envirosuit"
	item_state = "janitor_envirosuit"

/obj/item/clothing/under/plasmaman/botany
	name = "botany envirosuit"
	desc = "A green and blue envirosuit designed to protect plasmamen from minor plant-related injuries."
	icon_state = "botany_envirosuit"
	item_state = "botany_envirosuit"


/obj/item/clothing/under/plasmaman/mime
	name = "mime envirosuit"
	desc = "It's not very colourful."
	icon_state = "mime_envirosuit"
	item_state = "mime_envirosuit"

/obj/item/clothing/under/plasmaman/clown
	name = "clown envirosuit"
	desc = "<i>'HONK!'</i>"
	icon_state = "clown_envirosuit"
	item_state = "clown_envirosuit"

/obj/item/clothing/under/plasmaman/prisoner
	name = "prisoner envirosuit"
	desc = "An orange envirosuit identifying and protecting a criminal plasmaman."
	icon_state = "prisoner_envirosuit"
	item_state = "prisoner_envirosuit"

/obj/item/clothing/under/plasmaman/clown/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(H.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message("<span class='warning'>[H]'s suit spews out a tonne of space lube!</span>","<span class='warning'>Your suit spews out a tonne of space lube!</span>")
			H.ExtinguishMob()
			new /obj/effect/particle_effect/foam(loc) //Truely terrifying.
	return 0

/obj/item/clothing/under/plasmaman/command //WS edit plasmaman customization
	name = "captains plasma envirosuit"
	desc = "A navy blue envirosuit with Tartrazine gold trimmings."
	icon_state = "command_envirosuit"
	item_state = "command_envirosuit"

/obj/item/clothing/under/plasmaman/hop //WS edit plasmaman customization
	name = "head of personnel plasma envirosuit"
	desc = "A navy blue envirosuit with Allura red trimmings."
	icon_state = "hop_envirosuit"
	item_state = "hop_envirosuit"

/obj/item/clothing/under/plasmaman/cargo/skirt //WS edit plasmaman customization
	name = "cargo plasma enviroskirt"
	desc = "A postmodern envirosuit modification used by plasmawomen quartermasters and cargo techs alike, made as a solution to the logistical problems of differenciating the two with the length of their pant legs."
	icon_state = "cargo_enviroskirt"
	item_state = "cargo_enviroskirt"

/obj/item/clothing/under/plasmaman/chef/skirt //WS edit plasmaman customization
	name = "chef's plasma enviroskirt"
	desc = "A white plasmaman envirosuit modified with spatter shielding for culinary practices. One might question why a member of a species that doesn't need to eat would become a cook."
	icon_state = "chef_enviroskirt"
	item_state = "chef_enviroskirt"

/obj/item/clothing/under/plasmaman/enviroslacks/skirt //WS edit plasmaman customization
	name = "casual enviroskirt"
	desc = "The pet project of a particularly unusual plasmaman, this custom suit was appropriated by Nano-Trasen for casual usage."
	icon_state = "enviroskirt"
	item_state = "enviroskirt"

/obj/item/clothing/under/plasmaman/chaplain/skirt //WS edit plasmaman customization
	name = "chaplain's plasma enviroskirt"
	desc = "An envirosuit specially designed for only the least pious of the plasma people."
	icon_state = "chap_enviroskirt"
	item_state = "chap_enviroskirt"

/obj/item/clothing/under/plasmaman/janitor/skirt //WS edit plasmaman customization
	name = "janitor's plasma enviroskirt"
	desc = "A grey and purple spatter-shielded envirosuit designated for plasmawomen janitors."
	icon_state = "janitor_enviroskirt"
	item_state = "janitor_enviroskirt"

/obj/item/clothing/under/plasmaman/botany/skirt //WS edit plasmaman customization
	name = "botany enviroskirt"
	desc = "A green and blue envirosuit designed to protect plasmawomen from minor dirt-related spatter."
	icon_state = "botany_enviroskirt"
	item_state = "botany_enviroskirt"

/obj/item/clothing/under/plasmaman/prisoner/skirt //WS edit plasmaman customization
	name = "prisoner enviroskirt"
	desc = "An orange envirosuit identifying and protecting a criminal plasmawoman."
	icon_state = "prisoner_enviroskirt"
	item_state = "prisoner_enviroskirt"

/obj/item/clothing/under/plasmaman/command/skirt //WS edit plasmaman customization
	name = "captains plasma enviroskirt"
	desc = "A navy blue envirosuit with Tartrazine gold trimmings and a frilled brass kilt."
	icon_state = "command_enviroskirt"
	item_state = "command_enviroskirt"

/obj/item/clothing/under/plasmaman/hop/skirt //WS edit plasmaman customization
	name = "head of personnel plasma enviroskirt"
	desc = "A navy blue envirosuit with Allura red trimmings and a poofy skirt, just as blue to match."
	icon_state = "hop_enviroskirt"
	item_state = "hop_enviroskirt"

/obj/item/clothing/under/plasmaman/mime/skirt //WS edit plasmaman customization
	name = "mime enviroskirt"
	desc = "It's very colourful on the inside."
	icon_state = "mime_enviroskirt"
	item_state = "mime_enviroskirt"

/obj/item/clothing/under/plasmaman/lieutenant //WS edit plasmaman customization
	name = "lieutenants envirosuit"
	desc = "A navy blue envirosuit with chlorophyll green trimmings."
	icon_state = "lt_envirosuit"
	item_state = "lt_envirosuit"

/obj/item/clothing/under/plasmaman/lieutenant/skirt //WS edit plasmaman customization
	name = "lieutenants enviroskirt"
	desc = "A navy blue envirosuit with chlorophyll green trimmings and a poofy skirt, just as blue to match."
	icon_state = "lt_enviroskirt"
	item_state = "lt_enviroskirt"

