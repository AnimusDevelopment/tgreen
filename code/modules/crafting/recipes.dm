/datum/table_recipe
	var/name = "" //in-game display name
	var/reqs[] = list() //type paths of items consumed associated with how many are needed
	var/result //type path of item resulting from this craft
	var/tools[] = list() //type paths of items needed but not consumed
	var/time = 30 //time in deciseconds
	var/parts[] = list() //type paths of items that will be placed in the result
	var/chem_catalysts[] = list() //like tools but for reagents


/datum/table_recipe/IED
	name = "IED"
	result = /obj/item/weapon/grenade/iedcasing
	reqs = list(/datum/reagent/fuel = 50,
				/obj/item/stack/cable_coil = 1,
				/obj/item/device/assembly/igniter = 1,
				/obj/item/weapon/reagent_containers/food/drinks/soda_cans = 1)
	parts = list(/obj/item/weapon/reagent_containers/food/drinks/soda_cans = 1)
	time = 80

/datum/table_recipe/stunprod
	name = "Stunprod"
	result = /obj/item/weapon/melee/baton/cattleprod
	reqs = list(/obj/item/weapon/restraints/handcuffs/cable = 1,
				/obj/item/stack/rods = 1,
				/obj/item/weapon/wirecutters = 1,
				/obj/item/weapon/stock_parts/cell = 1)
	time = 80
	parts = list(/obj/item/weapon/stock_parts/cell = 1)

/datum/table_recipe/clustered_IED
	name = "Clustered IED"
	result = /obj/item/weapon/grenade/clustered_ied
	reqs = list(/obj/item/weapon/grenade/iedcasing = 8,
				/obj/item/stack/cable_coil = 15,
				/obj/item/device/assembly/signaler = 1)
	time = 240
	parts = list(/obj/item/device/assembly/signaler = 1)

/datum/table_recipe/dicecup
	name = "Dicecup"
	reqs = list(/obj/item/weapon/reagent_containers/food/drinks/soda_cans = 1)
	result = /obj/item/weapon/storage/bag/dicecup
	time = 75

