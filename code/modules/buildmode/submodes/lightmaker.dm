/datum/buildmode_mode/lightmaker
	key = "lightmaker"

	var/light_range = 3
	var/light_power = 1
	var/light_color = COLOR_WHITE

/datum/buildmode_mode/lightmaker/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Left Click")] -> Create light\n\
		[span_bold("Right Click")] -> Delete light\n\
		[span_bold("Right Click on Build Mode Button")] -> Change light properties"))
	)

/datum/buildmode_mode/lightmaker/change_settings(client/target_client)
	var/choice = alert("Change the new light range, power or color?", "Light Maker", "Range", "Power", "Color", "Cancel")
	switch(choice)
		if("Range")
			light_range = input(target_client, "Range of light", text("Input")) as num|null
		if("Power")
			light_power = input(target_client, "Power of light", text("Input")) as num|null
		if("Color")
			light_color = input(target_client, "Light color", text("Input")) as color|null

/datum/buildmode_mode/lightmaker/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		object.set_light(light_range, light_power, light_color)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		object.set_light(0,0,COLOR_WHITE)
