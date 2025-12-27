//DEFINITIONS FOR ASSET DATUMS START HERE.

/datum/asset/simple/tgui_common
	keep_local_name = TRUE
	assets = list(
		"tgui-common.bundle.js" = file("tgui/public/tgui-common.bundle.js"),
	)

/datum/asset/simple/tgui
	keep_local_name = TRUE
	assets = list(
		"tgui.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui.bundle.css" = file("tgui/public/tgui.bundle.css"),
	)

/datum/asset/simple/tgui_panel
	keep_local_name = TRUE
	assets = list(
		"tgui-panel.bundle.js" = file("tgui/public/tgui-panel.bundle.js"),
		"tgui-panel.bundle.css" = file("tgui/public/tgui-panel.bundle.css"),
	)

/datum/asset/simple/headers
	assets = list(
		"alarm_green.gif" = 'icons/program_icons/alarm_green.gif',
		"alarm_red.gif" = 'icons/program_icons/alarm_red.gif',
		"batt_5.gif" = 'icons/program_icons/batt_5.gif',
		"batt_20.gif" = 'icons/program_icons/batt_20.gif',
		"batt_40.gif" = 'icons/program_icons/batt_40.gif',
		"batt_60.gif" = 'icons/program_icons/batt_60.gif',
		"batt_80.gif" = 'icons/program_icons/batt_80.gif',
		"batt_100.gif" = 'icons/program_icons/batt_100.gif',
		"charging.gif" = 'icons/program_icons/charging.gif',
		"downloader_finished.gif" = 'icons/program_icons/downloader_finished.gif',
		"downloader_running.gif" = 'icons/program_icons/downloader_running.gif',
		"ntnrc_idle.gif" = 'icons/program_icons/ntnrc_idle.gif',
		"ntnrc_new.gif" = 'icons/program_icons/ntnrc_new.gif',
		"power_norm.gif" = 'icons/program_icons/power_norm.gif',
		"power_warn.gif" = 'icons/program_icons/power_warn.gif',
		"sig_high.gif" = 'icons/program_icons/sig_high.gif',
		"sig_low.gif" = 'icons/program_icons/sig_low.gif',
		"sig_lan.gif" = 'icons/program_icons/sig_lan.gif',
		"sig_none.gif" = 'icons/program_icons/sig_none.gif',
		"smmon_0.gif" = 'icons/program_icons/smmon_0.gif',
		"smmon_1.gif" = 'icons/program_icons/smmon_1.gif',
		"smmon_2.gif" = 'icons/program_icons/smmon_2.gif',
		"smmon_3.gif" = 'icons/program_icons/smmon_3.gif',
		"smmon_4.gif" = 'icons/program_icons/smmon_4.gif',
		"smmon_5.gif" = 'icons/program_icons/smmon_5.gif',
		"smmon_6.gif" = 'icons/program_icons/smmon_6.gif',
		"borg_mon.gif" = 'icons/program_icons/borg_mon.gif',
		"robotact.gif" = 'icons/program_icons/robotact.gif'
	)

/datum/asset/simple/radar_assets
	assets = list(
		"ntosradarbackground.png" = 'icons/UI_Icons/tgui/ntosradar_background.png',
		"ntosradarpointer.png" = 'icons/UI_Icons/tgui/ntosradar_pointer.png',
		"ntosradarpointerS.png" = 'icons/UI_Icons/tgui/ntosradar_pointer_S.png'
	)

