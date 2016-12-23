///////////////////////////////////
//////////Autolathe Designs ///////
///////////////////////////////////

/* TOOLS */

/datum/design/bucket
	name = "Bucket"
	id = "bucket"
	build_type = AUTOLATHE
	materials = list("$metal" = 200)
	build_path = /obj/item/weapon/reagent_containers/glass/bucket
	category = list("initial","Tools")

/datum/design/crowbar
	name = "Pocket crowbar"
	id = "crowbar"
	build_type = AUTOLATHE
	materials = list("$metal" = 50)
	build_path = /obj/item/weapon/crowbar
	category = list("initial","Tools")

/datum/design/flashlight
	name = "Flashlight"
	id = "flashlight"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 20)
	build_path = /obj/item/device/flashlight
	category = list("initial","Tools")

/datum/design/extinguisher
	name = "Fire extinguisher"
	id = "extinguisher"
	build_type = AUTOLATHE
	materials = list("$metal" = 90)
	build_path = /obj/item/weapon/extinguisher
	category = list("initial","Tools")

/datum/design/multitool
	name = "Multitool"
	id = "multitool"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 20)
	build_path = /obj/item/device/multitool
	category = list("initial","Tools")

/datum/design/analyzer
	name = "Analyzer"
	id = "analyzer"
	build_type = AUTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	build_path = /obj/item/device/analyzer
	category = list("initial","Tools")

/datum/design/tscanner
	name = "T-ray scanner"
	id = "tscanner"
	build_type = AUTOLATHE
	materials = list("$metal" = 150)
	build_path = /obj/item/device/t_scanner
	category = list("initial","Tools")

/datum/design/weldingtool
	name = "Welding tool"
	id = "welding_tool"
	build_type = AUTOLATHE
	materials = list("$metal" = 70, "$glass" = 20)
	build_path = /obj/item/weapon/weldingtool
	category = list("initial","Tools")

/datum/design/screwdriver
	name = "Screwdriver"
	id = "screwdriver"
	build_type = AUTOLATHE
	materials = list("$metal" = 75)
	build_path = /obj/item/weapon/screwdriver
	category = list("initial","Tools")

/datum/design/wirecutters
	name = "Wirecutters"
	id = "wirecutters"
	build_type = AUTOLATHE
	materials = list("$metal" = 80)
	build_path = /obj/item/weapon/wirecutters
	category = list("initial","Tools")

/datum/design/wrench
	name = "Wrench"
	id = "wrench"
	build_type = AUTOLATHE
	materials = list("$metal" = 150)
	build_path = /obj/item/weapon/wrench
	category = list("initial","Tools")

/datum/design/welding_helmet
	name = "Welding helmet"
	id = "welding_helmet"
	build_type = AUTOLATHE
	materials = list("$metal" = 1750, "$glass" = 400)
	build_path = /obj/item/clothing/head/welding
	category = list("initial","Tools")

/datum/design/cable_coil
	name = "Cable coil"
	id = "cable_coil"
	build_type = AUTOLATHE
	materials = list("$metal" = 10, "$glass" = 5)
	build_path = /obj/item/stack/cable_coil/random
	category = list("initial","Tools")
	maxstack = 30

/datum/design/toolbox
	name = "Toolbox"
	id = "tool_box"
	build_type = AUTOLATHE
	materials = list("$metal" = 500)
	build_path = /obj/item/weapon/storage/toolbox
	category = list("initial","Tools")

datum/design/light_replacer
	name = "Advanced Light Replacer"
	id = "light_replacer"
	build_type = PROTOLATHE
	materials = list("$metal" = 1500, "$glass" = 3000)
	build_path = /obj/item/device/lightreplacer/adv
	category = list("initial", "Tools")

/datum/design/spraycan
	name = "Spraycan"
	id = "spraycan"
	build_type = AUTOLATHE
	materials = list("$metal" = 100, "$glass" = 100)
	build_path = /obj/item/toy/crayon/spraycan
	category = list("initial", "Tools")

//hacked autolathe recipes
/datum/design/electropack
	name = "Electropack"
	id = "electropack"
	build_type = AUTOLATHE
	materials = list("$metal" = 10000, "$glass" = 2500)
	build_path = /obj/item/device/electropack
	category = list("hacked", "Tools")

/datum/design/large_welding_tool
	name = "Industrial welding tool"
	id = "large_welding_tool"
	build_type = AUTOLATHE
	materials = list("$metal" = 70, "$glass" = 60)
	build_path = /obj/item/weapon/weldingtool/largetank
	category = list("hacked", "Tools")

