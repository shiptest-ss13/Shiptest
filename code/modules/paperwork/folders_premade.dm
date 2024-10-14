/obj/item/folder/blue
	desc = "A blue folder."
	icon_state = "folder_blue"

/obj/item/folder/red
	desc = "A red folder."
	icon_state = "folder_red"

/obj/item/folder/yellow
	desc = "A yellow folder."
	icon_state = "folder_yellow"

/obj/item/folder/white
	desc = "A white folder."
	icon_state = "folder_white"

/obj/item/folder/solgov
	desc = "A blue folder with a SolGov seal."
	icon_state = "folder_solgov"

/obj/item/folder/terragov
	desc = "A green folder with a Terran Regency seal."
	icon_state = "folder_terragov"

/obj/item/folder/syndicate
	desc = "A folder with a Syndicate color scheme."
	icon_state = "folder_syndie"

/obj/item/folder/documents
	var/document = /obj/item/documents/nanotrasen
	name = "folder- 'TOP SECRET'"
	desc = "A folder stamped \"Top Secret - Property of Nanotrasen Corporation. Unauthorized distribution is punishable by death.\""

/obj/item/folder/documents/Initialize()
	. = ..()
	new document(src)
	update_appearance()

/obj/item/folder/documents/syndicate
	icon_state = "folder_syndie"
	name = "folder- 'TOP SECRET'"
	desc = "A folder stamped \"Top Secret - Property of The Syndicate.\""

/obj/item/folder/documents/syndicate/cybersun
	document = /obj/item/documents/syndicate/cybersun
	icon_state = "folder_sred"
	desc = "A folder stamped \"Top Secret - Property of Cybersun Industries.\""

/obj/item/folder/documents/syndicate/cybersun/biodynamics
	document = /obj/item/documents/syndicate/cybersun/biodynamics
	icon_state = "folder_sblue"

/obj/item/folder/documents/syndicate/red
	document = /obj/item/documents/syndicate/red
	icon_state = "folder_sred"

/obj/item/folder/documents/syndicate/blue
	document = /obj/item/documents/syndicate/blue
	icon_state = "folder_sblue"

/obj/item/folder/documents/syndicate/mining
	document = /obj/item/documents/syndicate/mining

/obj/item/folder/documents/syndicate/ngr
	document = /obj/item/documents/syndicate/ngr
	icon_state = "folder_ngr"

/obj/item/folder/documents/solgov
	document = /obj/item/documents/solgov
	desc = "A blue folder with a SolGov seal."
	icon_state = "folder_solgovred"

/obj/item/folder/documents/terragov
	document = /obj/item/documents/terragov
	desc = "A green folder with a Terran Regency seal."
	icon_state = "folder_terragovred"

/obj/item/folder/suns
	desc = "A purple folder with a SUNS seal."
	icon_state = "folder_suns"

/obj/item/folder/suns/red
	icon_state = "folder_sunsred" // i'm not sure why SUNS would need secret documents

//pgf folders

/obj/item/folder/pgf
	desc = "A green folder with Pan Gezenan Federation iconography."
	icon_state = "folder_pgf"

/obj/item/folder/pgf/red
	icon_state = "folder_pgfred"

/obj/item/folder/pgf/blue
	icon_state = "folder_pgfblue"
