/obj/machinery/computer/record/sec//TODO:SANITY
	name = "security records console"
	desc = "Used to view and edit personnel's security records."
	icon_screen = "security"
	icon_keyboard = "security_key"
	req_one_access = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)
	circuit = /obj/item/circuitboard/computer/secure_data
	light_color = COLOR_SOFT_RED
	var/can_change_id = 0
	var/list/Perp
	var/tempname = null

/obj/machinery/computer/record/sec/syndie
	icon_keyboard = "syndie_key"

/obj/machinery/computer/record/sec/laptop
	name = "security laptop"
	desc = "A cheap Nanotrasen security laptop, it functions as a security records console. It's bolted to the table."
	icon_state = "laptop"
	icon_screen = "seclaptop"
	icon_keyboard = "laptop_key"
	pass_flags = PASSTABLE
	unique_icon = TRUE

//Someone needs to break down the dat += into chunks instead of long ass lines.
/obj/machinery/computer/record/sec/ui_interact(mob/user)
	. = ..()
	if(isliving(user))
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
	if(src.z > 6)
		to_chat(user, "<span class='boldannounce'>Unable to establish a connection</span>: \black You're too far away from the station!")
		return
	var/dat

	if(temp)
		dat = "<TT>[temp]</TT><BR><BR><A href='?src=[REF(src)];choice=Clear Screen'>Clear Screen</A>"
	else
		dat = ""
		if(authenticated)
			switch(screen)
				if(1)

					//body tag start + onload and onkeypress (onkeyup) javascript event calls
					dat += "<body onload='selectTextField(); updateSearch();' onkeyup='updateSearch();'>"
					//search bar javascript
					dat += {"

		<head>
			<script src="[SSassets.transport.get_asset_url("jquery.min.js")]"></script>
			<script type='text/javascript'>

				function updateSearch(){
					var filter_text = document.getElementById('filter');
					var filter = filter_text.value.toLowerCase();

					if(complete_list != null && complete_list != ""){
						var mtbl = document.getElementById("maintable_data_archive");
						mtbl.innerHTML = complete_list;
					}

					if(filter.value == ""){
						return;
					}else{
						$("#maintable_data").children("tbody").children("tr").children("td").children("input").filter(function(index)
						{
							return $(this)\[0\].value.toLowerCase().indexOf(filter) == -1
						}).parent("td").parent("tr").hide()
					}
				}

				function selectTextField(){
					var filter_text = document.getElementById('filter');
					filter_text.focus();
					filter_text.select();
				}

			</script>
		</head>


	"}
					dat += {"
<p style='text-align:center;'>"}
					dat += "<A href='?src=[REF(src)];choice=New Record (General)'>New Record</A><BR>"
					//search bar
					dat += {"
						<table width='560' align='center' cellspacing='0' cellpadding='5' id='maintable'>
							<tr id='search_tr'>
								<td align='center'>
									<b>Search:</b> <input type='text' id='filter' value='' style='width:300px;'>
								</td>
							</tr>
						</table>
					"}
					dat += {"
</p>
<table style="text-align:center;" cellspacing="0" width="100%">
<tr>
<th>Records:</th>
</tr>
</table>

<span id='maintable_data_archive'>
<table id='maintable_data' style="text-align:center;" border="1" cellspacing="0" width="100%">
<tr>
<th><A href='?src=[REF(src)];choice=Sorting;sort=name'>Name</A></th>
<th><A href='?src=[REF(src)];choice=Sorting;sort=id'>ID</A></th>
<th><A href='?src=[REF(src)];choice=Sorting;sort=rank'>Rank</A></th>
<th><A href='?src=[REF(src)];choice=Sorting;sort=fingerprint'>Fingerprints</A></th>
<th>Criminal Status</th>
</tr>"}
					if(!isnull(SSdatacore.get_records(DATACORE_RECORDS_OUTPOST)))
						for(var/datum/data/record/R in sortRecord(SSdatacore.get_records(DATACORE_RECORDS_OUTPOST), sortBy, order))
							var/crimstat = ""
							for(var/datum/data/record/E in SSdatacore.get_records(DATACORE_RECORDS_SECURITY))
								if((E.fields[DATACORE_NAME] == R.fields[DATACORE_NAME]) && (E.fields[DATACORE_ID] == R.fields[DATACORE_ID]))
									crimstat = E.fields[DATACORE_CRIMINAL_STATUS]
							var/background
							switch(crimstat)
								if("*Arrest*")
									background = "'background-color:#990000;'"
								if("Incarcerated")
									background = "'background-color:#CD6500;'"
								if("Paroled")
									background = "'background-color:#CD6500;'"
								if("Discharged")
									background = "'background-color:#006699;'"
								if("None")
									background = "'background-color:#4F7529;'"
								if("")
									background = "''" //"'background-color:#FFFFFF;'"
									crimstat = "No Record."
							dat += "<tr style=[background]>"
							dat += text("<td><input type='hidden' value='[] [] [] []'></input><A href='?src=[REF(src)];choice=Browse Record;d_rec=[REF(R)]'>[]</a></td>", R.fields[DATACORE_NAME], R.fields[DATACORE_ID], R.fields[DATACORE_RANK], R.fields[DATACORE_FINGERPRINT], R.fields[DATACORE_NAME])
							dat += text("<td>[]</td>", R.fields[DATACORE_ID])
							dat += text("<td>[]</td>", R.fields[DATACORE_RANK])
							dat += text("<td>[]</td>", R.fields[DATACORE_FINGERPRINT])
							dat += text("<td>[]</td></tr>", crimstat)
						dat += {"
						</table></span>
						<script type='text/javascript'>
							var maintable = document.getElementById("maintable_data_archive");
							var complete_list = maintable.innerHTML;
						</script>
						<hr width='75%' />"}
					dat += "<A href='?src=[REF(src)];choice=Record Maintenance'>Record Maintenance</A><br><br>"
					dat += "<A href='?src=[REF(src)];choice=Log Out'>{Log Out}</A>"
				if(2)
					dat += "<B>Records Maintenance</B><HR>"
					dat += "<BR><A href='?src=[REF(src)];choice=Delete All Records'>Delete All Records</A><BR><BR><A href='?src=[REF(src)];choice=Return'>Back</A>"
				if(3)
					dat += "<font size='4'><b>Security Record</b></font><br>"
					if(istype(active1, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_OUTPOST).Find(active1))
						var/front_photo = active1.get_front_photo()
						if(istype(front_photo, /obj/item/photo))
							var/obj/item/photo/photo_front = front_photo
							user << browse_rsc(photo_front.picture.picture_image, "photo_front")
						var/side_photo = active1.get_side_photo()
						if(istype(side_photo, /obj/item/photo))
							var/obj/item/photo/photo_side = side_photo
							user << browse_rsc(photo_side.picture.picture_image, "photo_side")
						dat += {"<table><tr><td><table>
						<tr><td>Name:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=name'>&nbsp;[active1.fields[DATACORE_NAME]]&nbsp;</A></td></tr>
						<tr><td>ID:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=id'>&nbsp;[active1.fields[DATACORE_ID]]&nbsp;</A></td></tr>
						<tr><td>Gender:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=gender'>&nbsp;[active1.fields[DATACORE_GENDER]]&nbsp;</A></td></tr>
						<tr><td>Age:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=age'>&nbsp;[active1.fields[DATACORE_AGE]]&nbsp;</A></td></tr>"}
						dat += "<tr><td>Species:</td><td><A href ='?src=[REF(src)];choice=Edit Field;field=species'>&nbsp;[active1.fields[DATACORE_SPECIES]]&nbsp;</A></td></tr>"
						dat += {"<tr><td>Rank:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=rank'>&nbsp;[active1.fields[DATACORE_RANK]]&nbsp;</A></td></tr>
						<tr><td>Fingerprint:</td><td><A href='?src=[REF(src)];choice=Edit Field;field=fingerprint'>&nbsp;[active1.fields[DATACORE_FINGERPRINT]]&nbsp;</A></td></tr>
						<tr><td>Physical Status:</td><td>&nbsp;[active1.fields[DATACORE_PHYSICAL_HEALTH]]&nbsp;</td></tr>
						<tr><td>Mental Status:</td><td>&nbsp;[active1.fields[DATACORE_MENTAL_HEALTH]]&nbsp;</td></tr>
						</table></td>
						<td><table><td align = center><a href='?src=[REF(src)];choice=Edit Field;field=show_photo_front'><img src=photo_front height=80 width=80 border=4></a><br>
						<a href='?src=[REF(src)];choice=Edit Field;field=print_photo_front'>Print photo</a><br>
						<a href='?src=[REF(src)];choice=Edit Field;field=upd_photo_front'>Update front photo</a></td>
						<td align = center><a href='?src=[REF(src)];choice=Edit Field;field=show_photo_side'><img src=photo_side height=80 width=80 border=4></a><br>
						<a href='?src=[REF(src)];choice=Edit Field;field=print_photo_side'>Print photo</a><br>
						<a href='?src=[REF(src)];choice=Edit Field;field=upd_photo_side'>Update side photo</a></td></table>
						</td></tr></table></td></tr></table>"}
					else
						dat += "<br>General Record Lost!<br>"
					if((istype(active2, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_SECURITY).Find(active2)))
						dat += "<font size='4'><b>Security Data</b></font>"
						dat += "<br>Criminal Status: <A href='?src=[REF(src)];choice=Edit Field;field=criminal'>[active2.fields[DATACORE_CRIMINAL_STATUS]]</A>"

						dat += "<br><br>Crimes: <A href='?src=[REF(src)];choice=Edit Field;field=crim_add'>Add New</A>"

						dat +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
						<tr>
						<th>Crime</th>
						<th>Details</th>
						<th>Author</th>
						<th>Time Added</th>
						<th>Del</th>
						</tr>"}
						for(var/datum/data/crime/c in active2.fields[DATACORE_CRIMES])
							dat += "<tr><td>[c.crimeName]</td>"
							if(!c.crimeDetails)
								dat += "<td><A href='?src=[REF(src)];choice=Edit Field;field=add_details;cdataid=[c.dataId]'>\[+\]</A></td>"
							else
								dat += "<td>[c.crimeDetails]</td>"
							dat += "<td>[c.author]</td>"
							dat += "<td>[c.time]</td>"
							dat += "<td><A href='?src=[REF(src)];choice=Edit Field;field=crim_delete;cdataid=[c.dataId]'>\[X\]</A></td>"
							dat += "</tr>"
						dat += "</table>"

						dat += "<br>\nImportant Notes:<br>\n\t<A href='?src=[REF(src)];choice=Edit Field;field=notes'>&nbsp;[active2.fields[DATACORE_NOTES]]&nbsp;</A>"
						dat += "<br><br><font size='4'><b>Comments/Log</b></font><br>"
						var/counter = 1
						while(active2.fields[text("com_[]", counter)])
							dat += (active2.fields[text("com_[]", counter)] + "<BR>")
							if(active2.fields[text("com_[]", counter)] != "<B>Deleted</B>")
								dat += text("<A href='?src=[REF(src)];choice=Delete Entry;del_c=[]'>Delete Entry</A><BR><BR>", counter)
							counter++
						dat += "<A href='?src=[REF(src)];choice=Add Entry'>Add Entry</A><br><br>"
						dat += "<A href='?src=[REF(src)];choice=Delete Record (Security)'>Delete Record (Security Only)</A><br>"
					else
						dat += "Security Record Lost!<br>"
						dat += "<A href='?src=[REF(src)];choice=New Record (Security)'>New Security Record</A><br><br>"
					dat += "<A href='?src=[REF(src)];choice=Delete Record (ALL)'>Delete Record (ALL)</A><br><A href='?src=[REF(src)];choice=Print Record'>Print Record</A><BR><A href='?src=[REF(src)];choice=Print Poster'>Print Wanted Poster</A><BR><A href='?src=[REF(src)];choice=Print Missing'>Print Missing Persons Poster</A><BR><A href='?src=[REF(src)];choice=Return'>Back</A><BR><BR>"
					dat += "<A href='?src=[REF(src)];choice=Log Out'>{Log Out}</A>"
				else
		else
			dat += "<A href='?src=[REF(src)];choice=Log In'>{Log In}</A>"
	var/datum/browser/popup = new(user, "secure_rec", "Security Records Console", 600, 400)
	popup.set_content(dat)
	popup.open()
	return

/*Revised /N
I can't be bothered to look more of the actual code outside of switch but that probably needs revising too.
What a mess.*/
/obj/machinery/computer/record/sec/Topic(href, href_list)
	. = ..()
	if(.)
		return .
	if(!(SSdatacore.get_records(DATACORE_RECORDS_OUTPOST).Find(active1)))
		active1 = null
	if(!(SSdatacore.get_records(DATACORE_RECORDS_SECURITY).Find(active2)))
		active2 = null
	if(usr.contents.Find(src) || (in_range(src, usr) && isturf(loc)) || issilicon(usr) || isAdminGhostAI(usr))
		usr.set_machine(src)
		switch(href_list["choice"])
// SORTING!
			if("Sorting")
				// Reverse the order if clicked twice
				if(sortBy == href_list["sort"])
					if(order == 1)
						order = -1
					else
						order = 1
				else
				// New sorting order!
					sortBy = href_list["sort"]
					order = initial(order)
//BASIC FUNCTIONS
			if("Clear Screen")
				temp = null

			if("Return")
				screen = 1
				active1 = null
				active2 = null

			if("Log Out")
				authenticated = null
				screen = null
				active1 = null
				active2 = null
				playsound(src, 'sound/machines/terminal_off.ogg', 50, FALSE)

			if("Log In")
				var/mob/M = usr
				var/obj/item/card/id/I = M.get_idcard(TRUE)
				if(issilicon(M))
					var/mob/living/silicon/borg = M
					active1 = null
					active2 = null
					authenticated = borg.name
					rank = "AI"
					screen = 1
				else if(isAdminGhostAI(M))
					active1 = null
					active2 = null
					authenticated = M.client.holder.admin_signature
					rank = "Central Command"
					screen = 1
				else if(I && check_access(I))
					active1 = null
					active2 = null
					authenticated = I.registered_name
					rank = I.assignment
					screen = 1
				else
					to_chat(usr, "<span class='danger'>Unauthorized Access.</span>")
				playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)

//RECORD FUNCTIONS
			if("Record Maintenance")
				screen = 2
				active1 = null
				active2 = null

			if("Browse Record")
				var/datum/data/record/R = locate(href_list["d_rec"]) in SSdatacore.get_records(DATACORE_RECORDS_OUTPOST)
				if(!R)
					temp = "Record Not Found!"
				else
					active1 = active2 = R
					for(var/datum/data/record/E in SSdatacore.get_records(DATACORE_RECORDS_SECURITY))
						if((E.fields[DATACORE_NAME] == R.fields[DATACORE_NAME] || E.fields[DATACORE_ID] == R.fields[DATACORE_ID]))
							active2 = E
					screen = 3

			if("Print Record")
				if(!(printing))
					printing = 1
					SSdatacore.securityPrintCount++
					playsound(loc, 'sound/items/poster_being_created.ogg', 100, TRUE)
					sleep(30)
					var/obj/item/paper/printed_paper = new /obj/item/paper(loc)
					var/final_paper_text = "<CENTER><B>Security Record - (SR-[SSdatacore.securityPrintCount])</B></CENTER><BR>"
					if((istype(active1, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_OUTPOST).Find(active1)))
						final_paper_text += text("Name: [] ID: []<BR>\nGender: []<BR>\nAge: []<BR>", active1.fields[DATACORE_NAME], active1.fields[DATACORE_ID], active1.fields[DATACORE_GENDER], active1.fields[DATACORE_AGE])
						final_paper_text += "\nSpecies: [active1.fields[DATACORE_SPECIES]]<BR>"
						final_paper_text += text("\nFingerprint: []<BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", active1.fields[DATACORE_FINGERPRINT], active1.fields[DATACORE_PHYSICAL_HEALTH], active1.fields[DATACORE_MENTAL_HEALTH])
					else
						final_paper_text += "<B>General Record Lost!</B><BR>"
					if((istype(active2, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_SECURITY).Find(active2)))
						final_paper_text += text("<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: []", active2.fields[DATACORE_CRIMINAL_STATUS])

						final_paper_text += "<BR>\n<BR>\nCrimes:<BR>\n"
						final_paper_text +={"<table style="text-align:center;" border="1" cellspacing="0" width="100%">
<tr>
<th>Crime</th>
<th>Details</th>
<th>Author</th>
<th>Time Added</th>
</tr>"}
						for(var/datum/data/crime/c in active2.fields[DATACORE_CRIMES])
							final_paper_text += "<tr><td>[c.crimeName]</td>"
							final_paper_text += "<td>[c.crimeDetails]</td>"
							final_paper_text += "<td>[c.author]</td>"
							final_paper_text += "<td>[c.time]</td>"
							final_paper_text += "</tr>"
						final_paper_text += "</table>"

						final_paper_text += text("<BR>\nImportant Notes:<BR>\n\t[]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", active2.fields[DATACORE_NOTES])
						var/counter = 1
						while(active2.fields[text("com_[]", counter)])
							final_paper_text += text("[]<BR>", active2.fields[text("com_[]", counter)])
							counter++
						printed_paper.name = text("SR-[] '[]'", SSdatacore.securityPrintCount, active1.fields[DATACORE_NAME])
					else
						final_paper_text += "<B>Security Record Lost!</B><BR>"
						printed_paper.name = text("SR-[] '[]'", SSdatacore.securityPrintCount, "Record Lost")
					final_paper_text += "</TT>"
					printed_paper.add_raw_text(final_paper_text)
					printed_paper.update_appearance()
					printing = null
			if("Print Poster")
				if(!(printing))
					var/wanted_name = stripped_input(usr, "Please enter an alias for the criminal:", "Print Wanted Poster", active1.fields[DATACORE_NAME])
					if(wanted_name)
						var/default_description = "A poster declaring [wanted_name] to be a dangerous individual, wanted by Nanotrasen. Report any sightings to security immediately."
						var/list/crimes = active2.fields[DATACORE_CRIMES]
						if(crimes.len)
							default_description += "\n[wanted_name] is wanted for the following crimes:\n"
							for(var/datum/data/crime/c in active2.fields[DATACORE_CRIMES])
								default_description += "\n[c.crimeName]\n"
								default_description += "[c.crimeDetails]\n"

						var/headerText = stripped_input(usr, "Please enter Poster Heading (Max 7 Chars):", "Print Wanted Poster", "WANTED", 8)

						var/info = stripped_multiline_input(usr, "Please input a description for the poster:", "Print Wanted Poster", default_description, null)
						if(info)
							playsound(loc, 'sound/items/poster_being_created.ogg', 100, TRUE)
							printing = 1
							sleep(30)
							if((istype(active1, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_OUTPOST).Find(active1)))//make sure the record still exists.
								var/obj/item/photo/photo = active1.get_front_photo()
								new /obj/item/poster/wanted(loc, photo.picture.picture_image, wanted_name, info, headerText)
							printing = 0
			if("Print Missing")
				if(!(printing))
					var/missing_name = stripped_input(usr, "Please enter an alias for the missing person:", "Print Missing Persons Poster", active1.fields[DATACORE_NAME])
					if(missing_name)
						var/default_description = "A poster declaring [missing_name] to be a missing individual, missed by Nanotrasen. Report any sightings to security immediately."

						var/headerText = stripped_input(usr, "Please enter Poster Heading (Max 7 Chars):", "Print Missing Persons Poster", "MISSING", 8)

						var/info = stripped_multiline_input(usr, "Please input a description for the poster:", "Print Missing Persons Poster", default_description, null)
						if(info)
							playsound(loc, 'sound/items/poster_being_created.ogg', 100, TRUE)
							printing = 1
							sleep(30)
							if((istype(active1, /datum/data/record) && SSdatacore.get_records(DATACORE_RECORDS_OUTPOST).Find(active1)))//make sure the record still exists.
								var/obj/item/photo/photo = active1.get_front_photo()
								new /obj/item/poster/wanted/missing(loc, photo.picture.picture_image, missing_name, info, headerText)
							printing = 0

//RECORD DELETE
			if("Delete All Records")
				temp = ""
				temp += "Are you sure you wish to delete all Security records?<br>"
				temp += "<a href='?src=[REF(src)];choice=Purge All Records'>Yes</a><br>"
				temp += "<a href='?src=[REF(src)];choice=Clear Screen'>No</a>"

			if("Purge All Records")
				investigate_log("[key_name(usr)] has purged all the security records.", INVESTIGATE_RECORDS)
				for(var/datum/data/record/R in SSdatacore.get_records(DATACORE_RECORDS_SECURITY))
					qdel(R)
				SSdatacore.wipe_records(DATACORE_RECORDS_SECURITY)
				temp = "All Security records deleted."

			if("Add Entry")
				if(!(istype(active2, /datum/data/record)))
					return
				var/a2 = active2
				var/t1 = stripped_multiline_input("Add Comment:", "Secure. records", null, null)
				if(!can_use_record_console(usr, t1, null, a2))
					return
				var/counter = 1
				while(active2.fields[text("com_[]", counter)])
					counter++
				active2.fields[text("com_[]", counter)] = text("Made by [] ([]) on [], []<BR>[]", src.authenticated, src.rank, station_time_timestamp(), sector_datestamp(shortened = TRUE), t1)

			if("Delete Record (ALL)")
				if(active1)
					temp = "<h5>Are you sure you wish to delete the record (ALL)?</h5>"
					temp += "<a href='?src=[REF(src)];choice=Delete Record (ALL) Execute'>Yes</a><br>"
					temp += "<a href='?src=[REF(src)];choice=Clear Screen'>No</a>"

			if("Delete Record (Security)")
				if(active2)
					temp = "<h5>Are you sure you wish to delete the record (Security Portion Only)?</h5>"
					temp += "<a href='?src=[REF(src)];choice=Delete Record (Security) Execute'>Yes</a><br>"
					temp += "<a href='?src=[REF(src)];choice=Clear Screen'>No</a>"

			if("Delete Entry")
				if((istype(active2, /datum/data/record) && active2.fields[text("com_[]", href_list["del_c"])]))
					active2.fields[text("com_[]", href_list["del_c"])] = "<B>Deleted</B>"
//RECORD CREATE
			if("New Record (Security)")
				if((istype(active1, /datum/data/record) && !(istype(active2, /datum/data/record))))
					var/datum/data/record/R = new /datum/data/record()
					R.fields[DATACORE_NAME] = active1.fields[DATACORE_NAME]
					R.fields[DATACORE_ID] = active1.fields[DATACORE_ID]
					R.name = text("Security Record #[]", R.fields[DATACORE_ID])
					R.fields[DATACORE_CRIMINAL_STATUS] = "None"
					R.fields[DATACORE_CRIMES] = list()
					R.fields[DATACORE_NOTES] = "No notes."
					SSdatacore.inject_record(R, DATACORE_RECORDS_SECURITY)
					active2 = R
					screen = 3

			if("New Record (General)")
				//General Record
				var/datum/data/record/G = new /datum/data/record()
				G.fields[DATACORE_NAME] = "New Record"
				G.fields[DATACORE_ID] = "[num2hex(rand(1, 1.6777215E7), 6)]"
				G.fields[DATACORE_RANK] = "Unassigned"
				G.fields[DATACORE_GENDER] = "Male"
				G.fields[DATACORE_AGE] = "Unknown"
				G.fields[DATACORE_SPECIES] = "Human"
				G.fields[DATACORE_FINGERPRINT] = "?????"
				G.fields[DATACORE_PHYSICAL_HEALTH] = "Active"
				G.fields[DATACORE_MENTAL_HEALTH] = "Stable"
				SSdatacore.inject_record(G, DATACORE_RECORDS_OUTPOST)
				active1 = G

				//Security Record
				var/datum/data/record/R = new /datum/data/record()
				R.fields[DATACORE_NAME] = active1.fields[DATACORE_NAME]
				R.fields[DATACORE_ID] = active1.fields[DATACORE_ID]
				R.name = text("Security Record #[]", R.fields[DATACORE_ID])
				R.fields[DATACORE_CRIMINAL_STATUS] = "None"
				R.fields[DATACORE_CRIMES] = list()
				R.fields[DATACORE_NOTES] = "No notes."
				SSdatacore.inject_record(R, DATACORE_RECORDS_SECURITY)
				active2 = R

				//Medical Record
				var/datum/data/record/M = new /datum/data/record()
				M.fields[DATACORE_ID]			= active1.fields[DATACORE_ID]
				M.fields[DATACORE_NAME]		= active1.fields[DATACORE_NAME]
				M.fields[DATACORE_BLOOD_TYPE]	= "?"
				M.fields[DATACORE_BLOOD_DNA]		= "?????"
				M.fields["mi_dis"]		= "None"
				M.fields["mi_dis_d"]	= "No minor disabilities have been declared."
				M.fields[DATACORE_DISABILITIES]		= "None"
				M.fields[DATACORE_DISABILITIES_DETAILS]	= "No major disabilities have been diagnosed."
				M.fields["alg"]			= "None"
				M.fields["alg_d"]		= "No allergies have been detected in this patient."
				M.fields[DATACORE_DISEASES]			= "None"
				M.fields[DATACORE_DISEASES_DETAILS]		= "No diseases have been diagnosed at the moment."
				M.fields[DATACORE_NOTES]		= "No notes."
				SSdatacore.inject_record(M, DATACORE_RECORDS_MEDICAL)



//FIELD FUNCTIONS
			if("Edit Field")
				var/a1 = active1
				var/a2 = active2

				switch(href_list["field"])
					if("name")
						if(istype(active1, /datum/data/record) || istype(active2, /datum/data/record))
							var/t1 = stripped_input(usr, "Please input name:", "Secure. records", active1.fields[DATACORE_NAME], MAX_MESSAGE_LEN)
							if(!can_use_record_console(usr, t1, a1))
								return
							if(istype(active1, /datum/data/record))
								active1.fields[DATACORE_NAME] = t1
							if(istype(active2, /datum/data/record))
								active2.fields[DATACORE_NAME] = t1
					if("id")
						if(istype(active2, /datum/data/record) || istype(active1, /datum/data/record))
							var/t1 = stripped_input(usr, "Please input id:", "Secure. records", active1.fields[DATACORE_ID], null)
							if(!can_use_record_console(usr, t1, a1))
								return
							if(istype(active1, /datum/data/record))
								active1.fields[DATACORE_ID] = t1
							if(istype(active2, /datum/data/record))
								active2.fields[DATACORE_ID] = t1
					if("fingerprint")
						if(istype(active1, /datum/data/record))
							var/t1 = stripped_input(usr, "Please input fingerprint hash:", "Secure. records", active1.fields[DATACORE_FINGERPRINT], null)
							if(!can_use_record_console(usr, t1, a1))
								return
							active1.fields[DATACORE_FINGERPRINT] = t1
					if("gender")
						if(istype(active1, /datum/data/record))
							if(active1.fields[DATACORE_GENDER] == "Male")
								active1.fields[DATACORE_GENDER] = "Female"
							else if(active1.fields[DATACORE_GENDER] == "Female")
								active1.fields[DATACORE_GENDER] = "Other"
							else
								active1.fields[DATACORE_GENDER] = "Male"
					if("age")
						if(istype(active1, /datum/data/record))
							var/t1 = input("Please input age:", "Secure. records", active1.fields[DATACORE_AGE], null) as num|null

							if (!t1)
								return

							if(!can_use_record_console(usr, "age", a1))
								return
							active1.fields[DATACORE_AGE] = t1
					if("species")
						if(istype(active1, /datum/data/record))
							var/t1 = input("Select a species", "Species Selection") as null|anything in GLOB.roundstart_races
							if(!can_use_record_console(usr, t1, a1))
								return
							active1.fields[DATACORE_SPECIES] = t1
					if("show_photo_front")
						if(active1)
							var/front_photo = active1.get_front_photo()
							if(istype(front_photo, /obj/item/photo))
								var/obj/item/photo/photo = front_photo
								photo.show(usr)
					if("upd_photo_front")
						var/obj/item/photo/photo = get_photo(usr)
						if(photo)
							qdel(active1.fields["photo_front"])
							//Lets center it to a 32x32.
							var/icon/I = photo.picture.picture_image
							var/w = I.Width()
							var/h = I.Height()
							var/dw = w - 32
							var/dh = w - 32
							I.Crop(dw/2, dh/2, w - dw/2, h - dh/2)
							active1.fields["photo_front"] = photo
							investigate_log("[key_name(usr)] updated [active1.fields[DATACORE_NAME]]'s front photo.", INVESTIGATE_RECORDS)
					if("print_photo_front")
						if(active1)
							var/front_photo = active1.get_front_photo()
							if(istype(front_photo, /obj/item/photo))
								var/obj/item/photo/photo_front = front_photo
								print_photo(photo_front.picture.picture_image, active1.fields[DATACORE_NAME])
					if("show_photo_side")
						if(active1)
							var/side_photo = active1.get_side_photo()
							if(istype(side_photo, /obj/item/photo))
								var/obj/item/photo/photo = side_photo
								photo.show(usr)
					if("upd_photo_side")
						var/obj/item/photo/photo = get_photo(usr)
						if(photo)
							qdel(active1.fields["photo_side"])
							//Lets center it to a 32x32.
							var/icon/I = photo.picture.picture_image
							var/w = I.Width()
							var/h = I.Height()
							var/dw = w - 32
							var/dh = w - 32
							I.Crop(dw/2, dh/2, w - dw/2, h - dh/2)
							active1.fields["photo_side"] = photo
							investigate_log("[key_name(usr)] updated [active1.fields[DATACORE_NAME]]'s front photo.", INVESTIGATE_RECORDS)
					if("print_photo_side")
						if(active1)
							var/side_photo = active1.get_side_photo()
							if(istype(side_photo, /obj/item/photo))
								var/obj/item/photo/photo_side = side_photo
								print_photo(photo_side.picture.picture_image, active1.fields[DATACORE_NAME])
					if("crim_add")
						if(!istype(active1, /datum/data/record/security))
							return
						var/t1 = stripped_input(usr, "Please input crime names:", "Secure. records", "", null)
						var/t2 = stripped_input(usr, "Please input crime details:", "Secure. records", "", null)
						if(!can_use_record_console(usr, t1, null, a2))
							return

						var/datum/data/record/security/security_record = active1
						var/crime = SSdatacore.new_crime_entry(t1, t2, authenticated, station_time_timestamp())
						security_record.add_crime(crime)
						investigate_log("New Crime: <strong>[t1]</strong>: [t2] | Added to [active1.fields[DATACORE_NAME]] by [key_name(usr)]", INVESTIGATE_RECORDS)
					if("crim_delete")
						if(!istype(active1, /datum/data/record/security) || !href_list["cdataid"])
							return

						if(!can_use_record_console(usr, "delete", null, a2))
							return

						var/crime_name
						var/crime_details
						var/datum/data/record/security/security_record = active1
						var/list/crimes = security_record.fields[DATACORE_CRIMES]
						for(var/datum/data/crime/crime in crimes)
							if(crime.dataId == text2num(href_list["cdataid"]))
								crime_name = crime.crimeName
								crime_details = crime.crimeDetails
								break

						investigate_log("[key_name(usr)] deleted a crime from [active1.fields[DATACORE_NAME]]: ([crime_name]) | Details: [crime_details]", INVESTIGATE_RECORDS)
						security_record.remove_crime(href_list["cdataid"])

					if("add_details")
						if(!istype(active1, /datum/data/record/security) || !href_list["cdataid"])
							return


						var/t1 = stripped_input(usr, "Please input crime details:", "Secure. records", "", null)
						if(!can_use_record_console(usr, t1, null, a2))
							return

						var/datum/data/record/security/security_record = active1
						security_record.add_crime_details(href_list["cdataid"], t1)

						investigate_log("New Crime details: [t1] | Added to [active1.fields[DATACORE_NAME]] by [key_name(usr)]", INVESTIGATE_RECORDS)

					if("notes")
						if(istype(active2, /datum/data/record))
							var/t1 = stripped_input(usr, "Please summarize notes:", "Secure. records", active2.fields[DATACORE_NOTES], null)
							if(!can_use_record_console(usr, t1, null, a2))
								return
							active2.fields[DATACORE_NOTES] = t1
					if("criminal")
						if(!istype(active1, /datum/data/record/security))
							return

						temp = "<h5>Criminal Status:</h5>"
						temp += "<ul>"
						temp += "<li><a href='?src=[REF(src)];choice=Change Criminal Status;criminal2=none'>None</a></li>"
						temp += "<li><a href='?src=[REF(src)];choice=Change Criminal Status;criminal2=arrest'>*Arrest*</a></li>"
						temp += "<li><a href='?src=[REF(src)];choice=Change Criminal Status;criminal2=incarcerated'>Incarcerated</a></li>"
						temp += "<li><a href='?src=[REF(src)];choice=Change Criminal Status;criminal2=paroled'>Paroled</a></li>"
						temp += "<li><a href='?src=[REF(src)];choice=Change Criminal Status;criminal2=released'>Discharged</a></li>"
						temp += "</ul>"
					if("rank")
						var/list/L = list( "Head of Personnel", "Captain", "AI", "Central Command" )
						//This was so silly before the change. Now it actually works without beating your head against the keyboard. /N
						if((istype(active1, /datum/data/record) && L.Find(rank)))
							temp = "<h5>Rank:</h5>"
							temp += "<ul>"
							for(var/rank in get_all_jobs())
								temp += "<li><a href='?src=[REF(src)];choice=Change Rank;rank=[rank]'>[rank]</a></li>"
							temp += "</ul>"
						else
							alert(usr, "You do not have the required rank to do this!")
//TEMPORARY MENU FUNCTIONS
			else//To properly clear as per clear screen.
				temp=null
				switch(href_list["choice"])
					if("Change Rank")
						if(active1)
							active1.fields[DATACORE_RANK] = strip_html(href_list["rank"])
							if(href_list["rank"] in get_all_jobs())
								active1.fields["real_rank"] = href_list["real_rank"]

					if("Change Criminal Status")
						if(active2)
							var/old_field = active2.fields[DATACORE_CRIMINAL_STATUS]
							switch(href_list["criminal2"])
								if("none")
									active2.fields[DATACORE_CRIMINAL_STATUS] = "None"
								if("arrest")
									active2.fields[DATACORE_CRIMINAL_STATUS] = "*Arrest*"
								if("incarcerated")
									active2.fields[DATACORE_CRIMINAL_STATUS] = "Incarcerated"
								if("paroled")
									active2.fields[DATACORE_CRIMINAL_STATUS] = "Paroled"
								if("released")
									active2.fields[DATACORE_CRIMINAL_STATUS] = "Discharged"
							investigate_log("[active1.fields[DATACORE_NAME]] has been set from [old_field] to [active2.fields[DATACORE_CRIMINAL_STATUS]] by [key_name(usr)].", INVESTIGATE_RECORDS)
							for(var/i in GLOB.human_list)
								var/mob/living/carbon/human/H = i
								H.sec_hud_set_security_status()
					if("Delete Record (Security) Execute")
						investigate_log("[key_name(usr)] has deleted the security records for [active1.fields[DATACORE_NAME]].", INVESTIGATE_RECORDS)
						if(active2)
							qdel(active2)
							active2 = null

					if("Delete Record (ALL) Execute")
						if(active1)
							investigate_log("[key_name(usr)] has deleted all records for [active1.fields[DATACORE_NAME]].", INVESTIGATE_RECORDS)
							for(var/datum/data/record/R in SSdatacore.get_records(DATACORE_RECORDS_MEDICAL))
								if((R.fields[DATACORE_NAME] == active1.fields[DATACORE_NAME] || R.fields[DATACORE_ID] == active1.fields[DATACORE_ID]))
									qdel(R)
									break
							qdel(active1)
							active1 = null

						if(active2)
							qdel(active2)
							active2 = null
					else
						temp = "This function does not appear to be working at the moment. Our apologies."

	add_fingerprint(usr)
	updateUsrDialog()
	return

/obj/machinery/computer/record/sec/proc/get_photo(mob/user)
	var/obj/item/photo/P = null
	if(issilicon(user))
		var/mob/living/silicon/tempAI = user
		var/datum/picture/selection = tempAI.GetPhoto(user)
		if(selection)
			P = new(null, selection)
	else if(istype(user.get_active_held_item(), /obj/item/photo))
		P = user.get_active_held_item()
	return P

/obj/machinery/computer/record/sec/proc/print_photo(icon/temp, person_name)
	if (printing)
		return
	printing = TRUE
	sleep(20)
	var/obj/item/photo/P = new/obj/item/photo(drop_location())
	var/datum/picture/toEmbed = new(name = person_name, desc = "The photo on file for [person_name].", image = temp)
	P.set_picture(toEmbed, TRUE, TRUE)
	P.pixel_x = rand(-10, 10)
	P.pixel_y = rand(-10, 10)
	printing = FALSE

/obj/machinery/computer/record/sec/emp_act(severity)
	. = ..()

	if(machine_stat & (BROKEN|NOPOWER) || . & EMP_PROTECT_SELF)
		return

	for(var/datum/data/record/R in SSdatacore.get_records(DATACORE_RECORDS_SECURITY))
		if(prob(10/severity))
			switch(rand(1,8))
				if(1)
					if(prob(10))
						R.fields[DATACORE_NAME] = "[pick(lizard_name(MALE),lizard_name(FEMALE))]"
					else
						R.fields[DATACORE_NAME] = "[pick(pick(GLOB.first_names_male), pick(GLOB.first_names_female))] [pick(GLOB.last_names)]"
				if(2)
					R.fields[DATACORE_GENDER] = pick("Male", "Female", "Other")
				if(3)
					R.fields[DATACORE_AGE] = rand(5, 85)
				if(4)
					R.fields[DATACORE_CRIMINAL_STATUS] = pick("None", "*Arrest*", "Incarcerated", "Paroled", "Discharged")
				if(5)
					R.fields[DATACORE_PHYSICAL_HEALTH] = pick("*Unconscious*", "Active", "Physically Unfit")
				if(6)
					R.fields[DATACORE_MENTAL_HEALTH] = pick("*Insane*", "*Unstable*", "*Watch*", "Stable")
				if(7)
					R.fields[DATACORE_SPECIES] = pick(GLOB.roundstart_races)
				if(8)
					var/datum/data/record/G = pick(SSdatacore.get_records(DATACORE_RECORDS_OUTPOST))
					R.fields[DATACORE_APPEARANCE] = G.fields[DATACORE_APPEARANCE]
			continue

		else if(prob(1))
			qdel(R)
			continue

/obj/machinery/computer/record/sec/can_use_record_console(mob/user, message1 = 0, record1, record2)
	if(user)
		if(authenticated)
			if(user.canUseTopic(src, !issilicon(user)))
				if(!trim(message1))
					return 0
				if(!record1 || record1 == active1)
					if(!record2 || record2 == active2)
						return 1
	return 0