/datum/asset/spritesheet/simple/pda
	name = "pda"
	assets = list(
		"atmos" = 'icons/pda_icons/pda_atmos.png',
		"back" = 'icons/pda_icons/pda_back.png',
		"bell" = 'icons/pda_icons/pda_bell.png',
		"blank" = 'icons/pda_icons/pda_blank.png',
		"boom" = 'icons/pda_icons/pda_boom.png',
		"bucket" = 'icons/pda_icons/pda_bucket.png',
		"medbot" = 'icons/pda_icons/pda_medbot.png',
		"floorbot" = 'icons/pda_icons/pda_floorbot.png',
		"cleanbot" = 'icons/pda_icons/pda_cleanbot.png',
		"crate" = 'icons/pda_icons/pda_crate.png',
		"cuffs" = 'icons/pda_icons/pda_cuffs.png',
		"eject" = 'icons/pda_icons/pda_eject.png',
		"flashlight" = 'icons/pda_icons/pda_flashlight.png',
		"honk" = 'icons/pda_icons/pda_honk.png',
		"mail" = 'icons/pda_icons/pda_mail.png',
		"medical" = 'icons/pda_icons/pda_medical.png',
		"menu" = 'icons/pda_icons/pda_menu.png',
		"mule" = 'icons/pda_icons/pda_mule.png',
		"notes" = 'icons/pda_icons/pda_notes.png',
		"power" = 'icons/pda_icons/pda_power.png',
		"rdoor" = 'icons/pda_icons/pda_rdoor.png',
		"reagent" = 'icons/pda_icons/pda_reagent.png',
		"refresh" = 'icons/pda_icons/pda_refresh.png',
		"scanner" = 'icons/pda_icons/pda_scanner.png',
		"signaler" = 'icons/pda_icons/pda_signaler.png',
		"skills" = 'icons/pda_icons/pda_skills.png',
		"status" = 'icons/pda_icons/pda_status.png',
		"dronephone" = 'icons/pda_icons/pda_dronephone.png',
		"emoji" = 'icons/pda_icons/pda_emoji.png'
	)

/datum/asset/spritesheet/simple/paper
	name = "paper"
	assets = list(
		"stamp-deny" = 'icons/paper_graphics/stamps/large_stamp-deny.png',
		"stamp-ok" = 'icons/paper_graphics/stamps/large_stamp-ok.png',
		"stamp-void" = 'icons/paper_graphics/stamps/large_stamp-void.png',
		"stamp-fo" = 'icons/paper_graphics/stamps/large_stamp-fo.png',
		"stamp-cmo" = 'icons/paper_graphics/stamps/large_stamp-cmo.png',
		"stamp-ce" = 'icons/paper_graphics/stamps/large_stamp-ce.png',
		"stamp-hos" = 'icons/paper_graphics/stamps/large_stamp-hos.png',
		"stamp-rd" = 'icons/paper_graphics/stamps/large_stamp-rd.png',
		"stamp-cap" = 'icons/paper_graphics/stamps/large_stamp-cap.png',
		"stamp-qm" = 'icons/paper_graphics/stamps/large_stamp-qm.png',
		"stamp-chap" = 'icons/paper_graphics/stamps/large_stamp-chap.png',
		"stamp-syndicate" = 'icons/paper_graphics/stamps/large_stamp-syndicate.png',
		"stamp-solgov" = 'icons/paper_graphics/stamps/large_stamp-solgov.png',
		"stamp-inteq" = 'icons/paper_graphics/stamps/large_stamp-inteq.png',
		"stamp-inteq_vanguard" = 'icons/paper_graphics/stamps/large_stamp-inteq_vanguard.png',
		"stamp-inteq_maa" = 'icons/paper_graphics/stamps/large_stamp-inteq_maa.png',
		"stamp-inteq_artificer" = 'icons/paper_graphics/stamps/large_stamp-inteq_artificer.png',
		"stamp-inteq_corpsman" = 'icons/paper_graphics/stamps/large_stamp-inteq_corpsman.png',
		"stamp-clip" = 'icons/paper_graphics/stamps/large_stamp-clip.png',
		"stamp-clip_cmm" = 'icons/paper_graphics/stamps/large_stamp-clip_cmm.png',
		"stamp-clip_gold" = 'icons/paper_graphics/stamps/large_stamp-clip_gold.png',
		"stamp-clip_bard" = 'icons/paper_graphics/stamps/large_stamp-clip_bard.png',
		"stamp-clip_lord" = 'icons/paper_graphics/stamps/large_stamp-clip_lord.png',
		"stamp-clip_land" = 'icons/paper_graphics/stamps/large_stamp-clip_land.png',
		"stamp-clip_meld" = 'icons/paper_graphics/stamps/large_stamp-clip_meld.png',
		"stamp-clip_deed" = 'icons/paper_graphics/stamps/large_stamp-clip_deed.png',
		"stamp-cybersun" = 'icons/paper_graphics/stamps/large_stamp-cybersun.png',
		"stamp-biodynamics" = 'icons/paper_graphics/stamps/large_stamp-biodynamics.png',
		"stamp-donk" = 'icons/paper_graphics/stamps/large_stamp-donk.png',
		"stamp-ngr" = 'icons/paper_graphics/stamps/large_stamp-ngr.png',
		"stamp-ngr_cap" = 'icons/paper_graphics/stamps/large_stamp-ngr_captain.png',
		"stamp-ngr_fore" = 'icons/paper_graphics/stamps/large_stamp-ngr_foreman.png',
		"stamp-ngr_lieu" = 'icons/paper_graphics/stamps/large_stamp-ngr_lieutenant.png',
		"stamp-ngr_ensign" = 'icons/paper_graphics/stamps/large_stamp-ngr_ensign.png',
		"stamp-hardliners" = 'icons/paper_graphics/stamps/large_stamp-hardliners.png',
		"stamp-nt" = 'icons/paper_graphics/stamps/large_stamp-nt_generic.png',
		"stamp-nt_cap" = 'icons/paper_graphics/stamps/large_stamp-nt_captain.png',
		"stamp-nt_fo" = 'icons/paper_graphics/stamps/large_stamp-nt_officer.png',
		"stamp-nt_engdir" = 'icons/paper_graphics/stamps/large_stamp-nt_eng_dir.png',
		"stamp-nt_meddir" = 'icons/paper_graphics/stamps/large_stamp-nt_med_dir.png',
		"stamp-nt_scidir" = 'icons/paper_graphics/stamps/large_stamp-nt_sci_dir.png',
		"stamp-ns" = 'icons/paper_graphics/stamps/large_stamp-ns_generic.png',
		"stamp-ns_cap" = 'icons/paper_graphics/stamps/large_stamp-ns_captain.png',
		"stamp-ns_supdir" = 'icons/paper_graphics/stamps/large_stamp-ns_sup_dir.png',
		"stamp-vi" = 'icons/paper_graphics/stamps/large_stamp-vi_generic.png',
		"stamp-vi_cap" = 'icons/paper_graphics/stamps/large_stamp-vi_captain.png',
		"stamp-vi_secdir" = 'icons/paper_graphics/stamps/large_stamp-vi_sec_dir.png',
		"stamp-vi_lp" = 'icons/paper_graphics/stamps/large_stamp-vi_loss_prevention.png',
		"stamp-nt_central" = 'icons/paper_graphics/stamps/large_stamp-nt_central.png',
		"food-bread" = 'icons/paper_graphics/food/bread.png',
		"food-cloth" = 'icons/paper_graphics/food/cloth.png',
		"food-cooked_meat" = 'icons/paper_graphics/food/cooked_meat.png',
		"food-dairy" = 'icons/paper_graphics/food/dairy.png',
		"food-fried" = 'icons/paper_graphics/food/fried.png',
		"food-fruit" = 'icons/paper_graphics/food/fruit.png',
		"food-raw_meat" = 'icons/paper_graphics/food/raw_meat.png',
		"food-vegetable" = 'icons/paper_graphics/food/vegetable.png',
	)

