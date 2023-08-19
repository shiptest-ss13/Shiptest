/// Bare minimum required verbs for client functionality
GLOBAL_LIST_INIT(client_verbs_required, list(
	// Stat panel internal verbs
	/client/verb/set_tab,
	/client/verb/send_tabs,
	/client/verb/remove_tabs,
	/client/verb/reset_tabs,
	/client/verb/panel_ready,
	// Skin buttons that should always work
	/client/verb/rules,
	/client/verb/forum,
	/client/verb/github,
	/client/verb/joindiscord,
	// Admin help
	/client/verb/adminhelp,
))
