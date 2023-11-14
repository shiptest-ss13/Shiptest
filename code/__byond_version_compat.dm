// This file contains defines allowing targeting byond versions newer than the supported

//Update this whenever you need to take advantage of more recent byond features
#define MIN_COMPILER_VERSION 515
#define MIN_COMPILER_BUILD 1609
#if (DM_VERSION < MIN_COMPILER_VERSION || DM_BUILD < MIN_COMPILER_BUILD) && !defined(SPACEMAN_DMM)
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to https://secure.byond.com/download and update.
#error You need version 515.1609 or higher
#endif

// Keep savefile compatibilty at minimum supported level
#if DM_VERSION >= 515
/savefile/byond_version = 514 //TODO: Make this MIN_COMPILER_VERSION before merge
#endif

// 515 split call for external libraries into call_ext
#if DM_VERSION < 515
#define LIBCALL call
#else
#define LIBCALL call_ext
#endif

// So we want to have compile time guarantees these procs exist on local type, unfortunately 515 killed the .proc/procname syntax so we have to use nameof()
#if DM_VERSION < 515
/// Call by name proc reference, checks if the proc exists on this type or as a global proc
#define PROC_REF(X) (.proc/##X)
/// Call by name proc reference, checks if the proc exists on given type or as a global proc
#define TYPE_PROC_REF(TYPE, X) (##TYPE.proc/##X)
/// Call by name proc reference, checks if the proc is existing global proc
#define GLOBAL_PROC_REF(X) (/proc/##X)
#else
/// Call by name proc reference, checks if the proc exists on this type or as a global proc
#define PROC_REF(X) (nameof(.proc/##X))
/// Call by name proc reference, checks if the proc exists on given type or as a global proc
#define TYPE_PROC_REF(TYPE, X) (nameof(##TYPE.proc/##X))
/// Call by name proc reference, checks if the proc is existing global proc
#define GLOBAL_PROC_REF(X) (/proc/##X)
#endif

// I heard that this was fixed in 1609 (not public currently), but that could be wrong, so keep an eye on this
#if (DM_VERSION == 515 && DM_BUILD < 1609)
/// fcopy will crash on 515 linux if given a non-existant file, instead of returning 0 like on 514 linux or 515 windows
/// var case matches documentation for fcopy.
/world/proc/__fcopy(Src, Dst)
	if (!fexists(Src))
		return 0
	return fcopy(Src, Dst)

#define fcopy(Src, Dst) world.__fcopy(Src, Dst)

#endif