/datum/asset/simple/fuckywucky
	assets = list(
		"fuckywucky.png" = 'html/fuckywucky.png'
	)

/datum/asset/simple/IRV
	assets = list(
		"jquery-ui.custom-core-widgit-mouse-sortable-min.js" = 'html/IRV/jquery-ui.custom-core-widgit-mouse-sortable-min.js',
	)

/datum/asset/group/IRV
	children = list(
		/datum/asset/simple/jquery,
		/datum/asset/simple/IRV
	)

/datum/asset/simple/jquery
	legacy = TRUE
	assets = list(
		"jquery.min.js" = 'html/jquery.min.js',
	)

/datum/asset/simple/namespaced/fontawesome
	assets = list(
		"fa-regular-400.ttf" = 'html/font-awesome/webfonts/fa-regular-400.ttf',
		"fa-solid-900.ttf" = 'html/font-awesome/webfonts/fa-solid-900.ttf',
		"fa-v4compatibility.ttf" = 'html/font-awesome/webfonts/fa-v4compatibility.ttf',
		"v4shim.css" = 'html/font-awesome/css/v4-shims.min.css',
	)
	parents = list("font-awesome.css" = 'html/font-awesome/css/all.min.css')

/datum/asset/simple/fonts
	assets = list(
		"sga.ttf" = 'html/sga.ttf'
	)

/datum/asset/spritesheet/chat
	name = "chat"

