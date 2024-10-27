//Preferences stuff
	//Hairstyles
GLOBAL_LIST_EMPTY(hairstyles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hairstyles_male_list)		//stores only hair names
GLOBAL_LIST_EMPTY(hairstyles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hairstyles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(facial_hairstyles_male_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hairstyles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(hair_gradients_list) //stores /datum/sprite_accessory/hair_gradient indexed by name
	//Underwear
GLOBAL_LIST_EMPTY(underwear_list)		//stores /datum/sprite_accessory/underwear indexed by name
	//Undershirts
GLOBAL_LIST_EMPTY(undershirt_list) 	//stores /datum/sprite_accessory/undershirt indexed by name
	//Socks
GLOBAL_LIST_EMPTY(socks_list)		//stores /datum/sprite_accessory/socks indexed by name
	//Body Sizes
GLOBAL_LIST_INIT(body_sizes, list("Normal" = BODY_SIZE_NORMAL, "Short" = BODY_SIZE_SHORT, "Tall" = BODY_SIZE_TALL))
	//lizard Bits (all datum lists indexed by name)
GLOBAL_LIST_EMPTY(body_markings_list)
GLOBAL_LIST_EMPTY(tails_list_lizard)
GLOBAL_LIST_EMPTY(animated_tails_list_lizard)
GLOBAL_LIST_EMPTY(face_markings_list)
GLOBAL_LIST_EMPTY(horns_list)
GLOBAL_LIST_EMPTY(frills_list)
GLOBAL_LIST_EMPTY(spines_list)
GLOBAL_LIST_EMPTY(legs_list)
GLOBAL_LIST_EMPTY(animated_spines_list)

	//Mutant Human bits
GLOBAL_LIST_EMPTY(tails_list_human)
GLOBAL_LIST_EMPTY(animated_tails_list_human)
GLOBAL_LIST_EMPTY(ears_list)
GLOBAL_LIST_EMPTY(wings_list)
GLOBAL_LIST_EMPTY(wings_open_list)
GLOBAL_LIST_EMPTY(r_wings_list)
GLOBAL_LIST_EMPTY(moth_wings_list)
GLOBAL_LIST_EMPTY(moth_fluff_list)
GLOBAL_LIST_EMPTY(moth_markings_list)
GLOBAL_LIST_EMPTY(squid_face_list)
GLOBAL_LIST_EMPTY(ipc_screens_list)
GLOBAL_LIST_EMPTY(ipc_antennas_list)
GLOBAL_LIST_EMPTY(ipc_tail_list)
GLOBAL_LIST_EMPTY(ipc_chassis_list)
GLOBAL_LIST_INIT(ipc_brain_list, list("Posibrain", "Man-Machine Interface"))
GLOBAL_LIST_EMPTY(spider_legs_list)
GLOBAL_LIST_EMPTY(spider_spinneret_list)
GLOBAL_LIST_EMPTY(kepori_feathers_list)
GLOBAL_LIST_EMPTY(kepori_body_feathers_list)
GLOBAL_LIST_EMPTY(kepori_head_feathers_list)
GLOBAL_LIST_EMPTY(kepori_tail_feathers_list)
GLOBAL_LIST_EMPTY(vox_head_quills_list)
GLOBAL_LIST_EMPTY(vox_neck_quills_list)
GLOBAL_LIST_EMPTY(elzu_horns_list)
GLOBAL_LIST_EMPTY(tails_list_elzu)
GLOBAL_LIST_EMPTY(animated_tails_list_elzu)

GLOBAL_LIST_INIT(color_list_ethereal, list(
	"Red" = "ff4d4d",
	"Faint Red" = "ffb3b3",
	"Dark Red" = "9c3030",
	"Orange" = "ffa64d",
	"Burnt Orange" = "cc4400",
	"Bright Yellow" = "ffff99",
	"Dull Yellow" = "fbdf56",
	"Faint Green" = "ddff99",
	"Green" = "97ee63",
	"Seafoam Green" = "00fa9a",
	"Dark Green" = "37835b",
	"Cyan Blue" = "00ffff",
	"Faint Blue" = "b3d9ff",
	"Blue" = "3399ff",
	"Dark Blue" = "6666ff",
	"Purple" = "ee82ee",
	"Dark Fuschia" = "cc0066",
	"Pink" = "ff99cc",
	"White" = "f2f2f2",))

GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list(
	"ghost",
	"ghostian",
	"ghostian2",
	"ghostking",
	"ghost_red",
	"ghost_black",
	"ghost_blue",
	"ghost_yellow",
	"ghost_green",
	"ghost_pink",
	"ghost_cyan",
	"ghost_dblue",
	"ghost_dred",
	"ghost_dgreen",
	"ghost_dcyan",
	"ghost_grey",
	"ghost_dyellow",
	"ghost_dpink",
	"skeleghost",
	"ghost_purpleswirl",
	"ghost_rainbow",
	"ghost_fire",
	"ghost_funkypurp",
	"ghost_pinksherbert",
	"ghost_blazeit",
	"ghost_mellow",
	"ghost_camo",
	"catghost")) //stores the ghost forms that support directional sprites

GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, sortList(list(
	":thinking:",
	"Alien",
	"Angel",
	"Banned",
	"Bliss",
	"Blue",
	"Clown",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"HAL 9000",
	"Heartline",
	"Helios",
	"House",
	"Inverted",
	"Lamp",
	"Matrix",
	"Monochrome",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"President",
	"Random",
	"Rainbow",
	"Red",
	"Red October",
	"Static",
	"Syndicat Meow",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Weird")))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		return "ai-[lowertext(input)]"

GLOBAL_LIST_INIT(security_depts_prefs, sortList(list(SEC_DEPT_RANDOM, SEC_DEPT_NONE, SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY)))

	//Backpacks
#define GBACKPACK "Grey Backpack"
#define GSATCHEL "Grey Satchel"
#define GDUFFELBAG "Grey Duffel Bag"
#define GCOURIERBAG "Grey Messenger Bag"
#define LSATCHEL "Leather Satchel"
#define DBACKPACK "Department Backpack"
#define DSATCHEL "Department Satchel"
#define DDUFFELBAG "Department Duffel Bag"
#define DCOURIERBAG "Department Messenger Bag"
GLOBAL_LIST_INIT(backpacklist, list(DBACKPACK, DSATCHEL, DCOURIERBAG, DDUFFELBAG, GBACKPACK, GSATCHEL, GCOURIERBAG, GDUFFELBAG, LSATCHEL))

	//Uniform
#define PREF_SUIT "Standard Jumpsuit"
#define PREF_SKIRT "Standard Jumpskirt"
#define PREF_ALTSUIT "Alternate Jumpsuit"
#define PREF_GREYSUIT "Grey Jumpsuit"
GLOBAL_LIST_INIT(jumpsuitlist, list(PREF_SUIT, PREF_SKIRT, PREF_ALTSUIT, PREF_GREYSUIT))

	//Exowear
#define PREF_NOEXOWEAR "No Exowear"
#define PREF_EXOWEAR "Standard Exowear"
#define PREF_ALTEXOWEAR "Alternate Exowear"
#define PREF_COATEXOWEAR "Departmental Winter Coat"
GLOBAL_LIST_INIT(exowearlist, list(PREF_NOEXOWEAR, PREF_EXOWEAR, PREF_ALTEXOWEAR, PREF_COATEXOWEAR))

//Uplink spawn loc
#define UPLINK_PDA "PDA"
#define UPLINK_RADIO "Radio"
#define UPLINK_PEN "Pen" //like a real spy!
GLOBAL_LIST_INIT(uplink_spawn_loc_list, list(UPLINK_PDA, UPLINK_RADIO, UPLINK_PEN))

//favorite cigarette brand
#define PREF_CIG_SPACE "Space Cigarettes"
#define PREF_CIG_DROMEDARY "DromedaryCo Cigarettes"
#define PREF_CIG_UPLIFT "Uplift Smooth Cigarettes"
#define PREF_CIG_ROBUST "Robust Cigarettes"
#define PREF_CIG_ROBUSTGOLD "Robust Gold Cigarettes"
#define PREF_CIG_CARP "Carp Classic Cigarettes"
#define PREF_CIG_MIDORI "Midori Taboko Rollies"
#define PREF_CIGAR "Premium Cigars"
#define PREF_CIGAR_SOLAR "Solarian Cigars"
#define PREF_CIGAR_COHIBA "Cohiba Cigars"
#define PREF_VAPE "Vape Pen"
#define PREF_PIPE "Fancy Pipe"

GLOBAL_LIST_INIT(valid_smoke_types, sortList(list(PREF_CIG_SPACE, PREF_CIG_DROMEDARY, PREF_CIG_UPLIFT, PREF_CIG_ROBUST, PREF_CIG_ROBUSTGOLD, PREF_CIG_CARP, PREF_CIG_MIDORI, PREF_CIGAR, PREF_CIGAR_SOLAR, PREF_CIGAR_COHIBA, PREF_VAPE, PREF_PIPE)))

	//Female Uniforms
GLOBAL_LIST_EMPTY(female_clothing_icons)
	//Alternate species icons
GLOBAL_LIST_EMPTY(species_clothing_icons)

GLOBAL_LIST_INIT(scarySounds, list('sound/weapons/thudswoosh.ogg','sound/weapons/taser.ogg','sound/weapons/armbomb.ogg','sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg','sound/voice/hiss5.ogg','sound/voice/hiss6.ogg','sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg','sound/items/welder.ogg','sound/items/welder2.ogg','sound/machines/airlocks/standard/open.ogg','sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg'))


// Reference list for disposal sort junctions. Set the sortType variable on disposal sort junctions to
// the index of the sort department that you want. For example, sortType set to 2 will reroute all packages
// tagged for the Cargo Bay.

/* List of sortType codes for mapping reference
0 Waste
1 Disposals - All unwrapped items and untagged parcels get picked up by a junction with this sortType. Usually leads to the recycler.
2 Cargo Bay
3 QM Office
4 Engineering
5 CE Office
6 Atmospherics
7 Security
8 HoS Office
9 Medbay
10 CMO Office
11 Chemistry
12 Research
13 RD Office
14 Robotics
15 Head of Personnel's Office
16 Library
17 Chapel
18 Theatre
19 Bar
20 Kitchen
21 Hydroponics
22 Janitor
23 Genetics
24 Experimentor Lab
25 Toxins
26 Dormitories
27 Virology
28 Law Office
29 Detective's Office
*/

//The whole system for the sorttype var is determined based on the order of this list,
//disposals must always be 1, since anything that's untagged will automatically go to disposals, or sorttype = 1 --Superxpdude

//If you don't want to fuck up disposals, add to this list, and don't change the order.
//If you insist on changing the order, you'll have to change every sort junction to reflect the new order. --Pete

GLOBAL_LIST_INIT(TAGGERLOCATIONS, list("Disposals",
	"Cargo Bay", "QM Office", "Engineering", "CE Office",
	"Atmospherics", "Security", "HoS Office", "Medbay",
	"CMO Office", "Chemistry", "Research", "RD Office",
	"Robotics", "Head of Personnel's Office", "Library", "Chapel", "Theatre",
	"Bar", "Kitchen", "Hydroponics", "Janitor Closet","Genetics",
	"Experimentor Lab", "Toxins", "Dormitories", "Virology",
	, "Law Office","Detective's Office"))

GLOBAL_LIST_INIT(station_prefixes, world.file2list("strings/station_prefixes.txt"))

GLOBAL_LIST_INIT(station_names, world.file2list("strings/station_names.txt"))

GLOBAL_LIST_INIT(station_suffixes, world.file2list("strings/station_suffixes.txt"))

GLOBAL_LIST_INIT(greek_letters, world.file2list("strings/greek_letters.txt"))

GLOBAL_LIST_INIT(phonetic_alphabet, world.file2list("strings/phonetic_alphabet.txt"))

GLOBAL_LIST_INIT(numbers_as_words, world.file2list("strings/numbers_as_words.txt"))

GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/wisdoms.txt"))

GLOBAL_LIST_INIT(ship_names, world.file2list("strings/ship_names.txt"))

GLOBAL_LIST_INIT(star_names, world.file2list("strings/star_names.txt"))

GLOBAL_LIST_INIT(planet_names, world.file2list("strings/planet_names.txt"))

GLOBAL_LIST_INIT(planet_prefixes, world.file2list("strings/planet_prefixes.txt"))

/proc/generate_number_strings()
	var/list/L[198]
	for(var/i in 1 to 99)
		L += "[i]"
		L += "\Roman[i]"
	return L

GLOBAL_LIST_INIT(station_numerals, greek_letters + phonetic_alphabet + numbers_as_words + generate_number_strings())

GLOBAL_LIST_INIT(admiral_messages, list("Do you know how expensive these stations are?","Stop wasting my time.","I was sleeping, thanks a lot.","Stand and fight you cowards!","You knew the risks coming in.","Stop being paranoid.","Whatever's broken just build a new one.","No.", "<i>null</i>","<i>Error: No comment given.</i>", "It's a good day to die!"))
