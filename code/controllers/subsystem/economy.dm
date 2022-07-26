SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_GAME
	var/roundstart_paychecks = 5
	var/budget_pool = 35000
	var/list/department_accounts = list(ACCOUNT_CIV = ACCOUNT_CIV_NAME,
										ACCOUNT_ENG = ACCOUNT_ENG_NAME,
										ACCOUNT_SCI = ACCOUNT_SCI_NAME,
										ACCOUNT_MED = ACCOUNT_MED_NAME,
										ACCOUNT_SRV = ACCOUNT_SRV_NAME,
										ACCOUNT_CAR = ACCOUNT_CAR_NAME,
										ACCOUNT_SEC = ACCOUNT_SEC_NAME)
	var/list/generated_accounts = list()
	var/full_ancap = FALSE // Enables extra money charges for things that normally would be free, such as sleepers/cryo/cloning.
							//Take care when enabling, as players will NOT respond well if the economy is set up for low cash flows.
	var/slime_bounty = list("grey" = 10,
							// tier 1
							"orange" = 100,
							"metal" = 100,
							"blue" = 100,
							"purple" = 100,
							// tier 2
							"dark purple" = 500,
							"dark blue" = 500,
							"green" = 500,
							"silver" = 500,
							"gold" = 500,
							"yellow" = 500,
							"red" = 500,
							"pink" = 500,
							// tier 3
							"cerulean" = 750,
							"sepia" = 750,
							"bluespace" = 750,
							"pyrite" = 750,
							"light pink" = 750,
							"oil" = 750,
							"adamantine" = 750,
							// tier 4
							"rainbow" = 1000)
	var/list/bank_accounts = list() //List of normal accounts (not department accounts)
	var/list/dep_cards = list()

/datum/controller/subsystem/economy/Initialize(timeofday)
	var/budget_to_hand_out = round(budget_pool / department_accounts.len)
	for(var/A in department_accounts)
		new /datum/bank_account/department(A, budget_to_hand_out)
	return ..()

/datum/controller/subsystem/economy/proc/get_dep_account(dep_id)
	for(var/datum/bank_account/department/D in generated_accounts)
		if(D.department_id == dep_id)
			return D
