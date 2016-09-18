/mob/living/simple_animal/hostile/titan
    name = "Titan"
    desc = "Run, Forrest, run!"
    icon = 'icons/mob/syka_titan.dmi'
    icon_state = "titan"
    icon_living = "titan"
    icon_dead = "titan_dead"

    response_disarm = "pushes"
    response_harm = "hits"
    speed = 0
    maxHealth = 1000
    health = 1000
    a_intent = "harm"
    harm_intent_damage = 70
    melee_damage_lower = 40
    melee_damage_upper = 60
    move_to_delay = 2
    attacktext = "claws"
    attack_sound = 'sound/hallucinations/growl1.ogg'
//  atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
    minbodytemp = 0
    maxbodytemp = 1500
    unsuitable_atmos_damage = 10
    environment_smash = 2
    robust_searching = 1
    stat_attack = 2
    see_in_dark = 9
    status_flags = 0
//  step_sound = "avatarstep"
    turns_per_move = 5
/mob/living/simple_animal/hostile/titan/AttackingTarget()
    ..()

      //H.adjustStaminaLoss(8)
    var/mob/living/ML
    ML = target
    if(ML.stat == DEAD)
        ML.gib()
    //world << "[target] ; [ML.stat] ; [DEAD]"

/mob/living/simple_animal/hostile/titan/Move()
    ..()



    for(var/mob/H in orange(10, src))
        if(!H.stat && !istype(H, /mob/living/silicon/ai))\
            shake_camera(H, 3, 1)
//  if(stat != DEAD)
//      if(loc && istype(loc,/turf/space))
//          icon_state = "titan"

    var soundin = pick('sound/effects/footsteps/heavystep1.ogg','sound/effects/footsteps/heavystep2.ogg','sound/effects/footsteps/heavystep3.ogg','sound/effects/footsteps/heavystep4.ogg')
    playsound(src,soundin,40,1)

/mob/living/simple_animal/hostile/titan/death(gibbed)
     var/datum/effect/effect/system/sleep_smoke_spread/smoke = new /datum/effect/effect/system/sleep_smoke_spread()
     smoke.set_up(15, 0, src.loc)
     smoke.attach(src)
     smoke.start()
     ..()



/mob/living/simple_animal/hostile/titan/LoseTarget()
    ..(9)