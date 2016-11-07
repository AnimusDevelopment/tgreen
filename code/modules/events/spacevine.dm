/datum/round_event_control/spacevine
	name = "Spacevine"
	typepath = /datum/round_event/spacevine
	weight = 15
	max_occurrences = 3

/datum/round_event/spacevine/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	for(var/area/hallway/A in world)
		for(var/turf/simulated/F in A)
			if(!F.density && F.contents.len < 2)  //becose /atom/movable/light
				turfs += F

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/simulated/T = pick(turfs)
		new/obj/effect/spacevine_controller(T) //spawn a controller at turf //I have no ideas why spawn(0) was here, but it shouldn't do anything useful, so i delite it.


/* MUTATIONS */

/datum/spacevine_mutation
	var/name = ""
	var/ID = ""
	var/severity = 1
	var/hue
	var/quality
	var/list/gen_conflict = list()//so mutations with oposite effects will remove each other

/datum/spacevine_mutation/proc/process_mutation(obj/effect/spacevine/holder)
	return 0

/datum/spacevine_mutation/proc/process_temperature(obj/effect/spacevine/holder, temp, volume)
	return 0

/datum/spacevine_mutation/proc/on_birth(obj/effect/spacevine/holder)
	return 0

/datum/spacevine_mutation/proc/on_grow(obj/effect/spacevine/holder)
	return 0

