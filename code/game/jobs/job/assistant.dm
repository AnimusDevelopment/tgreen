/*
Assistant
*/
/datum/job/assistant
	title = "Assistant"
	r_title = "àññèñòåíò"
	flag = ASSISTANT
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "àáñîëþòíî âñåì"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()

/datum/job/assistant/equip_items(var/mob/living/carbon/human/H)
	if (prob(15) && H.gender == "male")
		H.equip_to_slot_or_del(new /obj/item/dogtag/jobspawn(H), slot_neck)
		dog = 1 
		if (dog = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/pants/camo(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	else
		H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)

/datum/job/assistant/get_access()
		. = ..()
		. |= list(access_maint_tunnels)

/datum/job/assistant/config_check()
	if(config && !(config.assistant_cap == 0))
		total_positions = config.assistant_cap
		spawn_positions = config.assistant_cap
		return 1
	return 0
