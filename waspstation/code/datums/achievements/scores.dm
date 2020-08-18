/datum/award/score/metacoins
	name = "Currency"
	desc = "Total accumulated \"wealth.\""

/datum/award/score/metacoins/New()
	. = ..()
	name = "[CONFIG_GET(string/metacurrency_name)]\s"

/datum/award/score/metacoins/LoadHighScores()
	var/datum/DBQuery/Q = SSdbcore.NewQuery(
		"SELECT ckey,metacoins FROM [format_table_name("player")] ORDER BY metacoins DESC LIMIT 50"
	)
	if(!Q.Execute(async = TRUE))
		qdel(Q)
		return
	else
		while(Q.NextRow())
			var/key = Q.item[1]
			var/score = text2num(Q.item[2])
			high_scores[key] = score
		qdel(Q)