/datum/design/hexkey
	name = "Hex Key"
	id = "hexkey"
	build_type = AUTOLATHE
	materials = list("$metal" = 20)
	build_path = /obj/item/weapon/hexkey
	category = list("hacked", "Tools")

/* ELECTRONICS */

/datum/design/console_screen
	name = "Console screen"
	id = "console_screen"
	build_type = AUTOLATHE
	materials = list("$glass" = 200)
	build_path = /obj/item/weapon/stock_parts/console_screen
	category = list("initial", "Electronics")

/datum/design/apc_board
	name = "APC Power Control Module"
	id = "power control"
	build_type = AUTOLATHE
	materials = list("$metal" = 100, "$glass" = 100)
	build_path = /obj/item/weapon/module/power_control
	category = list("initial", "Electronics")

/datum/design/airlock_board
	name = "Airlock electronics"
	id = "airlock_board"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = /obj/item/weapon/airlock_electronics
	category = list("initial", "Electronics")

/datum/design/firelock_board
	name = "Firelock circuitry"
	id = "firelock_board"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = /obj/item/weapon/firelock_board
	category = list("initial", "Electronics")

/datum/design/airalarm_electronics
	name = "Air alarm electronics"
	id = "airalarm_electronics"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = /obj/item/weapon/airalarm_electronics
	category = list("initial", "Electronics")

/datum/design/firealarm_electronics
	name = "Fire alarm electronics"
	id = "firealarm_electronics"
	build_type = AUTOLATHE
	materials = list("$metal" = 50, "$glass" = 50)
	build_path = /obj/item/weapon/firealarm_electronics
	category = list("initial", "Electronics")

/datum/design/desttagger
	name = "Destination tagger"
	id = "desttagger"
	build_type = AUTOLATHE
	materials = list("$metal" = 250, "$glass" = 125)
	build_path = /obj/item/device/destTagger
	category = list("initial", "Electronics")

/datum/design/handlabeler
	name = "Hand labeler"
	id = "handlabel"
	build_type = AUTOLATHE
	materials = list("$metal" = 150, "$glass" = 125)
	build_path = /obj/item/weapon/hand_labeler
	category = list("initial", "Electronics")


/* MISC */

/datum/design/pipe_painter
	name = "Pipe painter"
	id = "pipe_painter"
	build_type = AUTOLATHE
	materials = list("$metal" = 5000, "$glass" = 2000)
	build_path = /obj/item/device/pipe_painter
	category = list("initial", "Misc")

/datum/design/cultivator
	name = "Cultivator"
	id = "cultivator"
	build_type = AUTOLATHE
	materials = list("$metal"=50)
	build_path = /obj/item/weapon/cultivator
	category = list("initial","Misc")

/datum/design/plant_analyzer
	name = "Plant analyzer"
	id = "plant_analyzer"
	build_type = AUTOLATHE
	materials = list("$metal" = 30, "$glass" = 20)
	build_path = /obj/item/device/analyzer/plant_analyzer
	category = list("initial","Misc")

/datum/design/shovel
	name = "Shovel"
	id = "shovel"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/weapon/shovel
	category = list("initial","Misc")


/datum/design/pickaxe
	name = "Shovel"
	id = "shovel"
	build_type = AUTOLATHE
	materials = list("$metal" = 8000)
	build_path = /obj/item/weapon/pickaxe
	category = list("initial","Misc")

/datum/design/roller
	name = "Roller bed"
	id = "roller"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/roller
	category = list("initial","Misc")

/datum/design/spade
	name = "Spade"
	id = "spade"
	build_type = AUTOLATHE
	materials = list("$metal" = 3000)
	build_path = /obj/item/weapon/shovel/spade
	category = list("initial","Misc")

/datum/design/hatchet
	name = "Hatchet"
	id = "hatchet"
	build_type = AUTOLATHE
	materials = list("$metal" = 15000)
	build_path = /obj/item/weapon/hatchet
	category = list("initial","Misc")

/datum/design/recorder
	name = "Universal recorder"
	id = "recorder"
	build_type = AUTOLATHE
	materials = list("$metal" = 60, "$glass" = 30)
	build_path = /obj/item/device/taperecorder/empty
	category = list("initial", "Misc")

/datum/design/tape
	name = "Tape"
	id = "tape"
	build_type = AUTOLATHE
	materials = list("$metal" = 20, "$glass" = 5)
	build_path = /obj/item/device/tape
	category = list("initial", "Misc")

