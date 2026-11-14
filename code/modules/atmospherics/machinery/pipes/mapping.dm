//Colored pipes, use these for mapping

#define HELPER_PARTIAL(Fulltype, Type, Iconbase, Color) \
	##Fulltype {						\
		pipe_color = Color;				\
		color = Color;					\
	}									\
	##Fulltype/visible {				\
		hide = FALSE;					\
		layer = GAS_PIPE_VISIBLE_LAYER;	\
		FASTDMM_PROP(pipe_group = "atmos-[piping_layer]-"+Type+"-visible");\
	}									\
	##Fulltype/visible/layer2 {			\
		piping_layer = 2;				\
		icon_state = Iconbase + "-2";	\
	}									\
	##Fulltype/visible/layer4 {			\
		piping_layer = 4;				\
		icon_state = Iconbase + "-4";	\
	}									\
	##Fulltype/visible/layer1 {			\
		piping_layer = 1;				\
		icon_state = Iconbase + "-1";	\
	}									\
	##Fulltype/visible/layer5 {			\
		piping_layer = 5;				\
		icon_state = Iconbase + "-5";	\
	}									\
	##Fulltype/hidden {					\
		hide = TRUE;					\
		FASTDMM_PROP(pipe_group = "atmos-[piping_layer]-"+Type+"-hidden");\
	}									\
	##Fulltype/hidden/layer2 {			\
		piping_layer = 2;				\
		icon_state = Iconbase + "-2";	\
	}									\
	##Fulltype/hidden/layer4 {			\
		piping_layer = 4;				\
		icon_state = Iconbase + "-4";	\
	}									\
	##Fulltype/hidden/layer1 {			\
		piping_layer = 1;				\
		icon_state = Iconbase + "-1";	\
	}									\
	##Fulltype/hidden/layer5 {			\
		piping_layer = 5;				\
		icon_state = Iconbase + "-5";	\
	}

#define HELPER_PARTIAL_NAMED(Fulltype, Type, Iconbase, Color, Name) \
	HELPER_PARTIAL(Fulltype, Type, Iconbase, Color)	\
	##Fulltype {								\
		name = Name;							\
	}

#define HELPER(Type, Color) \
	HELPER_PARTIAL(/obj/machinery/atmospherics/pipe/simple/##Type, #Type, "pipe11", Color) 			\
	HELPER_PARTIAL(/obj/machinery/atmospherics/pipe/manifold/##Type, #Type, "manifold", Color)		\
	HELPER_PARTIAL(/obj/machinery/atmospherics/pipe/manifold4w/##Type, #Type, "manifold4w", Color)

#define HELPER_NAMED(Type, Name, Color) \
	HELPER_PARTIAL_NAMED(/obj/machinery/atmospherics/pipe/simple/##Type, #Type, "pipe11", Color, Name) 			\
	HELPER_PARTIAL_NAMED(/obj/machinery/atmospherics/pipe/manifold/##Type, #Type, "manifold", Color, Name)		\
	HELPER_PARTIAL_NAMED(/obj/machinery/atmospherics/pipe/manifold4w/##Type, #Type, "manifold4w", Color, Name)

HELPER(general, null)
HELPER(yellow, "#fff957")
HELPER(cyan, "#60d5fc")
HELPER(green, "#8cff75")
HELPER(orange, "#ff904f")
HELPER(purple, "#ed69ff")
HELPER(dark, "#898aad")
HELPER(brown, "#a65326")
HELPER(violet, "#6640ff")

HELPER_NAMED(scrubbers, "scrubbers pipe", "#ff3030")
HELPER_NAMED(supply, "air supply pipe", "#5c7fff")
HELPER_NAMED(supplymain, "main air supply pipe", "#9565fc")


#undef HELPER_NAMED
#undef HELPER
#undef HELPER_PARTIAL_NAMED
#undef HELPER_PARTIAL