/datum/asset/spritesheet/chat/register()
	InsertAll("emoji", EMOJI_SET)
	// pre-loading all lanugage icons also helps to avoid meta
	InsertAll("language", 'icons/misc/language.dmi')
	// catch languages which are pulling icons from another file
	for(var/path in typesof(/datum/language))
		var/datum/language/L = path
		var/icon = initial(L.icon)
		if (icon != 'icons/misc/language.dmi')
			var/icon_state = initial(L.icon_state)
			Insert("language-[icon_state]", icon, icon_state=icon_state)
		..()

/datum/asset/simple/lobby
	assets = list(
		"playeroptions.css" = 'html/browser/playeroptions.css'
	)

/datum/asset/simple/namespaced/common
	assets = list("padlock.png"	= 'html/padlock.png')
	parents = list("common.css" = 'html/browser/common.css')

/datum/asset/simple/permissions
	assets = list(
		"search.js" = 'html/admin/search.js',
		"panels.css" = 'html/admin/panels.css'
	)

/datum/asset/group/permissions
	children = list(
		/datum/asset/simple/permissions,
		/datum/asset/simple/namespaced/common
	)

/datum/asset/simple/notes
	assets = list(
		"high_button.png" = 'html/high_button.png',
		"medium_button.png" = 'html/medium_button.png',
		"minor_button.png" = 'html/minor_button.png',
		"none_button.png" = 'html/none_button.png',
	)

/datum/asset/simple/arcade
	assets = list(
		"boss1.gif" = 'icons/UI_Icons/Arcade/boss1.gif',
		"boss2.gif" = 'icons/UI_Icons/Arcade/boss2.gif',
		"boss3.gif" = 'icons/UI_Icons/Arcade/boss3.gif',
		"boss4.gif" = 'icons/UI_Icons/Arcade/boss4.gif',
		"boss5.gif" = 'icons/UI_Icons/Arcade/boss5.gif',
		"boss6.gif" = 'icons/UI_Icons/Arcade/boss6.gif',
	)

/datum/asset/spritesheet/simple/achievements
	name ="achievements"
	assets = list(
		"default" = 'icons/UI_Icons/Achievements/default.png',
		"basemisc" = 'icons/UI_Icons/Achievements/basemisc.png',
		"baseboss" = 'icons/UI_Icons/Achievements/baseboss.png',
		"baseskill" = 'icons/UI_Icons/Achievements/baseskill.png',
		"bbgum" = 'icons/UI_Icons/Achievements/Boss/bbgum.png',
		"colossus" = 'icons/UI_Icons/Achievements/Boss/colossus.png',
		"hierophant" = 'icons/UI_Icons/Achievements/Boss/hierophant.png',
		"legion" = 'icons/UI_Icons/Achievements/Boss/legion.png',
		"miner" = 'icons/UI_Icons/Achievements/Boss/miner.png',
		"tendril" = 'icons/UI_Icons/Achievements/Boss/tendril.png',
		"featofstrength" = 'icons/UI_Icons/Achievements/Misc/featofstrength.png',
		"helbital" = 'icons/UI_Icons/Achievements/Misc/helbital.png',
		"jackpot" = 'icons/UI_Icons/Achievements/Misc/jackpot.png',
		"meteors" = 'icons/UI_Icons/Achievements/Misc/meteors.png',
		"timewaste" = 'icons/UI_Icons/Achievements/Misc/timewaste.png',
		"upgrade" = 'icons/UI_Icons/Achievements/Misc/upgrade.png',
		"rule8" = 'icons/UI_Icons/Achievements/Misc/rule8.png',
		"snail" = 'icons/UI_Icons/Achievements/Misc/snail.png',
		"mining" = 'icons/UI_Icons/Achievements/Skills/mining.png',
	)

