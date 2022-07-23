/datum/research_node/medical/imp_wt_surgery
	node_id = "imp_wt_surgery"
	name = "Improved Wound-Tending Surgery"
	description = "Who would have known being more gentle with a hemostat decreases patient pain?"
	requisite_nodes = list("biotech")
	designs = list(
		"surgery_heal_brute_upgrade",
		"surgery_heal_burn_upgrade",
	)

/datum/research_node/medical/adv_surgery
	node_id = "adv_surgery"
	name = "Advanced Surgery"
	description = "When simple medicine doesn't cut it."
	requisite_nodes = list("imp_wt_surgery")
	designs = list(
		"surgery_lobotomy",
		"surgery_heal_brute_upgrade_femto",
		"surgery_heal_burn_upgrade_femto",
		"surgery_heal_combo",
		"surgery_adv_dissection",
	)

/datum/research_node/medical/exp_surgery
	node_id = "exp_surgery"
	name = "Experimental Surgery"
	description = "When evolution isn't fast enough."
	requisite_nodes = list("adv_surgery")
	designs = list(
		"surgery_pacify",
		"surgery_vein_thread",
		"surgery_muscled_veins",
		"surgery_nerve_splice",
		"surgery_nerve_ground",
		"surgery_ligament_hook",
		"surgery_ligament_reinforcement",
		"surgery_viral_bond",
		"surgery_heal_combo_upgrade",
		"surgery_exp_dissection",
		"surgery_cortex_imprint",
		"surgery_cortex_folding",
	)

/datum/research_node/medical/alien_surgery
	node_id = "alien_surgery"
	name = "Alien Surgery"
	description = "Abductors did nothing wrong."
	requisite_nodes = list("exp_surgery", "alientech")
	designs = list(
		"surgery_brainwashing",
		"surgery_zombie",
		"surgery_heal_combo_upgrade_femto",
		"surgery_ext_dissection",
	)