/datum/design/igniter
	name = "Igniter"
	id = "igniter"
	build_type = AUTOLATHE
	materials = list("$metal" = 500, "$glass" = 50)
	build_path = /obj/item/device/assembly/igniter
	category = list("initial", "Misc")

/datum/design/infrared_emitter
	name = "Infrared emitter"
	id = "infrared_emitter"
	build_type = AUTOLATHE
	materials = list("$metal" = 1000, "$glass" = 500)
	build_path = /obj/item/device/assembly/infra
	category = list("initial", "Misc")

/datum/design/timer
	name = "Timer"
	id = "timer"
	build_type = AUTOLATHE
	materials = list("$metal" = 500, "$glass" = 50)
	build_path = /obj/item/device/assembly/timer
	category = list("initial", "Misc")

/datum/design/voice_analyser
	name = "Voice analyser"
	id = "voice_analyser"
	build_type = AUTOLATHE
	materials = list("$metal" = 500, "$glass" = 50)
	build_path = /obj/item/device/assembly/voice
	category = list("initial", "Misc")

/datum/design/prox_sensor
	name = "Proximity sensor"
	id = "prox_sensor"
	build_type = AUTOLATHE
	materials = list("$metal" = 800, "$glass" = 200)
	build_path = /obj/item/device/assembly/prox_sensor
	category = list("initial", "Misc")

/datum/design/foam_dart
	name = "Box of Foam Darts"
	id = "foam_dart"
	build_type = AUTOLATHE
	materials = list("$metal" = 500)
	build_path = /obj/item/ammo_box/foambox
	category = list("initial", "Misc")

/datum/design/breathmask
	name = "Breath mask"
	id = "breathmask"
	build_type = AUTOLATHE
	materials = list("$metal" = 200, "$glass" = 200)
	build_path = /obj/item/clothing/mask/breath
	category = list("initial", "Misc")

/datum/design/gasmask
	name = "Gas mask"
	id = "gasmask"
	build_type = AUTOLATHE
	materials = list("$metal" = 500, "$glass" = 500)
	build_path = /obj/item/clothing/mask/gas
	category = list("initial", "Misc")

/datum/design/metalbat
	name = "Metal bat"
	id = "metalbat"
	build_type = AUTOLATHE
	materials = list("$metal" = 18750, "$glass" = 200)
	build_path = /obj/item/weapon/twohanded/baseballbat/metal
	category = list("initial", "Misc")

/datum/design/airtank_small
	name = "Emergency oxygen tank"
	id = "airtank_small"
	build_type = AUTOLATHE
	materials = list("$metal" = 200)
	build_path = /obj/item/weapon/tank/internals/emergency_oxygen/empty
	category = list("initial", "Misc")

/datum/design/airtank_extended
	name = "Extended-capacity emergency oxygen tank"
	id = "airtank_engi"
	build_type = AUTOLATHE
	materials = list("$metal" = 300)
	build_path = /obj/item/weapon/tank/internals/emergency_oxygen/engi/empty
	category = list("initial", "Misc")

/datum/design/airtank_double
	name = "Double emergency oxygen tank"
	id = "airtank_double"
	build_type = AUTOLATHE
	materials = list("$metal" = 400)
	build_path = /obj/item/weapon/tank/internals/emergency_oxygen/double/empty
	category = list("initial", "Misc")

/* CONSTRUCTION */

/datum/design/metal
	name = "Metal"
	id = "metal"
	build_type = AUTOLATHE
	materials = list("$metal" = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/metal
	category = list("initial","Construction")
	maxstack = 50

/datum/design/glasstableparts
	name = "Glass table parts"
	id = "glasstable"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000, "$glass" = 10000)
	build_path = /obj/item/weapon/table_parts/glass
	category = list("initial","Construction")

