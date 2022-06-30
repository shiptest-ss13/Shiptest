/obj/machinery/button
	icon = 'starbloom_modules/aesthetics/buttons/icons/buttons.dmi'
	var/light_mask = "button-light-mask"

/obj/machinery/button/door/update_overlays()
	. = ..()
	if(!light_mask)
		return

	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!(machine_stat & (NOPOWER|BROKEN)) && !panel_open)
		SSvis_overlays.add_vis_overlay(src, icon, light_mask, 0, EMISSIVE_PLANE)
