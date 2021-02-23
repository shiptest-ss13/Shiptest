/datum/computer_file/program/account_management
	filename = "acct_manage"
	filedesc = "Bank Account Manager"
	program_icon_state = "id"
	program_icon = "bank"
	extended_desc = "This program allows the review and control of all the station's active bank accounts."
	transfer_access = ACCESS_VAULT
	required_access = ACCESS_VAULT
	requires_ntnet = TRUE
	size = 4
	tgui_id = "NtosAcctManager"

/datum/computer_file/program/account_management/ui_data(mob/user)
	var/list/data = get_header_data()
	var/list/accounts = list()
	for(var/a in SSeconomy.bank_accounts)
		var/datum/bank_account/account = a
		accounts += list(list(
			"id" = account.account_id,
			"holder" = account.account_holder,
			"balance" = account.account_balance,
			"job" = account.account_job?.title,
			"ref" = REF(account)
		))
	data["accounts"] = accounts
	return data

/datum/computer_file/program/account_management/ui_static_data(mob/user)
	var/list/data = list()
	var/obj/item/card/id/user_id = user.get_idcard(TRUE)
	var/list/jobs = list()
	for(var/j in SSjob.occupations)
		var/datum/job/job = j
		jobs += job.title
	data["jobs"] = jobs
	data["authed"] = (ACCESS_CHANGE_IDS in user_id?.GetAccess())
	return data

/datum/computer_file/program/account_management/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return
	var/mob/user = usr
	var/obj/item/card/id/user_id = user.get_idcard(TRUE)
	switch(action)
		if("PRG_new_account")
			var/datum/job/selected_job = SSjob.name_occupations[params["acct_job"]] || /datum/job/assistant
			var/datum/bank_account/new_acct = new /datum/bank_account(params["acct_holder"], new selected_job.type)
			if(text2num(params["acct_id"]))
				new_acct.account_id = clamp(text2num(params["acct_id"]), 111111, 999999)
			return TRUE
	if(ACCESS_CHANGE_IDS in user_id?.GetAccess())
		var/datum/bank_account/account_to_change = locate(params["selected_account"])
		switch(action)
			if("PRG_close_account")
				QDEL_NULL(account_to_change)
				return TRUE
			if("PRG_change_holder")
				account_to_change.account_holder = params["new_holder"]
				return TRUE
			if("PRG_change_id")
				account_to_change.account_id = clamp(text2num(params["new_id"]), 111111, 999999)
				return TRUE
			if("PRG_change_job")
				var/datum/job/selected_job = SSjob.name_occupations[params["new_job"]]
				if(selected_job)
					account_to_change.account_job = new selected_job.type
					return TRUE
				return FALSE
