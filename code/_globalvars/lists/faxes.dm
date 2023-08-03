/**
 * This defines the list of faxes managed by the server administrators. They are not physically present in
 * the game, but are shown in the fax list as existing.
 * Lists:
 * * additional_faxes_list - A list of "legal" faxes available with authorization.
 * * frontier_faxes_list - List of faxes available after hacking.
 *
 * The list consists of the following elements:
 * * fax_name - The name displayed in the fax list.
 * * button_color - The color of this fax button in the list of all faxes.
 */
GLOBAL_LIST_INIT(additional_faxes_list, list(
	list("fax_name" = "NanoTrasen Central Command", "button_color" = "#46B946"),
	list("fax_name" = "Inteq Management Field Command", "button_color" = "#FACE65"),
	list("fax_name" = "Colonial Minutemen Headquarters", "button_color" = "#538ACF"),
	list("fax_name" = "Saint-Roumain Council of Huntsmen", "button_color" = "#6B443D"),
	list("fax_name" = "SolGov Department of Administrative Affairs", "button_color" = "#536380"),
	list("fax_name" = "Syndicate Coordination Center", "button_color" = "#B22C20"),
	list("fax_name" = "Outpost Administration", "button_color" = "#dddfc9"),
))

GLOBAL_LIST_INIT(frontier_faxes_list, list(
	list("fax_name" = "Frontiersmen Communications Outpost", "button_color" = "#70654C")
))

GLOBAL_LIST_EMPTY(fax_machines) //list of all fax machines
