GLOBAL_LIST_INIT(premade_news_stories, list(\
	list("title" = "She did WHAT to the Money?", "msg" = "Outpost authorities are reportedly in shock as NGR Economic Kommissar \"Frau Erika\" has got \"Funny With The Money\" once again, leaving independent spacers bankrupt. Gezenan economists have begun calling this situation \"Poverty Two\", as factional groups scramble to consolidate their assets. Somehow, the Gorlex Hardliners are still fielding six Gygaxes at any given time."),\
	list("title" = "Out of the Frying Pan?", "msg" = "Signs of local conflict approach as an Inteq mercenary is detained by the unruly and allegedly infant-hungry outpost security. No further details are known, other than that Vanguard Ciex'nori is pissed the fuck off and intending to, quote: \"Shoot some bureaucrats in the back of their heads, watch the red goo spew out. Real hardcore shit, fucked up style. We genuinely have too much ammo and not nearly enough busted heads. Worse than what we did to the fuckin\' Indies.\" How this situation will play out is uncertain to us.")\
))

/datum/round_event_control/news_report
	name = "News Report"
	typepath = /datum/round_event/news_report
	weight = 5
	max_occurrences = 2
	min_players = 1
	earliest_start = 5 MINUTES

/datum/round_event_control/news_report/can_spawn_event(players, gamemode)
	if(!length(GLOB.premade_news_stories))
		return FALSE

/datum/round_event/news_report

/datum/round_event/news_report/start()
	var/list/random_story = pick(GLOB.premade_news_stories)
	GLOB.premade_news_stories -= random_story
	GLOB.news_network.SubmitArticle(random_story["msg"], "Unknown", "Colonial Announcement Network")


