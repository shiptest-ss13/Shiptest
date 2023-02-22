//Service modules for MODsuits

///Bike Horn - Plays a bike horn sound.
/obj/item/mod/module/bikehorn
	name = "модуль клаксона"
	desc = "Модуль размещает на плече тяжелую звуковую артиллерию, которая использует лучшую технологию фемто-манипулятора для \
		почти смертельного сжатия... клаксона велосипеда, создавая всем знакомый звук."
	icon_state = "bikehorn"
	module_type = MODULE_USABLE
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/bikehorn)
	cooldown_time = 1 SECONDS

/obj/item/mod/module/bikehorn/on_use()
	. = ..()
	if(!.)
		return
	playsound(src, 'sound/items/bikehorn.ogg', 100, FALSE)
	drain_power(use_power_cost)

///Microwave Beam - Microwaves items instantly.
/obj/item/mod/module/microwave_beam
	name = "модуль микроволнового луча"
	desc = "Специальный микроволновый эмиттер, установленный в ладонях пользователя, \
	позволяет разогревать пищу на расстоянии. Не рекомендуется для использования против винограда."
	icon_state = "microwave_beam"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_power_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/microwave_beam, /obj/item/mod/module/organ_thrower)
	cooldown_time = 10 SECONDS

/obj/item/mod/module/microwave_beam/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!istype(target, /obj/item))
		return
	if(!isturf(target.loc))
		balloon_alert(mod.wearer, "Должен быть на полу!")
		return
	var/obj/item/microwave_target = target
	var/datum/effect_system/spark_spread/spark_effect = new()
	spark_effect.set_up(2, 1, mod.wearer)
	spark_effect.start()
	mod.wearer.Beam(target,icon_state="lightning[rand(1,12)]", time = 5)
	if(microwave_target.microwave_act())
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, FALSE)
	else
		balloon_alert(mod.wearer, "Не может быть нагрет!")
	var/datum/effect_system/spark_spread/spark_effect_two = new()
	spark_effect_two.set_up(2, 1, microwave_target)
	spark_effect_two.start()
	drain_power(use_power_cost)

//Waddle - Makes you waddle and squeak.
/obj/item/mod/module/waddle
	name = "модуль неуклюжей ходьбы"
	desc = "Некоторая из самых примитивных технологий, используемых Хонк Ко. \
		Фотонный вычислительный блок управления с точностью до милиметра предсказывает следующий шаг. \
		Эти данные использует двойной гравитационный диск для возникновения миниатюрных эфирных ударных волн времени-пространства \
		что позволяет пользователю... шататься в стороны, подпрыгивая с каждым шагом."
	icon_state = "waddle"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/waddle)

/obj/item/mod/module/waddle/on_suit_activation()
	mod.boots.AddComponent(/datum/component/squeak, list('sound/effects/clownstep1.ogg'=1,'sound/effects/clownstep2.ogg'=1), 50, falloff_exponent = 20) //die off quick please
	mod.wearer.AddElement(/datum/element/waddling)
	//if(mod.wearer.mind?.assigned_role == JOB_CLOWN)
	//	SEND_SIGNAL(mod.wearer, COMSIG_ADD_MOOD_EVENT, "clownshoes", /datum/mood_event/clownshoes)

/obj/item/mod/module/waddle/on_suit_deactivation(deleting = FALSE)
	if(!deleting)
		qdel(mod.boots.GetComponent(/datum/component/squeak))
	mod.wearer.RemoveElement(/datum/element/waddling)
	//if(mod.wearer.mind?.assigned_role == JOB_CLOWN)
	//	SEND_SIGNAL(mod.wearer, COMSIG_CLEAR_MOOD_EVENT, "clownshoes")