/datum/design/glass
	name = "Glass"
	id = "glass"
	build_type = AUTOLATHE
	materials = list("$glass" = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/glass
	category = list("initial","Construction")
	maxstack = 50

/datum/design/rglass
	name = "Reinforced glass"
	id = "rglass"
	build_type = AUTOLATHE
	materials = list("$metal" = 1000, "$glass" = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/rglass
	category = list("initial","Construction")
	maxstack = 50

/datum/design/rods
	name = "Metal rod"
	id = "rods"
	build_type = AUTOLATHE
	materials = list("$metal" = 1000)
	build_path = /obj/item/stack/rods
	category = list("initial","Construction")
	maxstack = 50

/datum/design/rcd_ammo
	name = "Compressed matter cardridge"
	id = "rcd_ammo"
	build_type = AUTOLATHE
	materials = list("$metal" = 16000, "$glass"=8000)
	build_path = /obj/item/weapon/rcd_ammo
	category = list("initial","Construction")

/datum/design/light_tube
	name = "Light tube"
	id = "light_tube"
	build_type = AUTOLATHE
	materials = list("$metal" = 60, "$glass" = 100)
	build_path = /obj/item/weapon/light/tube
	category = list("initial", "Construction")

/datum/design/light_bulb
	name = "Light bulb"
	id = "light_bulb"
	build_type = AUTOLATHE
	materials = list("$metal" = 60, "$glass" = 100)
	build_path = /obj/item/weapon/light/bulb
	category = list("initial", "Construction")

/datum/design/camera_assembly
	name = "Camera assembly"
	id = "camera_assembly"
	build_type = AUTOLATHE
	materials = list("$metal" = 400, "$glass" = 250)
	build_path = /obj/item/weapon/camera_assembly
	category = list("initial", "Construction")

/datum/design/newscaster_frame
	name = "Newscaster frame"
	id = "newscaster_frame"
	build_type = AUTOLATHE
	materials = list("$metal" = 14000, "$glass" = 8000)
	build_path = /obj/item/wallframe/newscaster
	category = list("initial", "Construction")

/datum/design/painter
	name = "tile painter"
	id = "tile_painter"
	build_type = AUTOLATHE
	materials = list("$metal" = 11000, "$glass"=5000)
	build_path = /obj/item/weapon/tile_painter
	category = list("initial","Construction")

//hacked autolathe recipes
/datum/design/rcd
	name = "Rapid construction device (RCD)"
	id = "rcd"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/weapon/rcd
	category = list("hacked", "Construction")

/datum/design/rpd
	name = "Rapid pipe dispenser (RPD)"
	id = "rpd"
	build_type = AUTOLATHE
	materials = list("$metal" = 75000, "$glass" = 37500)
	build_path = /obj/item/weapon/pipe_dispenser
	category = list("hacked", "Construction")

/* DINNERWARE */

/datum/design/kitchen_knife
	name = "Kitchen knife"
	id = "kitchen_knife"
	build_type = AUTOLATHE
	materials = list("$metal" = 12000)
	build_path = /obj/item/weapon/kitchen/knife
	category = list("initial","Dinnerware")

/datum/design/fork
	name = "Fork"
	id = "fork"
	build_type = AUTOLATHE
	materials = list("$metal" = 80)
	build_path = /obj/item/weapon/kitchen/fork
	category = list("initial","Dinnerware")

/datum/design/tray
	name = "Tray"
	id = "tray"
	build_type = AUTOLATHE
	materials = list("$metal" = 3000)
	build_path = /obj/item/weapon/storage/bag/tray
	category = list("initial","Dinnerware")

/datum/design/bowl
	name = "Bowl"
	id = "bowl"
	build_type = AUTOLATHE
	materials = list("$glass" = 500)
	build_path = /obj/item/weapon/reagent_containers/glass/bowl
	category = list("initial","Dinnerware")

/datum/design/drinking_glass
	name = "Drinking glass"
	id = "drinking_glass"
	build_type = AUTOLATHE
	materials = list("$glass" = 500)
	build_path = /obj/item/weapon/reagent_containers/food/drinks/drinkingglass
	category = list("initial","Dinnerware")

/datum/design/bottle
	name = "Bottle"
	id = "bottle"
	build_type = AUTOLATHE
	materials = list("$glass" = 500)
	build_path = /obj/item/weapon/reagent_containers/food/drinks/bottle
	category = list("initial","Dinnerware")

/datum/design/shot_glass
	name = "Shot glass"
	id = "shot_glass"
	build_type = AUTOLATHE
	materials = list("$glass" = 100)
	build_path = /obj/item/weapon/reagent_containers/food/drinks/drinkingglass/shotglass
	category = list("initial","Dinnerware")

/datum/design/shaker
	name = "Shaker"
	id = "shaker"
	build_type = AUTOLATHE
	materials = list("$metal" = 1500)
	build_path = /obj/item/weapon/reagent_containers/food/drinks/shaker
	category = list("initial","Dinnerware")

//hacked autolathe recipes
/datum/design/cleaver
	name = "Butcher's cleaver"
	id = "cleaver"
	build_type = AUTOLATHE
	materials = list("$metal" = 18000)
	build_path = /obj/item/weapon/kitchen/knife/butcher
	category = list("hacked", "Dinnerware")

/* MEDICAL */

/datum/design/scalpel
	name = "Scalpel"
	id = "scalpel"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000, "$glass" = 1000)
	build_path = /obj/item/weapon/scalpel
	category = list("initial", "Medical")

/datum/design/circular_saw
	name = "Circular saw"
	id = "circular_saw"
	build_type = AUTOLATHE
	materials = list("$metal" = 10000, "$glass" = 6000)
	build_path = /obj/item/weapon/circular_saw
	category = list("initial", "Medical")

/datum/design/surgicaldrill
	name = "Surgical drill"
	id = "surgicaldrill"
	build_type = AUTOLATHE
	materials = list("$metal" = 10000, "$glass" = 6000)
	build_path = /obj/item/weapon/surgicaldrill
	category = list("initial", "Medical")

/datum/design/retractor
	name = "Retractor"
	id = "retractor"
	build_type = AUTOLATHE
	materials = list("$metal" = 6000, "$glass" = 3000)
	build_path = /obj/item/weapon/retractor
	category = list("initial", "Medical")

/datum/design/cautery
	name = "Cautery"
	id = "cautery"
	build_type = AUTOLATHE
	materials = list("$metal" = 2500, "$glass" = 750)
	build_path = /obj/item/weapon/cautery
	category = list("initial", "Medical")

/datum/design/hemostat
	name = "Hemostat"
	id = "hemostat"
	build_type = AUTOLATHE
	materials = list("$metal" = 5000, "$glass" = 2500)
	build_path = /obj/item/weapon/hemostat
	category = list("initial", "Medical")

/datum/design/beaker
	name = "Beaker"
	id = "beaker"
	build_type = AUTOLATHE
	materials = list("$glass" = 500)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker
	category = list("initial", "Medical")

/datum/design/large_beaker
	name = "Large beaker"
	id = "large_beaker"
	build_type = AUTOLATHE
	materials = list("$glass" = 2500)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/large
	category = list("initial", "Medical")

/datum/design/syringe
	name = "Syringe"
	id = "syringe"
	build_type = AUTOLATHE
	materials = list("$metal" = 10, "$glass" = 20)
	build_path = /obj/item/weapon/reagent_containers/syringe
	category = list("initial", "Medical")

/datum/design/healthsensor
	name = "Health sensor"
	id = "healthsensor"
	build_type = AUTOLATHE
	materials = list("$metal" = 800, "$glass" = 200)
	build_path = /obj/item/device/assembly/health
	category = list("initial", "Medical")

/* SECURITY */

/datum/design/beanbag_slug
	name = "Beanbag slug"
	id = "beanbag_slug"
	build_type = AUTOLATHE
	materials = list("$metal" = 250)
	build_path = /obj/item/ammo_casing/shotgun/beanbag
	category = list("initial", "Security")

/datum/design/c38
	name = "Speed loader (.38)"
	id = "c38"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/c38
	category = list("initial", "Security")

//hacked autolathe recipes
/datum/design/handcuffs
	name = "Handcuffs"
	id = "handcuffs"
	build_type = AUTOLATHE
	materials = list("$metal" = 500)
	build_path = /obj/item/weapon/restraints/handcuffs
	category = list("hacked", "Security")

/datum/design/barrel
	name = "Glock barrel"
	id = "barrel"
	build_type = AUTOLATHE
	materials = list("$metal" = 350000)
	build_path = /obj/item/glockbarrel
	category = list("hacked", "Security")

/datum/design/shotgun_slug
	name = "Shotgun slug"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list("hacked", "Security")

/datum/design/buckshot_shell
	name = "Buckshot shell"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("hacked", "Security")

/datum/design/shotgun_dart
	name = "Shotgun dart"
	id = "shotgun_dart"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/ammo_casing/shotgun/dart
	category = list("hacked", "Security")

/datum/design/incendiary_slug
	name = "Incendiary slug"
	id = "incendiary_slug"
	build_type = AUTOLATHE
	materials = list("$metal" = 4000)
	build_path = /obj/item/ammo_casing/shotgun/incendiary
	category = list("hacked", "Security")

/datum/design/a357
	name = "Ammo box (.357)"
	id = "a357"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/a357
	category = list("hacked", "Security")

/datum/design/c10mm
	name = "Ammo box (10mm)"
	id = "c10mm"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/c10mm
	category = list("hacked", "Security")

/datum/design/m9mm
	name = "Magazine (9mm)"
	id = "m9mm"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list("hacked", "Security")

/datum/design/c45
	name = "Ammo box (.45)"
	id = "c45"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/c45
	category = list("hacked", "Security")

/datum/design/c9mm
	name = "Ammo box (9mm)"
	id = "c9mm"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/c9mm
	category = list("hacked", "Security")

/datum/design/expansionc38
	name = "Expansion .38 speed loader"
	id = "38"
	build_type = AUTOLATHE
	materials = list("$metal" = 30000)
	build_path = /obj/item/ammo_box/c38/expansion
	category = list ("hacked", "Security")

/datum/design/brassknuckles
	name = "Brass knuckles"
	id = "brassknuckles"
	build_type = AUTOLATHE
	materials = list("$metal" = 5000)
	build_path = /obj/item/clothing/gloves/brassknuckles
	category = list("hacked", "Security")

 /datum/design/riotammo
	name = "foam force pistol magazine"
	id = "riot"
	build_type = AUTOLATHE
	materials = list("$metal" = 25000)
	build_path = /obj/item/ammo_box/magazine/toy/pistol/riot
	category = list("hacked", "Security")

/* T-COMM */

/datum/design/signaler
	name = "Remote signaling device"
	id = "signaler"
	build_type = AUTOLATHE
	materials = list("$metal" = 400, "$glass" = 120)
	build_path = /obj/item/device/assembly/signaler
	category = list("initial", "T-Comm")

/datum/design/radio_headset
	name = "Radio headset"
	id = "radio_headset"
	build_type = AUTOLATHE
	materials = list("$metal" = 75)
	build_path = /obj/item/device/radio/headset
	category = list("initial", "T-Comm")

/datum/design/bounced_radio
	name = "Station bounced radio"
	id = "bounced_radio"
	build_type = AUTOLATHE
	materials = list("$metal" = 75, "$glass" = 25)
	build_path = /obj/item/device/radio/off
	category = list("initial", "T-Comm")

/* BOARD GAMES */

/datum/design/d2
	name = "D2"
	id = "d2"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d2
	category = list("initial", "BoardGames")

/datum/design/d4
	name = "D4"
	id = "d4"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d4
	category = list("initial", "BoardGames")

/datum/design/d6
	name = "D6"
	id = "d6"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice
	category = list("initial", "BoardGames")

/datum/design/d8
	name = "D8"
	id = "d8"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d8
	category = list("initial", "BoardGames")

/datum/design/d10
	name = "D10"
	id = "d10"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d10
	category = list("initial", "BoardGames")

/datum/design/d00
	name = "D00"
	id = "d00"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d00
	category = list("initial", "BoardGames")

/datum/design/d12
	name = "D12"
	id = "d12"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d12
	category = list("initial", "BoardGames")

/datum/design/d20
	name = "D20"
	id = "d20"
	build_type = AUTOLATHE
	materials = list("$metal" = 10)
	build_path = /obj/item/weapon/dice/d20
	category = list("initial", "BoardGames")

/datum/design/dice_bag
	name = "Empty dice bag"
	id = "dise-bag"
	build_type = AUTOLATHE
	materials = list("$metal" = 20)
	build_path = /obj/item/weapon/storage/pill_bottle/dice/empty
	category = list("initial", "BoardGames")

/datum/design/dice_cubes
	name = "6D6 dice kit"
	id = "dise-bag-6d6"
	build_type = AUTOLATHE
	materials = list("$metal" = 80)
	build_path = /obj/item/weapon/storage/pill_bottle/dice/cubes
	category = list("initial", "BoardGames")

/datum/design/dice_variety
	name = "D4 D6 D8 D10 D00 D12 & D20 dice kit"
	id = "dise-bag-variety"
	build_type = AUTOLATHE
	materials = list("$metal" = 90)
	build_path = /obj/item/weapon/storage/pill_bottle/dice
	category = list("initial", "BoardGames")

/* secret (well, this ones are awalable, but only by search) */

//hacked autolathe recipes
/datum/design/flamethrower
	name = "Flamethrower"
	id = "flamethrower"
	build_type = AUTOLATHE
	materials = list("$metal" = 500)
	build_path = /obj/item/weapon/flamethrower/full
	category = list("hacked", "Weapons and ammo")