/datum/spacevine_mutation/proc/on_death(obj/effect/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return 0

/datum/spacevine_mutation/proc/on_cross(obj/effect/spacevine/holder, mob/crosser)
	return 0

/datum/spacevine_mutation/proc/on_chem(obj/effect/spacevine/holder, datum/reagent/R)
	return 0

/datum/spacevine_mutation/proc/on_eat(obj/effect/spacevine/holder, mob/living/eater)
	return 0

/datum/spacevine_mutation/proc/on_spread(obj/effect/spacevine/holder, turf/target)
	return 0

/datum/spacevine_mutation/proc/on_buckle(obj/effect/spacevine/holder, mob/living/buckled)
	return 0

/*============START OF MUTATIONS============*/

/datum/spacevine_mutation/space_covering
	name = "space protective"
	ID = "adv_space_covering"
	hue = "#aa77aa"
	quality = POSITIVE
	gen_conflict = list("spread_no_space")

/turf/simulated/floor/vines
	color = "#aa77aa"
	icon_state = "vinefloor"
	broken_states = list()


//All of this shit is useless for vines

/turf/simulated/floor/vines/attackby()
	return

/turf/simulated/floor/vines/burn_tile()
	return

/turf/simulated/floor/vines/break_tile()
	return

/turf/simulated/floor/vines/make_plating()
	return

/turf/simulated/floor/vines/break_tile_to_plating()
	return

/turf/simulated/floor/vines/ex_act(severity, target)
	if(severity < 3 || target == src)
		ChangeTurf(/turf/space)

/turf/simulated/floor/vines/narsie_act()
	if(prob(20))
		ChangeTurf(/turf/space) //nar sie eats this shit

/turf/simulated/floor/vines/singularity_pull(S, current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(50))
			ChangeTurf(/turf/space)

/turf/simulated/floor/vines/ChangeTurf(turf/simulated/floor/T)
	for(var/obj/effect/spacevine/SV in src)
		qdel(SV)
	..()
	UpdateAffectingLights()

/datum/spacevine_mutation/space_covering/on_grow(obj/effect/spacevine/holder)
	if(istype(holder.loc, /turf/space))
		var/turf/spaceturf = holder.loc
		spaceturf.ChangeTurf(/turf/simulated/floor/vines)
	return 0

/datum/spacevine_mutation/space_covering/process_mutation(obj/effect/spacevine/holder)
	if(istype(holder.loc, /turf/space))
		var/turf/spaceturf = holder.loc
		spaceturf.ChangeTurf(/turf/simulated/floor/vines)
	return 0

/datum/spacevine_mutation/space_covering/on_death(obj/effect/spacevine/holder)
	if(istype(holder.loc, /turf/simulated/floor/vines))
		var/turf/spaceturf = holder.loc
		spawn(0)
			spaceturf.ChangeTurf(/turf/space)

/*============||============*/

/datum/spacevine_mutation/bluespace
	name = "bluespace"
	ID = "spread_bluespace"
	hue = "#3333ff"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_soft")

/datum/spacevine_mutation/bluespace/on_spread(obj/effect/spacevine/holder, turf/target)
	if(holder.energy > 1 && !locate(/obj/effect/spacevine) in target)
		return SPACEVINE_BEHAVIOUR_FORCE_GROWTH
	return 0

/*============||============*/

/datum/spacevine_mutation/light
	name = "light"
	ID = "growh_light"
	hue = "#ffff00"
	quality = POSITIVE
	gen_conflict = list("spread_no_light")

/datum/spacevine_mutation/light/on_grow(obj/effect/spacevine/holder)
	if(prob(10*severity))
		holder.SetLuminosity(4)
	return 0

/*============||============*/

/datum/spacevine_mutation/toxicity
	name = "toxic"
	ID = "cross_toxic"
	hue = "#ff00ff"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/toxicity/on_cross(obj/effect/spacevine/holder, mob/living/crosser)
	if(issilicon(crosser))
		return
	if(prob(severity) && istype(crosser))
		crosser << "<span class='alert'>You accidently touch the vine and feel a strange sensation.</span>"
		crosser.adjustToxLoss(5)
	return 0

/datum/spacevine_mutation/toxicity/on_eat(obj/effect/spacevine/holder, mob/living/eater)
	eater.adjustToxLoss(5)
	return 0

/*============||============*/

/datum/spacevine_mutation/explosive  //OH SHIT IT CAN CHAINREACT RUN!!!
	name = "explosive"
	ID = "death_explosion"
	hue = "#ff0000"
	quality = NEGATIVE

/datum/spacevine_mutation/explosive/on_death(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	var/turf/T = holder.loc
	src = T
	spawn(10)
		explosion(T, 0, 0, 2, 0, 0)

/*============||============*/

/datum/spacevine_mutation/fire_proof
	name = "fire proof"
	ID = "invulnerability_fire"
	hue = "#ff8888"
	quality = MINOR_NEGATIVE
	gen_conflict = list("vulnerability_fire")

/datum/spacevine_mutation/fire_proof/process_temperature(obj/effect/spacevine/holder, temp, volume)
	return SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE

/datum/spacevine_mutation/fire_proof/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE

/*============||============*/

/datum/spacevine_mutation/vine_eating_a
	name = "vine eating"
	ID = "spread_eat_A"
	hue = "#ff7700"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_vine")

/datum/spacevine_mutation/vine_eating_a/on_spread(obj/effect/spacevine/holder, turf/target)
	var/obj/effect/spacevine/prey = locate() in target
	if(prey && !prey.mutations.Find(src))  //Eat all vines that are not of the same origin
		qdel(prey)
	return 0
//it's for some advanced behavior.
/datum/spacevine_mutation/vine_eating_b
	name = "vine eating"
	ID = "spread_eat_B"
	hue = "#ff7712"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_vine")

/datum/spacevine_mutation/vine_eating_b/on_spread(obj/effect/spacevine/holder, turf/target)
	var/obj/effect/spacevine/prey = locate() in target
	if(prey && !prey.mutations.Find(src))  //Eat all vines that are not of the same origin
		qdel(prey)
	return 0

/datum/spacevine_mutation/vine_eating_c
	name = "vine eating"
	ID = "spread_eat_C"
	hue = "#ff7724"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_vine")

/datum/spacevine_mutation/vine_eating_c/on_spread(obj/effect/spacevine/holder, turf/target)
	var/obj/effect/spacevine/prey = locate() in target
	if(prey && !prey.mutations.Find(src))  //Eat all vines that are not of the same origin
		qdel(prey)
	return 0

/*============||============*/

/datum/spacevine_mutation/aggressive_spread  //very OP, but im out of other ideas currently
	name = "aggressive spreading"
	ID = "spread_aggressive"
	hue = "#333333"
	severity = 3
	quality = NEGATIVE
	gen_conflict = list("spread_soft")

/datum/spacevine_mutation/aggressive_spread/on_spread(obj/effect/spacevine/holder, turf/target)
	for(var/atom/A in target)
		if(!istype(A, /obj/effect))
			A.ex_act(severity)  //To not be the same as self-eating vine
	return 0

/datum/spacevine_mutation/aggressive_spread/on_buckle(obj/effect/spacevine/holder, mob/living/buckled)
	buckled.ex_act(severity)
	return 0

/*============||============*/

/datum/spacevine_mutation/transparency
	name = "transparent"
	ID = "growth_transparent"
	hue = ""
	quality = POSITIVE

/datum/spacevine_mutation/transparency/on_grow(obj/effect/spacevine/holder)
	holder.SetOpacity(0)
	holder.alpha = 125
	return 0

/*============||============*/

/datum/spacevine_mutation/oxy_eater
	name = "oxygen consuming"
	ID = "atmos_eat_oxygen"
	hue = "#ffff88"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/oxy_eater/process_mutation(obj/effect/spacevine/holder)
	var/turf/simulated/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.oxygen = max(0, GM.oxygen - severity * holder.energy)
	return 0

/*============||============*/

/datum/spacevine_mutation/nitro_eater
	name = "nitrogen consuming"
	ID = "atmos_eat_nitrogen"
	hue = "#8888ff"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/nitro_eater/process_mutation(obj/effect/spacevine/holder)
	var/turf/simulated/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.nitrogen = max(0, GM.nitrogen - severity * holder.energy)
	return 0

/*============||============*/

/datum/spacevine_mutation/carbondioxide_eater
	name = "CO2 consuming"
	ID = "atmos_eat_carbondioxide"
	hue = "#00ffff"
	severity = 3
	quality = POSITIVE

/datum/spacevine_mutation/carbondioxide_eater/process_mutation(obj/effect/spacevine/holder)
	var/turf/simulated/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.carbon_dioxide = max(0, GM.carbon_dioxide - severity * holder.energy)
	return 0

/*============||============*/

/datum/spacevine_mutation/plasma_eater
	name = "toxins consuming"
	ID = "atmos_eat_plasma"
	hue = "#ffbbff"
	severity = 3
	quality = POSITIVE

/datum/spacevine_mutation/plasma_eater/process_mutation(obj/effect/spacevine/holder)
	var/turf/simulated/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.toxins = max(0, GM.toxins - severity * holder.energy)
	return 0

/*============||============*/

/datum/spacevine_mutation/thorns
	name = "thorny"
	ID = "cross_brute"
	hue = "#666666"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/thorns/on_cross(obj/effect/spacevine/holder, mob/living/crosser)
	if(prob(severity) && istype(crosser))
		var/mob/living/M = crosser
		M.adjustBruteLoss(5)
		M << "<span class='alert'>You cut yourself on the thorny vines.</span>"
	return 0

/datum/spacevine_mutation/thorns/on_hit(obj/effect/spacevine/holder, mob/living/hitter)
	if(prob(severity) && istype(hitter))
		var/mob/living/M = hitter
		M.adjustBruteLoss(5)
		M << "<span class='alert'>You cut yourself on the thorny vines.</span>"
	return 0

/*============||============*/

/datum/spacevine_mutation/woodening
	name = "hardened"
	ID = "invulnerability_brute"
	hue = "#997700"
	quality = NEGATIVE
	gen_conflict = list("vulnerability_brute", "adv_glass")

/datum/spacevine_mutation/woodening/on_grow(obj/effect/spacevine/holder)
	if(holder.energy)
		holder.density = 1
	return 0

/datum/spacevine_mutation/woodening/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	if(hitter)
		var/chance
		if(I)
			chance = I.force * 2
		else
			chance = 8
		if(prob(chance))
			qdel(holder)
	return SPACEVINE_BEHAVIOUR_TOUGH	//they would burn by weldingtools, yey.

/*============||============*/

/datum/spacevine_mutation/blood
	name = "bloody"
	ID = "chem_blood"
	hue = "#C80000"
	quality = POSITIVE
	severity = 10
	gen_conflict = list("growth_reverse")

/datum/spacevine_mutation/blood/process_mutation(obj/effect/spacevine/holder)
	if(holder.reagents)
		if(holder.energy >= 2 && holder.reagents.get_reagent_amount("blood") < 7)
			if(prob(severity))
				holder.reagents.add_reagent("blood", 1)
	return 0

/datum/spacevine_mutation/blood/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_REAGENT_PRODUCING

/datum/spacevine_mutation/blood/on_birth(obj/effect/spacevine/holder)
	holder.create_reagents(20)
	return 0

/*============||============*/

/datum/spacevine_mutation/acid
	name = "carnivorous"
	ID = "chem_acid"
	hue = "#656565"
	quality = NEGATIVE
	severity = 15
	gen_conflict = list("growth_reverse")

/datum/spacevine_mutation/acid/process_mutation(obj/effect/spacevine/holder)
	if(holder.reagents)
		if(holder.energy >= 2 && holder.reagents.get_reagent_amount("sacid") < 10)
			if(prob(severity))
				holder.reagents.add_reagent("sacid", 1)
	return 0

/datum/spacevine_mutation/acid/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_REAGENT_PRODUCING

/datum/spacevine_mutation/acid/on_chem(obj/effect/spacevine/holder, datum/reagent/R)
	return SPACEVINE_BEHAVIOUR_HERBICIDE_IMMUNE & SPACEVINE_BEHAVIOUR_ACID_IMMUNE

/datum/spacevine_mutation/acid/on_birth(obj/effect/spacevine/holder)
	holder.create_reagents(20)
	return 0

/datum/spacevine_mutation/acid/on_buckle(obj/effect/spacevine/holder, mob/living/buckled)
	if(ismob(buckled) && buckled.reagents && holder.reagents.total_volume)
		var/mob/M = buckled
		var/R
		buckled.visible_message("<span class='danger'>[buckled] has been splashed with something by [holder]!</span>", \
						"<span class='userdanger'>[buckled] has been splashed with something by [holder]!</span>")
		if(holder.reagents && holder.reagents.total_volume )
			for(var/datum/reagent/A in holder.reagents.reagent_list)
				R += A.id + " ("
				R += num2text(A.volume) + "),"
		add_logs(, M, "splashed", object="[R]", addition="by spacevine")
		holder.reagents.reaction(buckled, TOUCH)
		holder.reagents.clear_reagents()
		return 0
	return 0

/*============||============*/

/datum/spacevine_mutation/spore
	name = "Puffball-like"
	ID = "chem_spore"
	hue = "#9ACD32"
	quality = NEGATIVE
	severity = 5
	gen_conflict = list("growth_reverse")

/datum/spacevine_mutation/spore/process_mutation(obj/effect/spacevine/holder)
	if(holder.reagents)
		if(holder.energy >= 2 && holder.reagents.get_reagent_amount("spore") < 10)
			if(prob(severity))
				holder.reagents.add_reagent("spore", 1)
	return 0

/datum/spacevine_mutation/spore/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_REAGENT_PRODUCING

/datum/spacevine_mutation/spore/on_birth(obj/effect/spacevine/holder)
	holder.create_reagents(20)
	return 0

/datum/spacevine_mutation/spore/on_death(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	if(holder.reagents)
		var/turf/T = get_turf(holder)
		var/datum/effect/effect/system/chem_smoke_spread/S = new
		S.attach(T)
		S.set_up(holder.reagents, 1, 1, T, 15, 1) // only 1-2 smoke cloud
		S.start()

/*============||============*/

/datum/spacevine_mutation/sticky
	name = "sticky"
	ID = "cross_bucking"
	hue = "#222299"
	quality = MINOR_NEGATIVE
	gen_conflict = list("growth_reverse")

/datum/spacevine_mutation/sticky/on_cross(obj/effect/spacevine/holder, mob/living/crosser)
	if(holder.energy >= 2)
		holder.buckle_mob()
	return 0

/*============||============*/

/datum/spacevine_mutation/bee
	name = "buzzing"
	ID = "death_bee"
	hue = "#FFF200"
	quality = NEGATIVE
	severity = 5
	gen_conflict = list("growth_reverse")

/datum/spacevine_mutation/bee/on_buckle(obj/effect/spacevine/holder, mob/living/buckled)
	if(holder.energy >= 2 && prob(severity))
		var/datum/disease/D
		D = new/datum/disease/beesease
		D.carrier = 1
		buckled << "<span class='danger'>You feel a tiny sting.</span>"
		buckled.AddDisease(D)
	return 0


/datum/spacevine_mutation/bee/on_death(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	if(holder.energy >= 2 && prob(min(severity * 4, 100)))
		new /mob/living/simple_animal/hostile/poison/bees(get_turf(holder))

/*============||============*/

/datum/spacevine_mutation/darkness_spread
	name = "light fearing"
	ID = "spread_no_light"
	hue = "#CCCCCC"
	quality = MINOR_NEGATIVE
	gen_conflict = list("growh_light", "spread_no_daekness")

/datum/spacevine_mutation/darkness_spread/on_spread(obj/effect/spacevine/holder, turf/target)
	var/T = 0
	for(var/atom/movable/light/L in target.contents)
		T = 1
		if(L.luminosity > 2)
			return SPACEVINE_BEHAVIOUR_INERT
	if(!T)	//no light only in areas with constant lighting
		return SPACEVINE_BEHAVIOUR_INERT
	return 0

/*============||============*/

/datum/spacevine_mutation/light_spread
	name = "darkness fearing"
	ID = "spread_no_daekness"
	hue = "#444444"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_no_light")

/datum/spacevine_mutation/light_spread/on_spread(obj/effect/spacevine/holder, turf/target)
	var/T = 1
	for(var/atom/movable/light/L in target.contents)
		if(L.luminosity <= 2)
			T = 0
	if(!T)
		return SPACEVINE_BEHAVIOUR_INERT
	return 0

/*============||============*/

/datum/spacevine_mutation/endemic
	name = "endemic"
	ID = "spread_no_space"
	hue = null
	quality = POSITIVE

/datum/spacevine_mutation/endemic/on_spread(obj/effect/spacevine/holder, turf/target)
	var/turf/place = get_turf(holder)
	if(target.loc != place.loc)
		return SPACEVINE_BEHAVIOUR_INERT
	return 0

/*============||============*/

/datum/spacevine_mutation/space_fearing
	name = "space fearing"
	ID = "spread_no_space"
	hue = "#558855"
	quality = POSITIVE
	gen_conflict = list("adv_space_covering")

/datum/spacevine_mutation/space_fearing/on_spread(obj/effect/spacevine/holder, turf/target)
	if(istype(target, /turf/space))
		return SPACEVINE_BEHAVIOUR_INERT
	return 0

/*============||============*/

/datum/spacevine_mutation/crawling
	name = "crawling"
	ID = "spread_crawl"
	hue = "#666666"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_soft")

/datum/spacevine_mutation/crawling/on_spread(obj/effect/spacevine/holder, turf/target)
	if(locate(/obj/structure/plasticflaps) in target || locate(/obj/structure/mineral_door) in target)
		return SPACEVINE_BEHAVIOUR_FORCE_GROWTH
	else if (locate(/obj/structure/grille) in target && !locate(/obj/structure/window) in target)
		return SPACEVINE_BEHAVIOUR_FORCE_GROWTH
	return 0

/*============||============*/

/datum/spacevine_mutation/mutation_spreading
	name = "genetically aggressive"
	ID = "mutate_spread"
	hue = null
	quality = MINOR_NEGATIVE
	gen_conflict = list("mutate_reverse")

/datum/spacevine_mutation/mutation_spreading/on_spread(obj/effect/spacevine/holder, turf/target)
	var/obj/effect/spacevine/SV = locate(/obj/effect/spacevine) in target
	if(SV)
		var/list/mut_diff = difflist(holder.mutations, SV.mutations)
		if(mut_diff)
			for(var/datum/spacevine_mutation/mut in mut_diff)
				var/override = 0
				//debag
				//world << "New mutation [newmut.name], possible conflicts ([english_list(newmut.gen_conflict)]), existing mutations ([english_list(SV.mutations)])"
				for(var/datum/spacevine_mutation/oldmut in SV.mutations)
					if(mut.gen_conflict.Find(oldmut.ID))
						//world << "New mutation conflict [newmut.ID] & [oldmut.ID]"
						SV.mutations.Remove(oldmut)
						override |= SPACEVINE_MUTATOION_GEN_CONFLICT
				if (!(override & SPACEVINE_MUTATOION_GEN_CONFLICT))
					SV.mutations |= mut
			if(SV.mutations.len)
				var/datum/spacevine_mutation/randmut = SV.mutations[SV.mutations.len]
				SV.color = randmut.hue
				SV.desc = "An extremely expansionistic species of vine. These are "
				for(var/datum/spacevine_mutation/M in SV.mutations)
					SV.desc += "[M.name] "
				SV.desc += "vines."
			else
				SV.color = null
				SV.desc = "An extremely expansionistic species of vine."
	return 0
//hmmmmm it's looks laggy
/*============||============*/

/datum/spacevine_mutation/no_mutate
	name = "genetically stable"
	ID = "mutate_none"
	hue = null
	quality = POSITIVE
	gen_conflict = list("mutate_fast")

/datum/spacevine_mutation/no_mutate/on_spread(obj/effect/spacevine/holder, turf/target)
	return SPACEVINE_BEHAVIOUR_GEN_SATABLE

/*============||============*/

/datum/spacevine_mutation/fast_mutate
	name = "genetically unstable"
	ID = "mutate_fast"
	hue = null
	quality = MINOR_NEGATIVE
	gen_conflict = list("mutate_none")

/datum/spacevine_mutation/fast_mutate/on_spread(obj/effect/spacevine/holder, turf/target)
	return SPACEVINE_BEHAVIOUR_GEN_MUTATIVE

/*============||============*/

/datum/spacevine_mutation/reverse_mutate
	name = "degradable"
	ID = "mutate_reverse"
	hue = null
	quality = MINOR_NEGATIVE
	gen_conflict = list("mutate_spread")

/datum/spacevine_mutation/reverse_mutate/on_spread(obj/effect/spacevine/holder, turf/target)
	return SPACEVINE_BEHAVIOUR_GEN_REGRESSIVE

/*============||============*/

/datum/spacevine_mutation/fast_spread
	name = "fast spreading"
	ID = "spread_fast"
	hue = null
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_slow")

/datum/spacevine_mutation/fast_spread/process_mutation(obj/effect/spacevine/holder)
	return SPACEVINE_PROCESSING_GROWING_FAST

/*============||============*/

/datum/spacevine_mutation/slow_spread
	name = "slow spreading"
	ID = "spread_slow"
	hue = null
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_fast")

/datum/spacevine_mutation/slow_spread/process_mutation(obj/effect/spacevine/holder)
	return SPACEVINE_PROCESSING_GROWING_SLOW

/*============||============*/

/datum/spacevine_mutation/short_lifespawn
	name = "short-lived"
	ID = "growth_unprocessing"
	hue = "#000066"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/short_lifespawn/process_mutation(obj/effect/spacevine/holder)
	return SPACEVINE_PROCESSING_SHORT_LIVING

/*============||============*/

/datum/spacevine_mutation/selfdestruction
	name = "selfdestructivle"
	ID = "growth_reverse"
	hue = "#DD3333"
	quality = MINOR_NEGATIVE
	gen_conflict = list("chem_blood", "chem_acid", "chem_spore", "cross_bucking", "death_bee")

/datum/spacevine_mutation/selfdestruction/on_grow(obj/effect/spacevine/holder)
	holder.energy -= 2
	return 0

/datum/spacevine_mutation/selfdestruction/on_buckle(obj/effect/spacevine/holder, mob/living/buckled)
	holder.energy --
	return 0

/*============||============*/

/datum/spacevine_mutation/fragile
	name = "fragile"
	ID = "vulnerability_brute"
	hue = "#990077"
	quality = MINOR_NEGATIVE
	gen_conflict = list("invulnerability_brute")

/datum/spacevine_mutation/fragile/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_FRAGILE

/*============||============*/

/datum/spacevine_mutation/dry
	name = "dry"
	ID = "vulnerability_fire"
	hue = "#88ff88"
	quality = MINOR_NEGATIVE
	gen_conflict = list("invulnerability_fire", "adv_fiery")

/datum/spacevine_mutation/dry/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_IGNITABLE

/*============||============*/

/datum/spacevine_mutation/cascade_death
	name = "chainreacting"
	ID = "death_chainreact"
	hue = "#9696ff"
	quality = MINOR_NEGATIVE
	gen_conflict = list("adv_self_defending")

/datum/spacevine_mutation/cascade_death/on_death(obj/effect/spacevine/holder)
	for(var/obj/effect/spacevine/B in orange(1, holder))
		if(prob(40))
			spawn(5) qdel(B)	//in fact, prevent recursive cals. also looks beter

/*============||============*/

/datum/spacevine_mutation/owergroving
	name = "overgroving"
	ID = "spread_vine"
	hue = "#968425"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_eat_A", "spread_eat_B", "spread_eat_C")

/datum/spacevine_mutation/owergroving/on_spread(obj/effect/spacevine/holder, turf/target)
	var/I
	for (var/obj/effect/spacevine/SV in target.contents)
		I++
	if (I == 1)
		return SPACEVINE_BEHAVIOUR_FORCE_GROWTH
	return 0


/*============||============*/

/datum/spacevine_mutation/soft_spreading
	name = "passive spreading"
	ID = "spread_soft"
	hue = "#bbbbbb"
	quality = MINOR_NEGATIVE
	gen_conflict = list("spread_aggressive", "spread_bluespace", "spread_crawl")

/datum/spacevine_mutation/soft_spreading/on_spread(obj/effect/spacevine/holder, turf/target)
	for (var/A in target.contents)
		if (!(istype(A, /atom/movable/light) || istype(A, /obj/structure/cable) || istype(A, /obj/machinery/atmospherics/pipe) || istype(A, /obj/structure/disposalpipe) || istype(A, /obj/structure/lattice) || istype(A,  /obj/effect/decal/cleanable)))
			return SPACEVINE_BEHAVIOUR_INERT
	return 0

/*============||============*/

/datum/spacevine_mutation/self_defense
	name = "self defending"
	ID = "adv_self_defending"
	hue = "#737191"
	quality = NEGATIVE
	severity = 90
	gen_conflict = list("death_chainreact")

/datum/spacevine_mutation/self_defense/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	if(prob(severity))
		return SPACEVINE_BEHAVIOUR_SELF_DEFENSE
	return 0

/*============||============*/

/datum/spacevine_mutation/glass
	name = "glassy"
	ID = "adv_glass"
	hue = "#eeeeee"
	quality = MINOR_NEGATIVE
	gen_conflict = list("adv_fiery", "invulnerability_brute")

/datum/spacevine_mutation/glass/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	return SPACEVINE_BEHAVIOUR_FRAGILE

/datum/spacevine_mutation/glass/on_chem(obj/effect/spacevine/holder, datum/reagent/R)
	return SPACEVINE_BEHAVIOUR_INERT

/datum/spacevine_mutation/glass/on_grow(obj/effect/spacevine/holder)
	holder.SetOpacity(0)
	return 0

/*============||============*/

/datum/spacevine_mutation/fiery
	name = "fiery"
	ID = "adv_fiery"
	hue = "#ff2222"
	severity = 10
	quality = NEGATIVE
	gen_conflict = list("vulnerability_fire", "adv_glass")

/datum/spacevine_mutation/fiery/process_temperature(obj/effect/spacevine/holder, temp, volume)
	return SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE

/datum/spacevine_mutation/fiery/on_hit(obj/effect/spacevine/holder, mob/hitter, obj/item/I)
	if(prob(severity) && istype(hitter))
		var/mob/living/M = hitter
		M.adjustFireLoss(5)
		M << "<span class='alert'>You burn yourself on the fiery vines.</span>"
	return SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE

/datum/spacevine_mutation/fiery/on_cross(obj/effect/spacevine/holder, mob/living/crosser)
	if(prob(severity) && istype(crosser))
		var/mob/living/M = crosser
		M.adjustFireLoss(5)
		M << "<span class='alert'>You burn yourself on the fiery vines.</span>"
	return 0

/datum/spacevine_mutation/fiery/on_chem(obj/effect/spacevine/holder, datum/reagent/R)
	return SPACEVINE_BEHAVIOUR_HYDROPHOBIC

/*============||============*/
//can anyone explain me why I created this?
/datum/spacevine_mutation/RP
	name = "black"
	ID = "adv_black"
	hue = "#000000"
	quality = MINOR_NEGATIVE
	var/list/pseudo_emoutes = list( "<big>Spacevine looks memetic.</big>", "Spacevine looks lonely.", "Spacevine looks sad.", "Spacevine looks happy.", "Spacevine looks like biomass.", \
									"Spacevine smells like beans.", "Spacevine playfully waving it's leaf.", "Spacevine wants to get into space.", \
									"Spacevine isn't a catastrophe, I promise.", "Spacevine wouldn't drop sapling for sure.", \
									"Spacevine can't bash anybody in head with fire extinguisher.", "Spacevine explains something on leaves. You are unable to understand it.", \
									"Spacevine breaths.", "Spacevine has it's r_sprout missing.", "Spacevine praises our lord Singulo.", "Spacevine dispirit by sandboxes.", \
									"Spacevine only wants your LOVE.", "Spacevine rustles in the nonexistent wind.", "Spacevine does nothing.", "Spacevine goes to the dark side.", \
									"Spacevine tries to clung to the ceiling, but fails.", "Spacevine tries to drill space.", "Spacevine reminds you about something called 'hentai'.", \
									"Spacevine wouldn't cooperate with other spacevines, would it?.", "Spacevine looks like a net, that you just found.", \
									"Spacevine wants to color itself into yellow and blue, but unable to do it.", \
									"Spacevine wants to color itself into red, white and blue, but unable to do it.", \
									"Spacevine wants to color itself into colors of freedom, but unable to do it.", "Spacevine looks annoying.", \
									"Spacevine someday would be big enogh to orbit stars.", "Spacevine whants to know why it has been created.", \
									"Spacevine doesn't like admiral Nose.", "Spacevine is a living being to!", "Spacevine is aggressive to the naked bald mens.", \
									"Spacevine isn't product of creationism.", "Spacevine is product of evolution.",\
									"If spacevine was a spaceman, would you be a griefvine?")

/datum/spacevine_mutation/RP/process_mutation(obj/effect/spacevine/holder)
	if(prob(5))
		var/RP = pick(pseudo_emoutes)
		holder.visible_message(RP)
	return 0


/*============END OF MUTATIONS============*/
// SPACE VINES (Note that this code is very similar to Biomass code)
/obj/effect/spacevine
	name = "space vines"
	desc = "An extremely expansionistic species of vine."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Light1"
	anchored = 1
	density = 0
	layer = 5
	mouse_opacity = 2 //Clicking anywhere on the turf is good enough
	can_buckle = 1 //spacevine will coil around you
	pass_flags = PASSTABLE | PASSGRILLE
	var/energy = 0
	var/obj/effect/spacevine_controller/master = null
	var/list/mutations = list()

/obj/effect/spacevine/Destroy()
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_death(src)
	if(master)
		master.vines -= src
		master.growth_queue -= src
		if(!master.vines.len)
			var/obj/item/seeds/kudzuseed/KZ = new(loc)
			KZ.mutations |= mutations
			KZ.potency = min(100, master.mutativness * 10)
			KZ.production = (master.spread_cap / initial(master.spread_cap)) * 50
	mutations = list()
	SetOpacity(0)
	if(buckled_mob)
		unbuckle_mob()
	..()

/obj/effect/spacevine/proc/on_chem_effect(datum/reagent/R)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override |= SM.on_chem(src, R)
	if(override & SPACEVINE_BEHAVIOUR_INERT)
		return
	if(istype(R, /datum/reagent/toxin/plantbgone) && !(override & SPACEVINE_BEHAVIOUR_HERBICIDE_IMMUNE))
		if(prob(50))
			qdel(src)
	else if(istype(R, /datum/reagent/water) && (override & SPACEVINE_BEHAVIOUR_HYDROPHOBIC))
		if(prob(75))
			qdel(src)

/obj/effect/spacevine/proc/eat(mob/eater)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override |= SM.on_eat(src, eater)
	if(!(override & SPACEVINE_BEHAVIOUR_INERT))
		if(prob(10))
			eater.say("Nom")
		qdel(src)

/obj/effect/spacevine/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	if (!W || !user || !W.type)
		return
	user.changeNext_move(CLICK_CD_MELEE)

	var/override = 0

	for(var/datum/spacevine_mutation/SM in mutations)
		override |= SM.on_hit(src, user)
		//world<<"[override] after [SM.name]"

	if(override & SPACEVINE_BEHAVIOUR_INERT)
		..()
		return

	if((override & SPACEVINE_BEHAVIOUR_REAGENT_PRODUCING) && (W.flags & OPENCONTAINER))
		if(reagents)  //sanity
			reagents.trans_to(W, reagents.total_volume)
			return

	if(override & SPACEVINE_BEHAVIOUR_SELF_DEFENSE)
		var/mob/living/M = user
		M.adjustBruteLoss(5)
		M << "<span class='alert'>Spacevines.cut you, tying to defend itself.</span>"

	if(!(override & SPACEVINE_BEHAVIOUR_TOUGH))
		if(istype(W, /obj/item/weapon/scythe))
			for(var/obj/effect/spacevine/B in orange(src,1))
				if(prob(80))
					qdel(B)
			qdel(src)
			return

		else if(is_sharp(W))
			qdel(src)
			return

		else if((override & SPACEVINE_BEHAVIOUR_FRAGILE) && (W.damtype == BRUTE)) //  && (W.force > 4)
			qdel(src)
			return

	if(!(override & SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE))
		if(istype(W, /obj/item/weapon/weldingtool))
			var/obj/item/weapon/weldingtool/WT = W
			if(WT.remove_fuel(0, user))
				qdel(src)
				return
			else
				user_unbuckle_mob(user,user)
				return

		if((override & SPACEVINE_BEHAVIOUR_IGNITABLE) && (W.damtype == BURN))
			qdel(src)
			return

		//Plant-b-gone damage is handled in its entry in chemistry-reagents.dm //YOU'RE LYING
	..()

/obj/effect/spacevine/Crossed(mob/crosser)
	if(isliving(crosser))
		for(var/datum/spacevine_mutation/SM in mutations)
			SM.on_cross(src, crosser)

/obj/effect/spacevine/attack_hand(mob/user as mob)
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_hit(src, user)
	user_unbuckle_mob(user, user)


/obj/effect/spacevine/attack_paw(mob/living/user as mob)
	user.do_attack_animation(src)
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_hit(src, user)
	user_unbuckle_mob(user,user)



/obj/effect/spacevine_controller
	var/list/obj/effect/spacevine/vines = list()
	var/list/growth_queue = list()
	var/spread_multiplier = 5
	var/spread_cap = 30
	var/list/mutations_list = list()
	var/mutativness = 1

/obj/effect/spacevine_controller/New(loc, list/muts, mttv, spreading)
	spawn_spacevine_piece(loc, , muts)
	for(var/obj/effect/spacevine/root in vines)	//fix invisible mutations from player-plantet kudzu
		if(root.mutations.len)
			var/datum/spacevine_mutation/randmut = root.mutations[root.mutations.len]
			root.color = randmut.hue
			root.desc = "An extremely expansionistic species of vine. These are "
			for(var/datum/spacevine_mutation/M in root.mutations)
				root.desc += "[M.name] "
			root.desc += "vines."
		else
			root.color = null
			root.desc = "An extremely expansionistic species of vine."
	SSobj.processing |= src
	init_subtypes(/datum/spacevine_mutation/, mutations_list)
	if(mttv != null)
		mutativness = mttv / 10
	if(spreading != null)
		spread_cap *= spreading / 50
		spread_multiplier /= spreading / 50

/obj/effect/spacevine_controller/ex_act() //only killing all vines will end this suffering
	return

/obj/effect/spacevine_controller/singularity_act()
	return

/obj/effect/spacevine_controller/singularity_pull()
	return

/obj/effect/spacevine_controller/Destroy()
	SSobj.processing.Remove(src)
	..()

/obj/effect/spacevine_controller/proc/spawn_spacevine_piece(var/turf/location, obj/effect/spacevine/parent, list/muts, var/override = 0)
	var/obj/effect/spacevine/SV = new(location)
	growth_queue += SV
	vines += SV
	SV.master = src
	if(muts && muts.len)
		SV.mutations |= muts
	if(parent)
		SV.mutations |= parent.mutations
		SV.color = parent.color
		SV.desc = parent.desc
		if(!(override & SPACEVINE_BEHAVIOUR_GEN_SATABLE))
			if(prob(mutativness + (override & SPACEVINE_BEHAVIOUR_GEN_MUTATIVE)))
				if(override & SPACEVINE_BEHAVIOUR_GEN_REGRESSIVE)
					pick_n_take(SV.mutations)
				else
					var/datum/spacevine_mutation/newmut = pick(mutations_list)
					//debag
					//world << "New mutation [newmut.name], possible conflicts ([english_list(newmut.gen_conflict)]), existing mutations ([english_list(SV.mutations)])"
					for(var/datum/spacevine_mutation/oldmut in SV.mutations)
						if(newmut.gen_conflict.Find(oldmut.ID))
							//world << "New mutation conflict [newmut.ID] & [oldmut.ID]"
							SV.mutations.Remove(oldmut)
							override |= SPACEVINE_MUTATOION_GEN_CONFLICT
					if (!(override & SPACEVINE_MUTATOION_GEN_CONFLICT))
						SV.mutations |= newmut
			if(SV.mutations.len)
				var/datum/spacevine_mutation/randmut = SV.mutations[SV.mutations.len]
				SV.color = randmut.hue
				SV.desc = "An extremely expansionistic species of vine. These are "
				for(var/datum/spacevine_mutation/M in SV.mutations)
					SV.desc += "[M.name] "
				SV.desc += "vines."
			else
				SV.color = null
				SV.desc = "An extremely expansionistic species of vine."

	for(var/datum/spacevine_mutation/SM in SV.mutations)
		SM.on_birth(SV)

/obj/effect/spacevine_controller/process()
	if(!vines)
		qdel(src) //space  vines exterminated. Remove the controller
		return
	if(!growth_queue)
		qdel(src) //Sanity check
		return

	var/length = 0

	length = min( spread_cap , max( 1 , vines.len / spread_multiplier ) )
	var/i = 0
	var/list/obj/effect/spacevine/queue_end = list()

	for( var/obj/effect/spacevine/SV in growth_queue )
		if(SV.gc_destroyed)	continue
		i++
		queue_end += SV
		growth_queue -= SV
		var/override = 0
		for(var/datum/spacevine_mutation/SM in SV.mutations)
			override |= SM.process_mutation(SV)
		if(SV.energy < 2) //If tile isn't fully grown
			if(prob(20))
				SV.grow()
		else //If tile is fully grown
			SV.buckle_mob()
			if(override & SPACEVINE_PROCESSING_SHORT_LIVING)
				queue_end -= SV

		if(override & SPACEVINE_PROCESSING_GROWING_FAST)
			i -= 0.5
		else if (override & SPACEVINE_PROCESSING_GROWING_SLOW)
			i++
		//if(prob(25))
		SV.spread()
		if(i >= length)
			break

	growth_queue = growth_queue + queue_end
	//sleep(5)
	//src.process()

/obj/effect/spacevine/proc/grow()
	if(!energy)
		src.icon_state = pick("Med1", "Med2", "Med3")
		energy = 1
		SetOpacity(1)
		layer = 5
	else
		src.icon_state = pick("Hvy1", "Hvy2", "Hvy3")
		energy = 2

	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_grow(src)

	if(energy < 0)
		qdel(src)

/obj/effect/spacevine/buckle_mob()
	if(!buckled_mob && prob(25))
		for(var/mob/living/carbon/V in src.loc)
			for(var/datum/spacevine_mutation/SM in mutations)
				SM.on_buckle(src, V)
			if((V.stat != DEAD) && (V.buckled != src)) //not dead or captured
				V << "<span class='danger'>The vines [pick("wind", "tangle", "tighten")] around you!</span>"
				..(V)
				break //only capture one mob at a time

/obj/effect/spacevine/user_unbuckle_mob(mob/user as mob)
	if(buckled_mob && buckled_mob.buckled == src)
		var/mob/living/M = buckled_mob
		if(M != user)
			M.visible_message(\
				"[user.name] tries to free [M.name] from the [src]!",\
				"<span class='notice'>[user.name] tries to free you from the [src].</span>")
			if(!do_after(user, 20)) //2 seconds
				if(M && M.buckled)
					user << "<span class='warning'>You fail to unbuckle [M.name]!</span>"
				return
			if(!M.buckled)
				return
			M.visible_message(\
				"[user.name] pulls [M.name] free from the [src]!",\
				"<span class='notice'>[user.name] pulls you free from the [src].</span>")
		else
			M.visible_message(\
				"<span class='warning'>[M.name] struggles to break free from the [src]!</span>",\
				"<span class='notice'>You struggle to break free from the [src]... (Stay still for five seconds.)</span>")
			if(!do_after(M, 50))
				if(M && M.buckled)
					M << "<span class='warning'>You fail to unbuckle yourself!</span>"
				return
			if(!M.buckled)
				return
			M.visible_message(\
				"<span class='warning'>[M.name] breaks free from the [src]!</span>",\
				"<span class='notice'>You break free from the [src]!</span>")

		unbuckle_mob()

/obj/effect/spacevine/proc/spread()
	var/direction = pick(cardinal)
	var/turf/stepturf = get_step(src,direction)
	if(!stepturf)
		return //I have NO FUCKING IDEA how, but it hapends
	if(istype(stepturf, /turf/space/transit))
		return  //Just NO
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override |= SM.on_spread(src, stepturf)
		stepturf = get_step(src,direction) //in case turf changes, to make sure no runtimes happen
	if(!stepturf)
		return //Yet another sanyty check
	if(override & SPACEVINE_BEHAVIOUR_INERT)
		return
	if(!locate(/obj/effect/spacevine, stepturf) || (override & SPACEVINE_BEHAVIOUR_FORCE_GROWTH))
		if(stepturf.Enter(src) || (override & SPACEVINE_BEHAVIOUR_FORCE_GROWTH))
			if(master)
				master.spawn_spacevine_piece(stepturf, src, ,override)

/*
/obj/effect/spacevine/proc/Life()
	if (!src) return
	var/Vspread
	if (prob(50)) Vspread = locate(src.x + rand(-1,1),src.y,src.z)
	else Vspread = locate(src.x,src.y + rand(-1, 1),src.z)
	var/dogrowth = 1
	if (!istype(Vspread, /turf/simulated)) dogrowth = 0
	for(var/obj/O in Vspread)
		if (istype(O, /obj/structure/window) || istype(O, /obj/effect/forcefield) || istype(O, /obj/effect/blob) || istype(O, /obj/effect/alien/weeds) || istype(O, /obj/effect/spacevine)) dogrowth = 0
		if (istype(O, /obj/machinery/door/))
			if(O:p_open == 0 && prob(50)) O:open()
			else dogrowth = 0
	if (dogrowth == 1)
		var/obj/effect/spacevine/B = new /obj/effect/spacevine(Vspread)
		B.icon_state = pick("vine-light1", "vine-light2", "vine-light3")
		spawn(20)
			if(B)
				B.Life()
	src.growth += 1
	if (src.growth == 10)
		src.name = "Thick Space Kudzu"
		src.icon_state = pick("vine-med1", "vine-med2", "vine-med3")
		src.opacity = 1
		src.waittime = 80
	if (src.growth == 20)
		src.name = "Dense Space Kudzu"
		src.icon_state = pick("vine-hvy1", "vine-hvy2", "vine-hvy3")
		src.density = 1
	spawn(src.waittime)
		if (src.growth < 20) src.Life()

*/

/obj/effect/spacevine/ex_act(severity, target)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(90))
				qdel(src)
				return
		if(3.0)
			if (prob(50))
				qdel(src)
				return
	return

/obj/effect/spacevine/temperature_expose(null, temp, volume)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override |= SM.process_temperature(src, temp, volume)
	if(!(override & SPACEVINE_BEHAVIOUR_INCOMBUSTIBLE))
		qdel(src)
