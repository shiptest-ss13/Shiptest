//WS text obfs subsystem, this can be widely applied for URL specific words.
//Object-Position ownership map:
/*
	POSITION:		OBJECT PATH:
	[1][X]			/obj/item/reagent_containers/food/snacks/meatball
*/
//obf_string_list position map:
/*
	[X][1] = Decrypted strings for use, upon failure of deobfustication this spot is filled with [4], this should be initialized to ""
	[X][2] = Actual obfusticated value to decode, more info in the decrypt_by_world_URL proc
	[X][3] = The salted MD5 hash of a sucessful deobfustication, this will be used to tell whether [1] should be filled with [4] or the decoded value
	[X][4] = The target word to replace, this only applies to /obj/'s. If the salted MD5 hash of the decoded word does not match [3] this will be put into [0]
*/
//See the obfStringGenerator program in /tools/ to create an entry for obf_string_list, be sure to increment OBF_STRING_COUNT!
#define OBF_STRING_COUNT 1

SUBSYSTEM_DEF(textobfs)
	name = "Textobfs"
	init_order = INIT_ORDER_TEXT	//This should run first as other subsystems may depend on the deobfuscation of targets.
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_INIT
	var/worldURL
	var/list/obf_string_list = new/list(OBF_STRING_COUNT, 4)
	obf_string_list = list(
		list("", ":d><Fy", "d907935191deb1b56b4f006be17013b4", "meatball")
	)

/datum/controller/subsystem/textobfs/Initialize()
	worldURL = world.url
	for(var/y = 1; y < OBF_STRING_COUNT + 1; y++)
		obf_string_list[y][1] = decrypt_by_world_URL(obf_string_list[y][2], obf_string_list[y][3], obf_string_list[y][4])
	return ..()

/datum/controller/subsystem/textobfs/proc/decrypt_by_world_URL(obfsStr = "", hash = "", fallback = "GENERIC OBJECT")
	var/key = md5(worldURL)
	var/result = ""
	//Would add comments to this process but the point is that its not too obvious for 'uninvolved observers'
	for(var/i = 1; i < length_char(obfsStr) + 1; i++)
		var/keyPtr = i % max(length_char(key), 1)
		result = result + ascii2text((text2ascii(obfsStr, i) - text2ascii(key, keyPtr)) + 96)
	//End decode
	if(md5(key + result) != hash)
		return fallback
	else
		return result

#undef OBF_STRING_COUNT
