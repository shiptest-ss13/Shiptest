//papers

/obj/item/folder/warra/rhea/med
	name = "folder"
	icon_state = "folder_white"

/obj/item/folder/warra/rhea/med/morgue
	name = "morgue record folder"
	icon_state = "folder_white"

/obj/item/folder/warra/rhea/med/cremation
	name = "cremation record folder"
	icon_state = "folder_white"

/obj/item/folder/warra/rhea/med/morgue/Initialize()
	. = ..()
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	new /obj/item/paper/fluff/ship/rhea/morgue(src)
	update_appearance()

/obj/item/folder/warra/rhea/med/cremation/Initialize()
	. = ..()
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	new /obj/item/paper/fluff/ship/rhea/cremation(src)
	update_appearance()

/obj/item/paper/fluff/ship/rhea/morgue/Initialize(mapload)
	. = ..()
	var/datum/component/writing/this_paper = src.GetComponent(/datum/component/writing)
	this_paper.window_height = 1000
	this_paper.window_width = 850
	this_paper.resizable = FALSE

/obj/item/paper/fluff/ship/rhea/cremation/Initialize(mapload)
	. = ..()
	var/datum/component/writing/this_paper = src.GetComponent(/datum/component/writing)
	this_paper.window_height = 1000
	this_paper.window_width = 850
	this_paper.resizable = FALSE

