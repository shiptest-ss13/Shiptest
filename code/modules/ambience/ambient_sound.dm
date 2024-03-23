/datum/ambient_sound
	/// ID of the ambient sound.
	var/id
	/// Paths to the sounds to be picked from.
	var/list/sounds
	/// Volume of the ambient sound to be played.
	var/volume = 25
	/// Maximum range an ambient sound may play from.
	var/range = 5
	/// How many ambience emitters can be playing this at once.
	var/maximum_emitters = 1
	/// How often does the sound play. In seconds.For looping sounds it will update their emitter state faster if lower than length
	var/frequency_time = 5 SECONDS
	/// If defined, frequency will be randomized with this being the upper bound
	var/frequency_time_high
	/// How long does the sound play for.
	var/sound_length = 5 SECONDS
	/// Whether we let byond change the pitch of the played sounds
	var/vary = FALSE
	/// If defined, cooldown between playing a sound between ALL emitters. Dont set this higher than `frequency_time`
	var/cooldown_between_emitters
	/// Whether the ambient sound tries to behave like a loop. Area based ambient emitters can have their frequency multiplied if FALSE.
	var/loops = TRUE
	/// Falloff distance to pass to the played sound
	var/falloff_distance = AMBIENCE_FALLOFF_DISTANCE
	/// Falloff exponent to pass to the played sound
	var/falloff_exponent = AMBIENCE_FALLOFF_EXPONENT
	/// Whether to play the sound from a random position around the user if an area invokes it
	var/random_position_if_area = FALSE //Not implemented yet