/datum/asset/spritesheet/simple/pills
	name ="pills"
	assets = list(
		"pill1" = 'icons/UI_Icons/Pills/pill1.png',
		"pill2" = 'icons/UI_Icons/Pills/pill2.png',
		"pill3" = 'icons/UI_Icons/Pills/pill3.png',
		"pill4" = 'icons/UI_Icons/Pills/pill4.png',
		"pill5" = 'icons/UI_Icons/Pills/pill5.png',
		"pill6" = 'icons/UI_Icons/Pills/pill6.png',
		"pill7" = 'icons/UI_Icons/Pills/pill7.png',
		"pill8" = 'icons/UI_Icons/Pills/pill8.png',
		"pill9" = 'icons/UI_Icons/Pills/pill9.png',
		"pill10" = 'icons/UI_Icons/Pills/pill10.png',
		"pill11" = 'icons/UI_Icons/Pills/pill11.png',
		"pill12" = 'icons/UI_Icons/Pills/pill12.png',
		"pill13" = 'icons/UI_Icons/Pills/pill13.png',
		"pill14" = 'icons/UI_Icons/Pills/pill14.png',
		"pill15" = 'icons/UI_Icons/Pills/pill15.png',
		"pill16" = 'icons/UI_Icons/Pills/pill16.png',
		"pill17" = 'icons/UI_Icons/Pills/pill17.png',
		"pill18" = 'icons/UI_Icons/Pills/pill18.png',
		"pill19" = 'icons/UI_Icons/Pills/pill19.png',
		"pill20" = 'icons/UI_Icons/Pills/pill20.png',
		"pill21" = 'icons/UI_Icons/Pills/pill21.png',
		"pill22" = 'icons/UI_Icons/Pills/pill22.png',
	)

//this exists purely to avoid meta by pre-loading all language icons.
/datum/asset/language/register()
	for(var/path in typesof(/datum/language))
		set waitfor = FALSE
		var/datum/language/L = new path ()
		L.get_icon()

/datum/asset/spritesheet/pipes
	name = "pipes"

/datum/asset/spritesheet/pipes/register()
	for (var/each in list('icons/obj/atmospherics/pipes/pipe_item.dmi', 'icons/obj/atmospherics/pipes/disposal.dmi', 'icons/obj/atmospherics/pipes/transit_tube.dmi', 'icons/obj/plumbing/fluid_ducts.dmi'))
		InsertAll("", each, GLOB.alldirs)
	..()

// Representative icons for each research design
/datum/asset/spritesheet/research_designs
	name = "design"

/datum/asset/spritesheet/research_designs/register()
	for (var/path in subtypesof(/datum/design))
		var/datum/design/D = path

		var/icon_file
		var/icon_state
		var/icon/I

		if(initial(D.research_icon) && initial(D.research_icon_state)) //If the design has an icon replacement skip the rest
			icon_file = initial(D.research_icon)
			icon_state = initial(D.research_icon_state)
			if(!(icon_state in icon_states(icon_file)))
				warning("design [D] with icon '[icon_file]' missing state '[icon_state]'")
				continue
			I = icon(icon_file, icon_state, SOUTH)

		else
			// construct the icon and slap it into the resource cache
			var/atom/item = initial(D.build_path)
			if (!ispath(item, /atom))
				// biogenerator outputs to beakers by default
				if (initial(D.build_type) & BIOGENERATOR)
					item = /obj/item/reagent_containers/glass/beaker/large
				else
					continue  // shouldn't happen, but just in case

			// circuit boards become their resulting machines or computers
			if (ispath(item, /obj/item/circuitboard))
				var/obj/item/circuitboard/C = item
				var/machine = initial(C.build_path)
				if (machine)
					item = machine

			icon_file = initial(item.icon)
			icon_state = initial(item.icon_state)

			if(!(icon_state in icon_states(icon_file)))
				warning("design [D] with icon '[icon_file]' missing state '[icon_state]'")
				continue
			I = icon(icon_file, icon_state, SOUTH)

			// computers get their screen and keyboard sprites
			if (ispath(item, /obj/machinery/computer))
				var/obj/machinery/computer/C = item
				var/screen = initial(C.icon_screen)
				var/keyboard = initial(C.icon_keyboard)
				var/all_states = icon_states(icon_file)
				if (screen && (screen in all_states))
					I.Blend(icon(icon_file, screen, SOUTH), ICON_OVERLAY)
				if (keyboard && (keyboard in all_states))
					I.Blend(icon(icon_file, keyboard, SOUTH), ICON_OVERLAY)

		Insert(initial(D.id), I)
	return ..()

/datum/asset/spritesheet/vending
	name = "vending"

