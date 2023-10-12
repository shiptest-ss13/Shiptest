#define TOGGLES_DEFAULT_MODULAR NONE

///Makes the organ not pop out when dismembered
#define ORGAN_NO_DISMEMBERMENT		(1<<7)

#define GENITAL_SKIP_VISIBILITY 0
#define GENITAL_NEVER_SHOW 1
#define GENITAL_HIDDEN_BY_CLOTHES 2
#define GENITAL_ALWAYS_SHOW 3



//All bodytypes
#define ALL_BODYTYPES (\
	BODYTYPE_HUMANOID|\
	BODYTYPE_DIGITIGRADE|\
	BODYTYPE_TAUR_SNAKE|\
	BODYTYPE_TAUR_PAW|\
	BODYTYPE_TAUR_HOOF|\
	BODYTYPE_VOX|\
	BODYTYPE_TESHARI\
	)
//Bodytypes *mostly* resembling a humanoid, this is set on things by default
#define GENERIC_BODYTYPES (\
	BODYTYPE_HUMANOID|\
	BODYTYPE_DIGITIGRADE|\
	BODYTYPE_TAUR_SNAKE|\
	BODYTYPE_TAUR_PAW|\
	BODYTYPE_TAUR_HOOF|\
	BODYTYPE_VOX\
	)

#define BODYTYPE_TRANSLATION_LIST list(\
		"[BODYTYPE_HUMANOID]" = "human",\
		"[BODYTYPE_DIGITIGRADE]" = "digi",\
		"[BODYTYPE_TAUR_SNAKE]" = "taursnake",\
		"[BODYTYPE_TAUR_PAW]" = "taurpaw",\
		"[BODYTYPE_TAUR_HOOF]" = "taurhoof",\
		"[BODYTYPE_VOX]" = "vox",\
		"[BODYTYPE_TESHARI]" = "teshari"\
		)

//flags for outfits that have mutant variants: Most of these require additional sprites to work.
#define BODYTYPE_TAUR_SNAKE (1<<7) //taur-friendly suits
#define BODYTYPE_TAUR_PAW (1<<8)
#define BODYTYPE_TAUR_HOOF (1<<9)
#define BODYTYPE_TAUR_COMMON (BODYTYPE_TAUR_SNAKE|BODYTYPE_TAUR_PAW)
#define BODYTYPE_TAUR_ALL (BODYTYPE_TAUR_SNAKE|BODYTYPE_TAUR_PAW|BODYTYPE_TAUR_HOOF)
#define BODYTYPE_TESHARI (1<<10) //fuck teshari for the record

#define TAUR_SNAKE_VARIATION (1<<5) //taur-friendly suits
#define TAUR_PAW_VARIATION (1<<6)
#define TAUR_HOOF_VARIATION (1<<7)
#define TAUR_ALL_VARIATION (TAUR_SNAKE_VARIATION|TAUR_PAW_VARIATION|TAUR_HOOF_VARIATION)