/obj/item/paper/fluff/ship/rhea/morgue
	name = "Post Mortem Care Record"
	default_raw_text = {"<html>
			<table width="100%"frame="below">
			<tr>
			<td><font face="Times"size="2">
			Makosso-Warra<br>Rhea-class Recovery Vessel Form
			</td>
			<td><div align="right"><font face="Times"size="2">
			YYY/MM/DD: \[______________]<br>LOCAL SECTOR TIME: \[______________]
			</td>
			</tr>
			</table>
			<hr>
			<center><font face="Times"size="3"><b>POST MORTEM CARE RECORD</b></font></center>
			<hr>
			<center><b>This form must be filled for each intake and release</b></center>
			<center><font face="Times"size="3">If the body is unable to be offloaded, is unclaimed, or is unidentifiable, it is to be stored aboard the vessel for a week or until mortuary capacity is reached. If unresolved by this time, final disposition is to be handled by cremation and any belongings of the deceased are to be disposed or reclaimed.
			<br>
			<br>
			If ownership of the deceased is rejected by next of kin and any groups responsible for them (nations, employment), or they are unable/unwilling to be contacted, the deceased will be defaulted to an approved organ donor status.</font></center>
			<br>
			<font face="Times"size="2">Stored in Morgue Unit (1-4):</font> \[_]
			<br>
			<br>
			<font face="Times"size="2">Organ Donor? (Y-N):</font> \[_]
			<br>
			<br>
			<font face="Times"size="2">If yes to above, were any organs surgically removed by staff? (Y-N):</font> \[_]
			<br>
			<br>
			<font face="Times"size="2">Deceased Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Nationality</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Age & DOB</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Gender</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Species</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Employment</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Circumstances of Discovery:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Place of Death</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Est. Time of Death</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Time Pronounced Dead</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Group or Person(s) Admitting Body</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Property with Deceased (equipment, clothing, notes, etc.):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Manner and Cause of Death:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			</table>
			<br>
			<font face="Times"size="2">Notes (related forms, status of deceased prior to final disposition, special circumstances):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Morgue Attendant Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Position</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Signature</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			</table>
			"}

/obj/item/paper/fluff/ship/rhea/morgue/miner
	name = "Bloodied Post Mortem Care Record"
	icon_state = "scrap_bloodied"
	show_written_words = FALSE
	default_raw_text = {"<html>
			<table width="100%"frame="below">
			<tr>
			<td><font face="Times"size="2">
			Makosso-Warra<br>Rhea-class Recovery Vessel Form
			</td>
			<td><div align="right"><font face="Times"size="2">
			YYY/MM/DD: \[______________]<br>LOCAL SECTOR TIME: \[______________]
			</td>
			</tr>
			</table>
			<hr>
			<center><font face="Times"size="3"><b>POST MORTEM CARE RECORD</b></font></center>
			<hr>
			<center><b>This form must be filled for each intake and release</b></center>
			<center><font face="Times"size="3">If the body is unable to be offloaded, is unclaimed, or is unidentifiable, it is to be stored aboard the vessel for a week or until mortuary capacity is reached. If unresolved by this time, final disposition is to be handled by cremation and any belongings of the deceased are to be disposed or reclaimed.
			<br>
			<br>
			If ownership of the deceased is rejected by next of kin and any groups responsible for them (nations, employment), or they are unable/unwilling to be contacted, the deceased will be defaulted to an approved organ donor status.</font></center>
			<br>
			<font face="Times"size="2">Stored in Morgue Unit (1-4):</font> \[<b>4</b>]
			<br>
			<br>
			<font face="Times"size="2">Organ Donor? (Y-N):</font> \[<b>Y</b>]
			<br>
			<br>
			<font face="Times"size="2">If yes to above, were any organs surgically removed by staff? (Y-N):</font> \[_]
			<br>
			<br>
			<font face="Times"size="2">Deceased Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Nationality</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Age & DOB</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Gender</td>
			<td><center><font face="Times"size="2">\[<b>Female</b>]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Species</td>
			<td><center><font face="Times"size="2">\[<b>Human</b>]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Employment</td>
			<td><center><font face="Times"size="2">\[<b>N+S Logistics</b>]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Circumstances of Discovery:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Place of Death</td>
			<td><center><font face="Times"size="2">\[<b>Unnamed Planetoid</b>]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Est. Time of Death</td>
			<td><center><font face="Times"size="2">\[<b>1 week ago.</b>]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Time Pronounced Dead</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Group or Person(s) Admitting Body</td>
			<td><center><font face="Times"size="2">\[<b>Onboard VI Recovery Team</b>]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Property with Deceased (equipment, clothing, notes, etc.):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Manner and Cause of Death:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[<b>Deceased drilled into the roof above them to extract minerals, causing a cave-in to entomb them.</b>]<br>
			\[<b>Succumbed to blunt impact trauma and asphyxia before rescue could arrive.</b>]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			</table>
			<br>
			<font face="Times"size="2">Notes (related forms, status of deceased prior to final disposition, special circumstances):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[<b>Deceased holds no next of kin or core world citizenships.</b>]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Morgue Attendant Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Position</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Signature</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			</table>
			"}

/obj/item/paper/fluff/ship/rhea/cremation
	name = "Cremation Authorization Record"
	default_raw_text = {"<html>
			<table width="100%"frame="below">
			<tr>
			<td><font face="Times"size="2">
			Makosso-Warra<br>Rhea-class Recovery Vessel Form
			</td>
			<td><div align="right"><font face="Times"size="2">
			YYY/MM/DD: \[______________]<br>LOCAL SECTOR TIME: \[______________]
			</td>
			</tr>
			</table>
			<hr>
			<center><font face="Times"size="3"><b>CREMATION AUTHORIZATION RECORD</b></font></center>
			<hr>
			<center><b>No cremation may take place without the authorization of the vessel's medical director</b></center>
			<center><font face="Times"size="3">Cremation is a final and irreversible process. A post mortem care record must be filled prior to cremation. All information is to be verified again.
			<br>
			<br>
			The deceased must be checked for implants which could be hazardous if exposed to the high temperatures of the cremation process. Robotic lifeforms may require certain components (power sources, fluids, air tanks) to be removed.</font></center>
			<br>
			<font face="Times"size="2">Stored in Morgue Unit (1-4):</font> \[_]
			<br>
			<br>
			<font face="Times"size="2">Deceased Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Nationality</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Age & DOB</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Gender</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Species</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Employment</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Parts/Implants Removed from Deceased prior to Cremation (if applicable):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Property with Deceased (equipment, clothing, notes, etc.):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Fate of Deceased's Property:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Scheduled Time of Cremation & Disposition of Ashes (if applicable):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Cremation</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Disposition</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Selected Container for Remains &
			<br>
			Planned Disposition of Ashes (if applicable):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Notes (related forms, status of deceased prior to final disposition, special circumstances):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td><center><font face="Times"size="2">
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			\[__________________________________________________________________________________________________]<br>
			</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Person(s) in Control of Final Disposition (if applicable):</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Relation</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Relation</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Signature</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Signature</td>
			<td><center><font face="Times"size="2">\[______________________________]</td>
			</tr>
			</table>
			<br>
			<font face="Times"size="2">Medical Director Information:</font>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Name</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			<tr>
			<td bgcolor="#666666"><center><font face="Times"size="2"color="white">Signature</td>
			<td><center><font face="Times"size="2">\[____________________________________________________________________________]</td>
			</tr>
			</table>
			<center><font face="Times"size="3"><b>STAMP BELOW</b>
			<br>
			<br>
			<br>
			"}

/obj/item/paper/fluff/ship/rhea/blood
	name = "Blood Compatibility Chart"
	default_raw_text = {"<html>
			<table width="100%"frame="below">
			<tr>
			<td><font face="Times"size="2">
			Makosso-Warra<br>Rhea-class Recovery Vessel Form
			</td>
			<td><div align="right"><font face="Times"size="2">
			FS 506-08-27
			</td>
			</tr>
			</table>
			<hr>
			<center><font face="Times"size="3"><b>BLOOD COMPATIBILITY CHART</b></font></center>
			<hr>
			<center>
			<table style="width: 90%;" border="2">
			<tbody>
			<tr>
			<td ><center>+</td>
			<td><center>O-</td>
			<td><center>O+</td>
			<td><center>A-</td>
			<td><center>A+</td>
			<td><center>B-</td>
			<td><center>B+</td>
			<td><center>AB-</td>
			<td><center>AB+</td>
			<td><center>S</td>
			<td><center>E</td>
			</tr>
			<tr>
			<td><center>O-</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>O+</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>A-</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>A+</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>B-</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>B+</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>AB-</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>AB+</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>S</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			<td bgcolor="a2a2a2"></td>
			</tr>
			<tr>
			<td><center>E</td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td bgcolor="a2a2a2"></td>
			<td><center>✔</td>
			</tr>
			</tbody>
			</table>
			<b>RECIPIENT LEFT ROW. DONOR TOP ROW.</b>
			"}

// holodisks

/datum/preset_holoimage/rheaaffairs
	species_type = /datum/species/lizard
	outfit_type = /datum/outfit/job/warra/lawyer


/obj/item/disk/holodisk/ship/rhea/affairs
	name = "holorecord disk - Corporate Representation"
	preset_image_type = /datum/preset_holoimage/rheaaffairs
	preset_record_text = {"
	NAME MW Administrative Assistant
	DELAY 10
	SAY Greetings, welcome to your office. Make yourself comfortable and ready to listen...
	DELAY 40
	SAY ...ahem- I'm delivering the word of the day from management to you.
	DELAY 40
	SAY Pulling up my notes, here's where you are and what they want to hear from you...
	SOUND keyboard
	DELAY 50
	SAY You're overseeing the operations of a Rhea-class, a vessel purpose-built for asset recovery.
	DELAY 40
	SAY This is a modern creation from Spaceworks, which means there's a keen interest in it's performance of that task.
	DELAY 50
	SAY Management wants you closely involved throughout the day to day happenings aboard.
	DELAY 50
	SAY Everything from documentation of asset recovery to staff satisfaction surveys.
	DELAY 60
	SAY The vessel itself aside, you'll be managing employee-related functions as per usual.
	DELAY 50
	SAY Larger workforces come with some cons, oft related to poor communication or conflict over a course of action.
	DELAY 60
	SAY It is your responsibility to minimize confusion and engage in workplace conflict resolution to mitigate these issues as they appear.
	DELAY 50
	SAY Early intervention is best. I encourage you to be comfortable in calling staff to your office when problematic behaviours occur.
	DELAY 50
	SAY A simple, respectful conversation can prevent weeks of complications from an unaddressed issue.
	DELAY 60
	SAY Onto our last point...
	DELAY 40
	SAY As one of four command staff typically assigned to a Rhea, you have access to certain areas most of the crew do not.
	DELAY 50
	SAY You act as a direct bridge of communication between the crew, the captain, and the company.
	DELAY 50
	SAY This does not give you the authority to overrule the decisions of the captain, who the company has entrusted to direct this vessel.
	DELAY 50
	SAY But you are encouraged to assist them in making informed decisions regarding their responsibilities, and offer assistance in command duties.
	DELAY 60
	SAY Alright. That's all we have to go over. You have a wide range of responsibilities and plenty of time to complete them.
	DELAY 50
	SAY Deadline for the reports is two months and you could be staffing upwards to weeks, so pick and choose what you'll spend your time on today wisely.
	DELAY 60
	SAY If anything changes someone will contact you over your fax or holopad, most likely. Farewell, be hearing from you soon.
	DELAY 60
	"}

// corpse
/obj/effect/mob_spawn/human/corpse/ship/warra/rhea/morgueminer
	brute_damage = 148
	oxy_damage = 52
	mob_gender = FEMALE
	outfit = /datum/outfit/job/warra/miner
