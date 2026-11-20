/datum/instrument/piano
	name = "Generic piano"
	category = "Piano"
	abstract_type = /datum/instrument/piano

/datum/instrument/piano/fluid_piano
	name = "FluidR3 Grand Piano"
	id = "r3grand"
	real_samples = list(
		"36"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c5.ogg',
		"84"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c6.ogg',
		"96"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c7.ogg',
		"108"='sound/runtime/instruments/synthesis_samples/piano/fluid_piano/c8.ogg')

/datum/instrument/piano/fluid_harpsichord
	name = "FluidR3 Harpsichord"
	id = "r3harpsi"
	real_samples = list(
		"36"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c5.ogg',
		"84"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c6.ogg',
		"96"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c7.ogg',
		"108"='sound/runtime/instruments/synthesis_samples/piano/fluid_harpsi/c8.ogg')

/datum/instrument/piano/salamander_grand
	name = "Salamander Grand Piano"
	id = "salamander"
	real_samples = list(
		"21"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a0.ogg',
		"24"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c1.ogg',
		"27"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds1.ogg',
		"30"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs1.ogg',
		"33"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a1.ogg',
		"36"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c2.ogg',
		"39"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds2.ogg',
		"42"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs2.ogg',
		"45"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c3.ogg',
		"51"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds3.ogg',
		"54"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs3.ogg',
		"57"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c4.ogg',
		"63"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds4.ogg',
		"66"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs4.ogg',
		"69"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c5.ogg',
		"75"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds5.ogg',
		"78"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs5.ogg',
		"81"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a5.ogg',
		"84"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c6.ogg',
		"87"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds6.ogg',
		"90"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs6.ogg',
		"93"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a6.ogg',
		"96"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c7.ogg',
		"99"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/ds7.ogg',
		"102"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/fs7.ogg',
		"105"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/a7.ogg',
		"108"='sound/runtime/instruments/synthesis_samples/piano/salamander_grand_piano/c8.ogg')
	volume_multiplier = 0.51		//a bit louder than the default 0.33

/datum/instrument/piano/crisis_harpsichord
	name = "Crisis Harpsichord"
	id = "crharpsi"
	real_samples = list(
		"36"='sound/runtime/instruments/synthesis_samples/piano/crisis_harpsichord/c2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/crisis_harpsichord/c3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/crisis_harpsichord/c4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/crisis_harpsichord/c5.ogg')

/datum/instrument/piano/crisis_grandpiano_uni
	name = "Crisis Grand Piano One"
	id = "crgrand1"
	real_samples = list(
		"36"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c5.ogg',
		"84"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c6.ogg',
		"96"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c7.ogg',
		"108"='sound/runtime/instruments/synthesis_samples/piano/crisis_grand_piano/c8.ogg')

/datum/instrument/piano/crisis_brightpiano_uni
	name = "Crisis Bright Piano One"
	id = "crbright1"
	real_samples = list(
		"36"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c2.ogg',
		"48"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c3.ogg',
		"60"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c4.ogg',
		"72"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c5.ogg',
		"84"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c6.ogg',
		"96"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c7.ogg',
		"108"='sound/runtime/instruments/synthesis_samples/piano/crisis_bright_piano/c8.ogg')
