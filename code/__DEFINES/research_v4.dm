// dont go below 1 please, these are list indexes

#define TECHTYPE_ENGINEERING 1
#define TECHTYPE_SCIENCE 2
#define TECHTYPE_SERVICE 3
#define TECHTYPE_SECURITY 4
#define TECHTYPE_MEDICAL 5
#define TECHTYPE_NANITE 6
#define TECHTYPE_ADMIN 7
/// should be equal to the highest index for techtypes
#define TECHTYPE_MAX TECHTYPE_ADMIN

#define TECHLEVEL_NONE 1
#define TECHLEVEL_SIMPLE 2
#define TECHLEVEL_BASIC 3
#define TECHLEVEL_INTERMEDIATE 4
#define TECHLEVEL_ADVANCED 5
#define TECHLEVEL_STELLAR 6
#define TECHLEVEL_ALIEN 7
#define TECHLEVEL_ADMIN 8
#define TECHLEVEL_HIGHEST TECHLEVEL_ADMIN

/proc/techlevel_to_string(techlevel)
	switch(techlevel)
		if(TECHLEVEL_NONE)
			return "None"
		if(TECHLEVEL_SIMPLE)
			return "Simple"
		if(TECHLEVEL_BASIC)
			return "Basic"
		if(TECHLEVEL_INTERMEDIATE)
			return "Intermediate"
		if(TECHLEVEL_ADVANCED)
			return "Advanced"
		if(TECHLEVEL_STELLAR)
			return "Stellar"
		if(TECHLEVEL_ALIEN)
			return "Alien"
		if(TECHLEVEL_ADMIN)
			return "Admin"
	CRASH("unknown techlevel")

/proc/techtype_to_string(techtype)
	switch(techtype)
		if(TECHTYPE_ENGINEERING)
			return "Engineering"
		if(TECHTYPE_SCIENCE)
			return "Science"
		if(TECHTYPE_SERVICE)
			return "Service"
		if(TECHTYPE_SECURITY)
			return "Security"
		if(TECHTYPE_MEDICAL)
			return "Medical"
		if(TECHTYPE_ADMIN)
			return "Admin"
	CRASH("unknown techtype")
