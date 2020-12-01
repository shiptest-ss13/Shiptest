/client/verb/show_station_minimap()
	set category = "OOC"
	set name = "Show Station Minimap"
	set desc = "Shows a minimap of the currently loaded station map."

	if(!CONFIG_GET(flag/minimaps_enabled))
		to_chat(usr, "<span class='boldwarning'>Minimap generation is not enabled in the server's configuration.</span>")
		return
	if(!SSminimaps.station_minimap)
		to_chat(usr, "<span class='boldwarning'>Minimap generation is in progress, please wait!</span>")
		return
	SSminimaps.station_minimap.show(src)
