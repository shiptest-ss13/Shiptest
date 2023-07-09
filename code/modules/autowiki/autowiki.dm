/// When the `AUTOWIKI` define is enabled, will generate an output file for tools/autowiki/autowiki.js to consume.
/// Autowiki code intentionally still *exists* even without the define, to ensure developers notice
/// when they break it immediately, rather than until CI or worse, call time.
#if defined(AUTOWIKI) || defined(UNIT_TESTS)
/proc/setup_autowiki()
	Master.sleep_offline_after_initializations = FALSE
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, /proc/generate_autowiki))
	SSticker.start_immediately = TRUE
	CONFIG_SET(number/round_end_countdown, 0)

/proc/generate_autowiki()
	var/output = generate_autowiki_output()
	rustg_file_write(output, "data/autowiki_edits.txt")
	qdel(world)
#endif

/// Returns a string of the autowiki output file
/proc/generate_autowiki_output()
	var/total_output = ""

	for (var/datum/autowiki/autowiki_type as anything in subtypesof(/datum/autowiki))
		var/datum/autowiki/autowiki = new autowiki_type
		var/output = autowiki.generate()

		//Generates a page for each key:value pair with the key as the title and the value as the content, and generates an index at the root page
		if(islist(output))
			var/root = ""
			for(var/title in output)
				total_output += json_encode(list(
					"title" = "[autowiki.page]/[title]",
					"text" = output[title],
				)) + "\n"
				root += "\n\n" + autowiki.include_template("[autowiki.page]/[title]")

			//Run the next conditional
			output = root

		//Generates a single page with the output.
		if (istext(output))
			total_output += json_encode(list(
				"title" = autowiki.page,
				"text" = output,
			)) + "\n"

			continue

		CRASH("[autowiki_type] does not generate a proper output!")

	return total_output
