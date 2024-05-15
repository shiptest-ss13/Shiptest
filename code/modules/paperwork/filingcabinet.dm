/* Filing cabinets!
 * Contains:
 *		Filing Cabinets
 *		Security Record Cabinets
 *		Medical Record Cabinets
 *		Employment Contract Cabinets
 */


/*
 * Filing Cabinets
 */
/obj/structure/filingcabinet
	name = "filing cabinet"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE

/obj/structure/filingcabinet/chestdrawer
	name = "chest drawer"
	icon_state = "chestdrawer"

/obj/structure/filingcabinet/chestdrawer/wheeled
	name = "rolling chest drawer"
	desc = "A small cabinet with drawers. This one has wheels!"
	anchored = FALSE

/obj/structure/filingcabinet/filingcabinet	//not changing the path to avoid unnecessary map issues, but please don't name stuff like this in the future -Pete
	icon_state = "tallcabinet"

/obj/structure/filingcabinet/wide
	icon_state = "widecabinet"

/obj/structure/filingcabinet/double
	name = "filing cabinets"
	icon_state = "doublefilingcabinet"

/obj/structure/filingcabinet/double/grey
	icon_state = "doubletallcabinet"

/obj/structure/filingcabinet/double/grey
	icon_state = "doublewidecabinet"

/obj/structure/filingcabinet/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/obj/item/I in loc)
			if(I.w_class < WEIGHT_CLASS_NORMAL) //there probably shouldn't be anything placed ontop of filing cabinets in a map that isn't meant to go in them
				I.forceMove(src)

/obj/structure/filingcabinet/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal(loc, 2)
		for(var/obj/item/I in src)
			I.forceMove(loc)
	qdel(src)

