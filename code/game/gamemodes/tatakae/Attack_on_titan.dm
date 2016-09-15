/datum/round_event_control/Attack_on_titan
    name = "Attack on Titan"
    typepath = /datum/round_event/Attack_on_titan
    weight = 15
    earliest_start = 1800
    max_occurrences = 3
    minimal_players = 10

/datum/round_event/Attack_on_titan
    announceWhen = 1
    startWhen = 2

/datum/round_event/Attack_on_titan/announce()
    priority_announce("Our scientists were trying to summon a 2d girl, but summoned a fucking Titan. Kill him ASAP!", "Bluespace experiment alert")


/datum/round_event/Attack_on_titan/start()
    var/obj/effect/landmark/TL
    var/list/landmarks_shuffled=shuffle(landmarks_list)
    for(var/obj/effect/landmark/L in landmarks_shuffled)
        if(L.name == "titanspawn")
            TL=L
            break
    var/mob/living/simple_animal/hostile/titan/tmp = new /mob/living/simple_animal/hostile/titan(TL.loc)
    var/datum/effect/effect/system/sleep_smoke_spread/smoke = new /datum/effect/effect/system/sleep_smoke_spread()
    smoke.set_up(15, 0, tmp.loc)
    smoke.start()