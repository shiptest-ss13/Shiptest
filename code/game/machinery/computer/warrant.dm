/obj/machinery/computer/warrant//TODO:SANITY
	name = "security warrant console"
	desc = "Used to view crewmember security records"
	icon_screen = "security"
	icon_keyboard = "security_key"
	circuit = /obj/item/circuitboard/computer/warrant
	light_color = COLOR_SOFT_RED
	var/screen = null
	var/datum/data/record/current = null

/obj/machinery/computer/warrant/ui_interact(mob/user)
	. = ..()

	var/list/dat = list("Logged in as: ")
	if(authenticated)
		dat += {"<a href='?src=[REF(src)];choice=Logout'>[authenticated]</a><hr>"}
		if(current)
			var/background
			var/notice = ""
			switch(current.fields["criminal"])
				if("*Arrest*")
					background = "background-color:#990000;"
					notice = "<br>**REPORT TO THE BRIG**"
				if("Incarcerated")
					background = "background-color:#CD6500;"
				if("Paroled")
					background = "background-color:#CD6500;"
				if("Discharged")
					background = "background-color:#006699;"
				if("None")
					background = "background-color:#4F7529;"
				if("")
					background = "''" //"'background-color:#FFFFFF;'"
			dat += "<font size='4'><b>Warrant Data</b></font>"
			dat += {"<table>
			<tr><td>Name:</td><td>&nbsp;[current.fields["name"]]&nbsp;</td></tr>
			<tr><td>ID:</td><td>&nbsp;[current.fields["id"]]&nbsp;</td></tr>
			</table>"}
			dat += {"Criminal Status:<br>
			<div style='[background] padding: 3px; text-align: center;'>
			<strong>[current.fields["criminal"]][notice]</strong>
			</div>"}

			dat += "<br>Crimes:"
			dat +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
			<tr>
			<th>Crime</th>
			<th>Details</th>
			<th>Author</th>
			<th>Time Added</th>
			</tr>"}
			for(var/datum/data/crime/c in current.fields["crim"])
				dat += {"<tr><td>[c.crimeName]</td>
				<td>[c.crimeDetails]</td>
				<td>[c.author]</td>
				<td>[c.time]</td>
				</tr>"}
			dat += "</table>"
		else
			dat += {"<span>** No security record found for this ID **</span>"}
	else
		dat += {"<a href='?src=[REF(src)];choice=Login'>------------</a><hr>"}

	var/datum/browser/popup = new(user, "warrant", "Security Warrant Console", 600, 400)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/computer/warrant/Topic(href, href_list)
	if(..())
		return
	var/mob/M = usr
	switch(href_list["choice"])
		if("Login")
			var/obj/item/card/id/scan = M.get_idcard(TRUE)
			authenticated = scan.registered_name
			if(authenticated)
				for(var/datum/data/record/R in GLOB.data_core.security)
					if(R.fields["name"] == authenticated)
						current = R
				playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)
		if("Logout")
			current = null
			authenticated = null
			playsound(src, 'sound/machines/terminal_off.ogg', 50, FALSE)

	updateUsrDialog()
	add_fingerprint(M)
