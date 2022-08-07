/datum/research_design/board
	abstract = /datum/research_design/board
	costs = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
	)
	var/board_path

/datum/research_design/make_output(atom/output_loc)
	var/atom/movable/board = new board_path(null)
	board.forceMove(output_loc)
