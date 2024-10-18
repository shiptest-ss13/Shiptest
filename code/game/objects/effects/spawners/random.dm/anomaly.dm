/obj/effect/spawner/random/anomaly
	name = "random anomaly spawner"
	icon_state = "anomaly"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
		/obj/effect/anomaly/transfusion/planetary,
	)

/obj/effect/spawner/random/anomaly/safe
	name = "relatively safe anomaly spawner"
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/transfusion/planetary,
	)

/obj/effect/spawner/random/anomaly/dangerous
	name = "relatively dangerous anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/big
	name = "random big anomaly spawner"
	icon_state = "big_anomaly"
	loot = list(
		/obj/effect/anomaly/bluespace/big/planetary,
		/obj/effect/anomaly/flux/big/planetary,
		/obj/effect/anomaly/grav/high/big/planetary,
		/obj/effect/anomaly/pyro/big/planetary

	)

//handpicked lists relevant to the planets they're on
// /cave lists are made for spawning in cave biomes. Not every anomaly goes well there. We don't have enough anomalies to really populate them all though

/obj/effect/spawner/random/anomaly/jungle
	name = "Jungle Anomaly Spawner"
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/random/anomaly/jungle/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

//beaches don't currently have anomalies, but I don't see a reason why they couldn't have *some*

/obj/effect/spawner/random/anomaly/beach
	name = "Beach anomaly spawner"
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/random/anomaly/beach/cave
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/random/anomaly/sand
	name = "Sand anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/sand/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/rock
	name = "Rock anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/rock/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/lava
	name = "Lava anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
	)

/obj/effect/spawner/random/anomaly/lava/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
	)

/obj/effect/spawner/random/anomaly/ice
	name = "Ice anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/random/anomaly/ice/cave
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/random/anomaly/waste
	name = "Waste anomaly spawner"
	loot = list(
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/waste/cave
	loot = list(
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/random/anomaly/storm
	loot = list(
		/obj/effect/anomaly/flux/storm,
		/obj/effect/anomaly/pyro/storm,
		/obj/effect/anomaly/sparkler,
		/obj/effect/anomaly/veins,
		/obj/effect/anomaly/phantom,
		/obj/effect/anomaly/melter,
	)
