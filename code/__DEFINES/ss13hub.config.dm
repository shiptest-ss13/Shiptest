#define SS13LIB_EXTERNAL_CONFIGURATION
//#define SS13LIB_EXTERNAL_INIT
#define SS13LIB_EXTERNAL_HEARTBEAT

#define SS13LIB_HUB_VISIBILITY world.visibility
#define SS13LIB_AUTH_METHODS CONFIG_GET(flag/ss13hub_auth) ? list("byond", "hub") : list("byond")
#define SS13LIB_PLAYER_COUNT GLOB.clients.len
#define SS13LIB_PLAYER_LIMIT CONFIG_GET(number/extreme_popcap)

#define SS13LIB_SERVER_DISPLAY_NAME CONFIG_GET(string/servername)
#define SS13LIB_CONNECTION_ADDRESS CONFIG_GET(string/server)
#define SS13LIB_REGION CONFIG_GET(string/server_region)
#define SS13LIB_SERVER_LANGUAGE CONFIG_GET(string/server_language)
#define SS13LIB_SERVER_TAGS CONFIG_GET(str_list/server_tags)
#define SS13LIB_SERVER_DESCRIPTION CONFIG_GET(string/server_desc)
#define SS13LIB_SERVER_LINKS list(list("type" = "web", "link"= CONFIG_GET(string/weburl)), \
									list("type" = "wiki", "link" = CONFIG_GET(string/wikiurl)), \
									list("type" = "github", "link" = CONFIG_GET(string/githuburl)), \
									list("type" = "rules", "link" = CONFIG_GET(string/rulesurl)), \
									list("type" = "discord", "link" = CONFIG_GET(string/discordurl)))

#define SS13LIB_ENGINE_MIN_VERSION "[CONFIG_GET(number/client_error_version)].[CONFIG_GET(number/client_error_build)]"
//#define SS13LIB_ENGINE_MAX_VERSION
//#define SS13LIB_ENGINE_BLACKLISTED_VERSIONS

#define SS13LIB_ROUND_MAP_NAME GLOB.station_name
//#define SS13LIB_ROUND_STARTED_AT_BYOND SSticker?.round_start_time
#define SS13LIB_ROUND_STARTED_AT_UNIX SSticker?.round_start_unix
#define SS13LIB_ROUND_SECURITY_LEVEL get_security_level()
#define SS13LIB_ROUND_ID GLOB.round_id
#define SS13LIB_ROUND_GAMEMODE "secret"
#define SS13LIB_ROUND_STATE SSticker ? SSticker.get_ss13hub_status() : "initializing"

#define SS13LIB_CLIENT_INFO(X) X.hub_info

#define SS13LIB_MESSAGE_ADMINS(X) message_admins(X)
#define SS13LIB_INFO_LOG(message) log_world("SS13Hub Info: [##message]")
#define SS13LIB_WARNING_LOG(message) log_world("SS13Hub Warn: [##message]")
#define SS13LIB_ERROR_LOG(message) log_world("SS13Hub Error: [##message]")

//Needs rust_g 6.2.0
//#define SS13LIB_ATTEST_DOMAIN CONFIG_GET(string/verified_domain)
//#define SS13LIB_ATTEST_PRIVKEY CONFIG_GET(string/verified_private_key)
//#define SS13LIB_ED25519_SIGN(privkey, message) rustg_ed25519_sign(privkey, message)
//#define SS13LIB_UNIX_EPOCH rustg_unix_timestamp()