/datum/asset/spritesheet/vending/register()
	var/list/vendor_type_list = typesof(/obj/machinery/vending)
	var/list/vending_products = list()

	for(var/vendor_type in vendor_type_list)
		var/obj/machinery/vending/V = new vendor_type()
		if (V.products)
			for(var/typepath in V.products)
				vending_products[typepath] = 1
		if (V.contraband)
			for(var/typepath in V.contraband)
				vending_products[typepath] = 1
		if (V.premium)
			for(var/typepath in V.premium)
				vending_products[typepath] = 1
		qdel(V)

	for (var/k in vending_products)
		var/atom/item = k
		if (!ispath(item, /atom))
			continue

		var/icon_file = initial(item.icon)
		var/icon_state = initial(item.icon_state)
		var/icon/I

		var/icon_states_list = icon_states(icon_file)
		if(icon_state in icon_states_list)
			I = icon(icon_file, icon_state, SOUTH)
			var/c = initial(item.color)
			if (!isnull(c) && c != "#FFFFFF")
				I.Blend(c, ICON_MULTIPLY)
		else
			var/icon_states_string
			for (var/an_icon_state in icon_states_list)
				if (!icon_states_string)
					icon_states_string = "[json_encode(an_icon_state)](\ref[an_icon_state])"
				else
					icon_states_string += ", [json_encode(an_icon_state)](\ref[an_icon_state])"
			stack_trace("[item] does not have a valid icon state, icon=[icon_file], icon_state=[json_encode(icon_state)](\ref[icon_state]), icon_states=[icon_states_string]")
			I = icon('icons/turf/floors.dmi', "", SOUTH)

		var/imgid = replacetext(replacetext("[item]", "/obj/item/", ""), "/", "-")

		Insert(imgid, I)
	return ..()

/datum/asset/simple/genetics
	assets = list(
		"dna_discovered.gif" = 'html/dna_discovered.gif',
		"dna_undiscovered.gif" = 'html/dna_undiscovered.gif',
		"dna_extra.gif" = 'html/dna_extra.gif'
	)

/datum/asset/simple/orbit
	assets = list(
		"ghost.png"	= 'html/ghost.png'
	)

/datum/asset/simple/vv
	assets = list(
		"view_variables.css" = 'html/admin/view_variables.css'
	)

/datum/asset/simple/safe
	assets = list(
		"safe_dial.png" = 'html/safe_dial.png'
	)

/datum/asset/simple/pai
	assets = list(
		"paigrid.png" = 'html/paigrid.png'
	)

/datum/asset/spritesheet/fish
	name = "fish"

/datum/asset/spritesheet/fish/register()
	for(var/path in subtypesof(/obj/item/fish))
		var/obj/item/fish/fish_type = path
		var/fish_icon = initial(fish_type.icon)
		var/fish_icon_state = initial(fish_type.icon_state)
		var/id = sanitize_css_class_name("[fish_icon][fish_icon_state]")
		if(sprites[id]) //no dupes
			continue
		Insert(id, fish_icon, fish_icon_state)


/datum/asset/simple/fishing_minigame
	assets = list(
		"fishing_background_default" = 'icons/ui_icons/fishing/default.png',
		"fishing_background_lavaland" = 'icons/ui_icons/fishing/lavaland.png'
	)

/datum/asset/spritesheet/supplypods
	name = "supplypods"

/datum/asset/spritesheet/supplypods/register()
	for (var/style in 1 to length(GLOB.podstyles))
		var/icon_file = 'icons/obj/supplypods.dmi'
		var/states = icon_states(icon_file)
		if (style == STYLE_SEETHROUGH)
			Insert("pod_asset[style]", icon(icon_file, "seethrough-icon", SOUTH))
			continue
		var/base = GLOB.podstyles[style][POD_BASE]
		if (!base)
			Insert("pod_asset[style]", icon(icon_file, "invisible-icon", SOUTH))
			continue
		var/icon/podIcon = icon(icon_file, base, SOUTH)
		var/door = GLOB.podstyles[style][POD_DOOR]
		if (door)
			door = "[base]_door"
			if(door in states)
				podIcon.Blend(icon(icon_file, door, SOUTH), ICON_OVERLAY)
		var/shape = GLOB.podstyles[style][POD_SHAPE]
		if (shape == POD_SHAPE_NORML)
			var/decal = GLOB.podstyles[style][POD_DECAL]
			if (decal)
				if(decal in states)
					podIcon.Blend(icon(icon_file, decal, SOUTH), ICON_OVERLAY)
			var/glow = GLOB.podstyles[style][POD_GLOW]
			if (glow)
				glow = "pod_glow_[glow]"
				if(glow in states)
					podIcon.Blend(icon(icon_file, glow, SOUTH), ICON_OVERLAY)
		Insert("pod_asset[style]", podIcon)
	return ..()
