SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_GAME

	///List of normal accounts (not ship accounts)
	var/list/bank_accounts = list()
	///Total amount of physical money in the game
	var/physical_money = 0
	///Total amount of money in bank accounts
	var/bank_money = 0

/datum/controller/subsystem/economy/stat_entry(msg)
	msg += "{"
	msg += "PH: [physical_money]|"
	msg += "BN: [bank_money]|"
	msg += "TOT: [physical_money + bank_money]"
	msg += "}"
	return ..()
