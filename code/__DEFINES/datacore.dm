#define DATACORE_ID "id"
#define DATACORE_RANK "rank"
#define DATACORE_INITIAL_RANK "initial_rank"
#define DATACORE_NAME "name"
#define DATACORE_AGE "age"
#define DATACORE_GENDER "gender"
#define DATACORE_SPECIES "species"

#define DATACORE_APPEARANCE "character_appearance"
#define DATACORE_NOTES "notes"

#define DATACORE_PHYSICAL_HEALTH "p_stat"
#define DATACORE_MENTAL_HEALTH "m_stat"

#define DATACORE_BLOOD_TYPE "blood_type"
#define DATACORE_BLOOD_DNA "b_dna"
#define DATACORE_DISEASES "cdi"
#define DATACORE_DISEASES_DETAILS "cdi_d"
#define DATACORE_DISABILITIES "ma_dis"
#define DATACORE_DISABILITIES_DETAILS "ma_dis_d"
#define DATACORE_NOTES_MEDICAL "medical_note"

#define DATACORE_FINGERPRINT "fingerprint"
#define DATACORE_CRIMES "crim"
#define DATACORE_CRIMINAL_STATUS "criminal"
#define DATACORE_NOTES_SECURITY "security_note"

//Not very used
#define DATACORE_IMAGE "image"
#define DATACORE_DNA_IDENTITY "identity"
#define DATACORE_DNA_FEATURES "features"
#define DATACORE_MINDREF "mind"

/// Keys for SSdatacore.library
#define DATACORE_RECORDS_OUTPOST "outpost"
//#define DATACORE_RECORDS_SECURITY "security"
//#define DATACORE_RECORDS_MEDICAL "medical"
//#define DATACORE_RECORDS_LOCKED "locked"


/// Physical statuses
#define PHYSICAL_ACTIVE "Active"
#define PHYSICAL_DEBILITATED "Debilitated"
#define PHYSICAL_UNCONSCIOUS "Unconscious"
#define PHYSICAL_DECEASED "Deceased"

/// List of available physical statuses
#define PHYSICAL_STATUSES list(\
	PHYSICAL_ACTIVE, \
	PHYSICAL_DEBILITATED, \
	PHYSICAL_UNCONSCIOUS, \
	PHYSICAL_DECEASED, \
)

/// Mental statuses
#define MENTAL_STABLE "Stable"
#define MENTAL_WATCH "Watch"
#define MENTAL_UNSTABLE "Unstable"
#define MENTAL_INSANE "Insane"

/// List of available mental statuses
#define MENTAL_STATUSES list(\
	MENTAL_STABLE, \
	MENTAL_WATCH, \
	MENTAL_UNSTABLE, \
	MENTAL_INSANE, \
)

/// Wanted statuses
#define WANTED_ARREST "Arrest"
#define WANTED_DISCHARGED "Discharged"
#define WANTED_NONE "None"
#define WANTED_PAROLE "Parole"
#define WANTED_PRISONER "Incarcerated"
#define WANTED_SUSPECT "Suspected"

/// List of available wanted statuses
#define WANTED_STATUSES list(\
	WANTED_NONE, \
	WANTED_SUSPECT, \
	WANTED_ARREST, \
	WANTED_PRISONER, \
	WANTED_PAROLE, \
	WANTED_DISCHARGED, \
)