/obj/structure/filingcabinet/attackby(obj/item/P, mob/user, params)
	if(P.tool_behaviour == TOOL_WRENCH && user.a_intent != INTENT_HELP)
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(P.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			set_anchored(!anchored)
	else if(P.w_class < WEIGHT_CLASS_NORMAL)
		if(!user.transferItemToLoc(P, src))
			return
		to_chat(user, "<span class='notice'>You put [P] in [src].</span>")
		icon_state = "[initial(icon_state)]-open"
		sleep(5)
		icon_state = initial(icon_state)
		updateUsrDialog()
	else if(user.a_intent != INTENT_HARM)
		to_chat(user, "<span class='warning'>You can't put [P] in [src]!</span>")
	else
		return ..()


/obj/structure/filingcabinet/ui_interact(mob/user)
	. = ..()
	if(contents.len <= 0)
		to_chat(user, "<span class='notice'>[src] is empty.</span>")
		return

	var/dat = "<center><table>"
	var/i
	for(i=contents.len, i>=1, i--)
		var/obj/item/P = contents[i]
		dat += "<tr><td><a href='?src=[REF(src)];retrieve=[REF(P)]'>[P.name]</a></td></tr>"
	dat += "</table></center>"
	user << browse("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>[name]</title></head><body>[dat]</body></html>", "window=filingcabinet;size=350x300")

/obj/structure/filingcabinet/attack_tk(mob/user)
	if(anchored)
		attack_self_tk(user)
	else
		..()

/obj/structure/filingcabinet/attack_self_tk(mob/user)
	if(contents.len)
		if(prob(40 + contents.len * 5))
			var/obj/item/I = pick(contents)
			I.forceMove(loc)
			if(prob(25))
				step_rand(I)
			to_chat(user, "<span class='notice'>You pull \a [I] out of [src] at random.</span>")
			return
	to_chat(user, "<span class='notice'>You find nothing in [src].</span>")

/obj/structure/filingcabinet/Topic(href, href_list)
	if(!usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
		return
	if(href_list["retrieve"])
		usr << browse("", "window=filingcabinet") // Close the menu

		var/obj/item/P = locate(href_list["retrieve"]) in src //contents[retrieveindex]
		if(istype(P) && in_range(src, usr))
			usr.put_in_hands(P)
			updateUsrDialog()
			icon_state = "[initial(icon_state)]-open"
			addtimer(VARSET_CALLBACK(src, icon_state, initial(icon_state)), 5)


/*
 * Security Record Cabinets
 */

/obj/structure/filingcabinet/record
	var/datum/overmap/ship/controlled/linked_ship
	var/virgin = 1

/obj/structure/filingcabinet/record/Initialize()
	. = ..()
	linked_ship = SSshuttle.get_ship(src)

/obj/structure/filingcabinet/record/proc/populate()
	return

/obj/structure/filingcabinet/record/attack_hand()
	populate()
	. = ..()

/obj/structure/filingcabinet/record/attack_tk()
	populate()
	..()

/obj/structure/filingcabinet/record/populate()
	if(virgin)
		for(var/datum/data/record/G in SSdatacore.get_records(linked_ship))
			var/obj/item/paper/record_paper = new /obj/item/paper(src)
			var/record_text = get_record_text(G)
			record_paper.add_raw_text(record_text)
			record_paper.name = "paper - '[linked_ship.name] - [G.fields[DATACORE_NAME]]'"
			record_paper.update_appearance()
			virgin = 0	//tabbing here is correct- it's possible for people to try and use it
						//before the records have been generated, so we do this inside the loop.
			linked_ship = null

/obj/structure/filingcabinet/record/proc/get_record_text(datum/data/record/G)
	return

/obj/structure/filingcabinet/record/security/get_record_text(datum/data/record/G)
	var/record_text = "<CENTER><B>Security Record</B></CENTER><BR>"
	record_text += "Name: [G.fields[DATACORE_NAME]] ID: [G.fields[DATACORE_ID]]<BR>\nGender: [G.fields[DATACORE_GENDER]]<BR>\nAge: [G.fields[DATACORE_AGE]]<BR>\nFingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\nPhysical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\nMental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR>"
	record_text += "<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: [G.fields[DATACORE_CRIMINAL_STATUS]]<BR>\n<BR>\nCrimes: [G.fields[DATACORE_CRIMES]]<BR>\nDetails: [G.fields["crim_d"]]<BR>\n<BR>\nImportant Notes:<BR>\n\t[G.fields[DATACORE_NOTES]]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>"
	record_text += "</TT>"
	return record_text

/obj/structure/filingcabinet/record/medical/get_record_text(datum/data/record/G)
	var/record_text = "<CENTER><B>Medical Record</B></CENTER><BR>"
	record_text += "Name: [G.fields[DATACORE_NAME]] ID: [G.fields[DATACORE_ID]]<BR>\nGender: [G.fields[DATACORE_GENDER]]<BR>\nAge: [G.fields[DATACORE_AGE]]<BR>\nFingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\nPhysical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\nMental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR>"
	record_text += "<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: [G.fields[DATACORE_BLOOD_TYPE]]<BR>\nDNA: [G.fields[DATACORE_BLOOD_DNA]]<BR>\n<BR>\nMinor Disabilities: [G.fields["mi_dis"]]<BR>\nDetails: [G.fields["mi_dis_d"]]<BR>\n<BR>\nMajor Disabilities: [G.fields[DATACORE_DISABILITIES]]<BR>\nDetails: [G.fields[DATACORE_DISABILITIES_DETAILS]]<BR>\n<BR>\nAllergies: [G.fields["alg"]]<BR>\nDetails: [G.fields["alg_d"]]<BR>\n<BR>\nCurrent Diseases: [G.fields[DATACORE_DISEASES]] (per disease info placed in log/comment section)<BR>\nDetails: [G.fields[DATACORE_DISEASES_DETAILS]]<BR>\n<BR>\nImportant Notes:<BR>\n\t[G.fields[DATACORE_NOTES]]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>"
	record_text += "</TT>"
	return record_text

/obj/structure/filingcabinet/record/gen/get_record_text(datum/data/record/G)
	var/record_text = "<CENTER><B>General Record</B></CENTER><BR>"
	record_text += "Name: [G.fields[DATACORE_NAME]] ID: [G.fields[DATACORE_ID]]<BR>\nGender: [G.fields[DATACORE_GENDER]]<BR>\nAge: [G.fields[DATACORE_AGE]]<BR>\nFingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\nPhysical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\nMental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR>"
	record_text += "</TT>"
	return record_text
