/datum/config_entry/string/comms_key
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/comms_key/ValidateAndSet(str_val)
	return str_val != "default_pwd" && length(str_val) > 6 && ..()

/datum/config_entry/keyed_list/cross_server
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_TEXT
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/keyed_list/cross_server/ValidateAndSet(str_val)
	. = ..()
	if(.)
		var/list/newv = list()
		for(var/I in config_entry_value)
			newv[replacetext(I, "+", " ")] = config_entry_value[I]
		config_entry_value = newv

/datum/config_entry/keyed_list/cross_server/ValidateListEntry(key_name, key_value)
	return key_value != "byond:\\address:port" && ..()

/datum/config_entry/string/cross_comms_name

/datum/config_entry/string/medal_hub_address

/datum/config_entry/string/medal_hub_password
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/bot_ip

/datum/config_entry/string/cross_comms_network
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/server_language
	config_entry_value = "en"
	protection = CONFIG_ENTRY_LOCKED

/// Base64-encoded ed25519 private key (32-byte seed). The corresponding public key
/// must appear in the _ss13hub DNS TXT record as: ss13hub-ed25519=<base64-pubkey>
/datum/config_entry/string/verified_private_key
	protection = CONFIG_ENTRY_HIDDEN

/// The domain to attest ownership of. Must have a _ss13hub TXT record with the matching ed25519 pubkey.
/// Maximum 32 characters.
/datum/config_entry/string/verified_domain
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/server_region
	protection = CONFIG_ENTRY_LOCKED
	config_entry_value = "north_america_east"

/datum/config_entry/string/server_region/ValidateAndSet(str_val)
	return (str_val in list("africa_central", "africa_north", "africa_south", "antarctica",
	"asia_east", "asia_north", "asia_southeast", "central_america",
	"europe_east", "europe_west", "greenland", "india", "middle_east",
	"north_america_central", "north_america_east", "north_america_west",
	"oceania", "south_america_east", "south_america_south", "south_america_west")) && ..()

/// What tags this server should have on the SS13Hub. This is from a predefined list of available tags,
/// available at: <source code link to backend parsing for tags>
/datum/config_entry/str_list/server_tags

/// A secondary field that will be visible to users on the SS13Hub
/// Up to 1024 characters, no HTML encoding.
/datum/config_entry/string/server_desc

/datum/config_entry/string/server_desc/ValidateAndSet(str_val)
	return (length(str_val) < 1024) && ..()

/// Whether or not clients are allowed to auth with SS13Hub.
/datum/config_entry/flag/ss13hub_auth
	protection = CONFIG_ENTRY_LOCKED
	config_entry_value = FALSE
