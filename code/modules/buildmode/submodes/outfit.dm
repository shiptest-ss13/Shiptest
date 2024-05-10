/datum/buildmode_mode/outfit
	key = "outfit"
	var/datum/outfit/dressuptime

/datum/buildmode_mode/outfit/Destroy()
	dressuptime = null
	return ..()

/datum/buildmode_mode/outfit/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Select outfit to equip")] -> Right Mouse Button on buildmode button\n\
		[span_bold("Equip the selected outfit")] -> Left Mouse Button on mob/living/carbon/human\n\
		[span_bold("Strip and delete current outfit")] -> Right Mouse Button on mob/living/carbon/human"))
	)

/datum/buildmode_mode/outfit/Reset()
	. = ..()
	dressuptime = null

/datum/buildmode_mode/outfit/change_settings(client/target_client)
	dressuptime = target_client.robust_dress_shop()

/datum/buildmode_mode/outfit/handle_click(client/target_client, params, object)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")
	var/right_click = pa.Find("right")

	if(!ishuman(object))
		return
	var/mob/living/carbon/human/dollie = object

	if(left_click)
		if(isnull(dressuptime))
			to_chat(target_client, "<span class='warning'>Pick an outfit first.</span>")
			return

		for (var/item in dollie.get_equipped_items(TRUE))
			qdel(item)
		if(dressuptime != "Naked")
			dollie.equipOutfit(dressuptime)

	if(right_click)
		for (var/item in dollie.get_equipped_items(TRUE))
			qdel(item)
