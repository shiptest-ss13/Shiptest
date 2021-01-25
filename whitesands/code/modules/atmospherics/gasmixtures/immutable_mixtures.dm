//used by cloners
/datum/gas_mixture/immutable/cloner
	initial_temperature = T20C

/datum/gas_mixture/immutable/cloner/populate()
	set_moles(/datum/gas/nitrogen, MOLES_O2STANDARD + MOLES_N2STANDARD)
