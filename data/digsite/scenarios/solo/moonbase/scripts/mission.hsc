(global boolean encounter03_test false)

(script static void setgravity
    (physics_set_gravity 0.36)
    (print "gravitylow")
)

(script dormant saveoutside
    (sleep_until (volume_test_objects "caveentrance" (players)))
    (print "save01")
    (game_save_unsafe)
)

(script dormant save01
    (sleep_until (volume_test_objects "save01" (players)))
    (print "save01")
    (game_save_unsafe)
)

(script dormant gravitysave
    (sleep_until (volume_test_objects "gravitysave" (players)))
    (print "gravitysave")
    (game_save_unsafe)
)

(script dormant aftergravitysave
    (sleep_until (volume_test_objects "6thencounter" (players)))
    (print "aftergravitysave")
    (game_save_unsafe)
)

(script dormant killplayer01
    (sleep_until (volume_test_objects "killplayer01" (players)))
    (print "you died!!!!!!")
    (game_revert)
)

(script dormant killplayer02
    (sleep_until (volume_test_objects "killplayer02" (players)))
    (print "you died!!!!!!")
    (game_revert)
)

(script dormant killplayer03
    (sleep_until (volume_test_objects "killplayer03" (players)))
    (print "you died!!!!!!")
    (game_revert)
)

(script dormant controlroom
    (print "controlroom")
    (ai_place "controlroom")
    (ai_place "controlroomelite")
    (ai_set_orders "controlroom" "8_controlroomattack")
    (ai_set_orders "controlroomelite" "8_controlroomattack")
    (sleep_until 
        (or
            (volume_test_objects "swordelite" (players))
            (<= (ai_living_count "controlroomelite") 0)
            (<= (ai_living_count "controlroom") 1)
        )
    )
    (ai_place "swordelite")
    (ai_set_orders "swordelite" "8_swordelite")
)

(script dormant 5thencounter
    (sleep_until (volume_test_objects "5thencounter" (players)))
    (print "5thencounter")
    (ai_place "5thencounter")
    (ai_set_orders "5thencounter" "8_attack")
    (wake controlroom)
)

(script dormant 6thencounter
    (sleep_until (volume_test_objects "6thencounter" (players)))
    (ai_place "6thencounter")
    (ai_set_orders "6thencounter" "11_attack")
    (sleep_until (volume_test_objects "5thencounter" (players)))
    (ai_set_orders "6thencounter" "11_attack02")
)

(script dormant 2ndprotopuz
    (object_create_containing "2ndprotopuz")
    (object_create_anew "giantdoor01control")
)

(script dormant 4thencounter
    (sleep_until (volume_test_objects "4thencounter" (players)))
    (print "4thencounter")
    (ai_place "4thencounter")
    (ai_set_orders "4thencounter" "7_attack")
    (wake 5thencounter)
    (wake 6thencounter)
)

(script command_script aim_at_glass
	(cs_go_to shootglass01wait/p0)
	(cs_aim false shootglass01wait/p1)
	(sleep 3000)
)

(script command_script shoot_at_glass
	(cs_go_to shootglass01/p0)
	(cs_shoot_point true shootglass01/p1)
	(sleep 15)
	(cs_shoot_point false shootglass01/p1)
	(cs_shoot_point true shootglass01/p2)
	(sleep 15)
	(cs_shoot_point false shootglass01/p2)
	(cs_shoot_point true shootglass01/p3)
	(sleep 15)
)

(script dormant shootglass01
    (ai_set_orders "3rdencounter" "9_attack")
	(cs_run_command_script 3rdencountertest aim_at_glass)
    (sleep_until (volume_test_objects "shootglass01" (players)) 15)
    (print "shootglass")
	(cs_run_command_script 3rdencountertest shoot_at_glass)
)

(script dormant 3rdencounter
    (sleep_until (volume_test_objects "3rdencounter" (players)))
    (ai_place "3rdencounter")
    (ai_place "3rdencountertest")
    (ai_set_orders "3rdencounter" "9_attack")
    (wake shootglass01)
    (wake 4thencounter)
    (wake 2ndprotopuz)
    (wake aftergravitysave)
)

(script dormant fallingdrive
    (sleep 30)
    ;(device_set_position "fallingdrive01" 1.0)
    (sleep 30)
    ;(device_set_position "fallingdrive02" 1.0)
    (sleep 5)
    ;(device_set_position "fallingdrive03" 1.0)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris05")
    (sleep 30)
    (print "fallingdrive04")
    ;(device_set_position "fallingdrive04" 1.0)
)

(script dormant debriseffects
    (print "debriseffects")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris01")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone.effect" "gravitydebris06")
    (sleep 30)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris02")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris07")
    (sleep 8)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris03")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris08")
    (sleep 25)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris04")
    (sleep 15)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris01")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris06")
    (sleep 30)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris02")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris07")
    (sleep 8)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris03")
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris08")
    (sleep 25)
    (effect_new "effects\impact\impact_bullet_large\hard_terrain_stone" "gravitydebris04")
)

(script dormant playershake
    (player_effect_set_max_rotation 0.0 0.3 0.3)
    (player_effect_start 1.0 2.0)
    (sleep 240)
    (player_effect_stop 2.0)
)

(script dormant alte
    (object_create_anew "alteeffect01")
    (object_create_anew "alteeffect02")
    (object_create_anew "alteeffect03")
    (object_create_anew "alteeffect04")
)

(script dormant altel
    (object_create_anew "alteleffect01")
    (object_create_anew "alteleffect02")
    (object_create_anew "alteleffect03")
    (object_create_anew "alteleffect04")
    (object_create_anew "alteleffect05")
    (object_create_anew "alteleffect06")
)

(script dormant gravity
    (sleep_until (<= (ai_living_count "powerroom01elites02") 0))
    (sleep 15)
    (print "!!!!!!!!!!!!! gravity restored !!!!!!!!!!!!!!!!")
    (print "!!!!!!!!!!!!! power restored !!!!!!!!!!!!!!!!")
    (ai_erase "2ndencounter")
    (ai_erase "2ndencounterlower")
    (switch_bsp 1)
    (object_create_containing "zdebris")
    (object_create_containing "powerlight")
    (object_create_anew "fallingdrive01")
    (object_create_anew "fallingdrive02")
    (object_create_anew "fallingdrive03")
    (object_create_anew "fallingdrive04")
    (wake fallingdrive)
    (wake playershake)
    (wake debriseffects)
    (object_create_anew "altelevatortrashed01")
    (object_create_anew "altelevatortrashed02")
    (object_create_anew "alte00")
    (object_create_anew "alte01")
    (object_create_anew "alte02")
    (object_create_anew "alte03")
    (object_create_anew "alte05")
    (object_create_anew "alte06")
    (object_create_anew "alte07")
    (object_destroy "alte08")
    (object_destroy "alte09")
    (object_create_anew "alteelite01")
    (object_create_anew "altegrunt01")
    (wake altel)
    (wake alte)
    (object_create_anew "altel01")
    (object_create_anew "altel02")
    (physics_set_gravity 1.0)
    (device_group_set_immediate "lockeddoors" 1.0)
    (sleep 30)
    (object_create_anew "alte04")
)

(script dormant powerroom01
    (sleep_until (volume_test_objects "gravitysave" (players)))
    (ai_place "powerroom01elites")
    (ai_place "powerroom01grunts")
    (ai_set_orders "powerroom01elites" "10_defend")
    (ai_set_orders "powerroom01grunts" "10_defend")
    (sleep_until (volume_test_objects "gravity" (players)))
    (print "attack")
    (ai_set_orders "powerroom01elites" "10_attack")
    (ai_set_orders "powerroom01grunts" "10_attack")
    (sleep_until 
        (and
            (<= (ai_living_count "powerroom01elites") 0)
            (<= (ai_living_count "powerroom01grunts") 0)
        )
    )
    (ai_place "powerroom01elites02")
    (ai_set_orders "powerroom01elites02" "10_attack")
    (wake gravity)
)

(script dormant 2ndencounterretreat
    (sleep_until (volume_test_objects "2ndencounterretreat" (players)))
    (ai_set_orders "2ndencounter" "6_retreat")
    (ai_set_orders "2ndencounterlower" "6_retreat")
)

(script dormant 2ndencounter
    (sleep_until (volume_test_objects "2ndencounter" (players)))
    (ai_erase "1stencounter")
    (ai_erase "1stencounter02")
    (ai_erase "2ndexplore")
    (ai_place "2ndencounter")
    (ai_set_orders "2ndencounter" "6_topattack")
    (print "2ndencounterlower")
    (ai_place "2ndencounterlower")
    (ai_set_orders "2ndencounterlower" "6_middleattack")
    (wake 2ndencounterretreat)
    (wake powerroom01)
    (wake 3rdencounter)
    (wake gravitysave)
    (sleep_until 
        (and
            (<= (ai_living_count "2ndencounter") 4)
            (>= (ai_living_count "2ndencounterlower") 5)
        )
    )
    (ai_set_orders "2ndencounterlower" "6_topattack")
)

(script dormant 2ndexplore
    (sleep_until (volume_test_objects "2ndexplore" (players)))
    (ai_place "2ndexplore")
    (ai_set_orders "2ndexplore" "5_attack")
    (wake 2ndencounter)
)

(script dormant 1stencounter02
    (sleep_until (<= (ai_living_count "1stencounter") 3))
    (device_group_set_immediate "1stencounter02" 1.0)
    (ai_place "1stencounter02")
    (ai_set_orders "1stencounter02" "4_attack02")
)

(script dormant 1stencounter
    (sleep_until 
        (or
            (volume_test_objects "1stencountermiddle" (players))
            (volume_test_objects "1stencounterright" (players))
            (volume_test_objects "1stencounterleft" (players))
        )
    )
    (ai_erase "moonbasefront")
    (ai_erase "moonbaserear")
    (ai_erase "encounter03")
    (ai_place "1stencounter")
    (ai_set_orders "1stencounter" "4_attack")
    (wake 1stencounter02)
    (wake 2ndexplore)
    (sleep_forever killplayer01)
    (sleep_forever killplayer02)
    (sleep_forever killplayer03)
)

(script dormant caveback
    (sleep_until 
        (or
            (volume_test_objects "cavecov02" (players))
            (volume_test_objects "cavecov02front" (players))
            (volume_test_objects "cavecov02pit" (players))
        )
    )
    (ai_place "caveback")
    (ai_place "cavegruntslower")
    (ai_set_orders "caveback" "1_caveback")
    (ai_set_orders "cavegruntslower" "1_gruntsattack")
    (sleep_until (volume_test_objects "caveback" (players)))
    (ai_erase "elites")
    (ai_set_orders "caveback" "1_cavefront")
    (ai_set_orders "cavegruntslower" "1_cavefront")
    (sleep_until (volume_test_objects "caveback" (players)))
    (ai_set_orders "caveback" "1_caveexit")
    (ai_set_orders "cavegruntslower" "1_caveexit")
)

(script dormant cavegrunts
    (sleep_until (volume_test_objects "cavegrunts" (players)))
    (ai_place "cavegrunts")
    (ai_set_orders "cavegrunts" "1_upcavecombat")
)

(script command_script encounter04dropship_fly
	(cs_vehicle_boost true)
	(cs_fly_by encounter04dropship/p0)
	(cs_vehicle_boost false)
	(cs_fly_by encounter04dropship/p1)
	(cs_fly_by encounter04dropship/p2)
	(cs_vehicle_boost true)
	(cs_fly_by encounter04dropship/p3)
	(cs_vehicle_boost false)
	(cs_fly_by encounter04dropship/p4)
	(cs_vehicle_boost true)
	(cs_fly_by encounter04dropship/p5)
	(cs_fly_by encounter04dropship/p6)
	(ai_erase ai_current_squad)
)

(script dormant encounter04dropship
    (print "encounter04dropship")
    (ai_place "encounter04dropship")
	(cs_run_command_script encounter04dropship encounter04dropship_fly)
)

(script dormant moonbaserear
    (print "moonbaseback")
    (ai_erase "elites")
    (ai_erase "cavegrunts")
    (ai_erase "caveback")
    (ai_place "moonbaserear")
    (ai_set_orders "moonbaserear" "2_rearattack")
    (sleep_until (volume_test_objects "moonbaserear" (players)) 15)
    (ai_set_orders "moonbaserear" "2_middlerear")
    (sleep_until (volume_test_objects "rearattack" (players)) 15)
    (ai_set_orders "moonbaserear" "2_rearattack02")
    (sleep_until (volume_test_objects "insidebase" (players)))
    (print "insidebase")
    (ai_set_orders "moonbaserear" "2_insidebase")
    (wake 1stencounter)
    (wake save01)
)

(script dormant moonbasefront
    (print "moonbasefront")
    (sleep_until (volume_test_objects "moonbasefront" (players)) 15)
    (print "moonbasefront")
    (ai_place "moonbasefront")
    ;(ai_set_orders "moonbasefront" "2_front")
    (sleep_until (volume_test_objects "moonbasemiddle" (players)) 15)
    (wake moonbaserear)
    (wake encounter04dropship)
    (ai_set_orders "moonbasefront" "2_middle")
    (sleep_until (volume_test_objects "moonbaserear" (players)) 15)
    (ai_set_orders "moonbasefront" "2_rear")
)

(script dormant fallback
    (print "fallback")
    (sleep_until (volume_test_objects "fallback" (players)))
    (print "fallback2")
    (ai_set_orders "elites" "0_fallback")
    (ai_place "grunts")
    (ai_set_orders "grunts" "0_retreat")
    (sleep_until (volume_test_objects "nearcave" (players)))
    (print "nearcave")
    (ai_set_orders "elites" "0_retreat")
    (sleep_until (volume_test_objects "caveentrance" (players)))
    (print "caveentrance")
    (ai_set_orders "elites" "0_caveentrance")
    (wake saveoutside)
)

(script dormant encounter03fallback
    (sleep_until (volume_test_objects "encounter03fallback" (players)) 15)
    (print "encounter03fallback")
    (ai_set_orders "encounter03" "3_encounter03fallback")
    (sleep_until (volume_test_objects "encounter03fallback" (players)) 15)
    (print "encounter03forward")
    (ai_set_orders "encounter03" "2_forward")
    (sleep_until (volume_test_objects "moonbaserear" (players)) 15)
    (print "encounter03middle")
    (ai_set_orders "encounter03" "2_encounter03middle")
)

(script static void dropshiploadalt
    (ai_place "encounter03")
	(ai_vehicle_enter_immediate encounter03 (ai_vehicle_get dropship04/starting_locations_0) "phantom_p")
)

(script static void dropshipunloadalt
    (print "dropshipalt")
	(ai_vehicle_exit "dropship04" "phantom_p")
    ;(ai_set_orders "encounter03" "3_encounter03")
)

(script static void dropshipload
    (ai_place "encounter03")
	(ai_vehicle_enter_immediate "encounter03" (ai_vehicle_get encounter03dropshipup/starting_locations_0) "phantom_p")
)

(script static void dropshipunload
	(ai_vehicle_exit "encounter03" "phantom_p")
    ;(ai_set_orders "encounter03" "3_encounter03")
)

(script command_script dropship04_fly
	(cs_fly_by dropship04/p0)
	(cs_vehicle_boost true)
	(cs_fly_by dropship04/p1)
	(ai_erase ai_current_squad)
)

(script dormant encounter03dropship
    (sleep_until (volume_test_objects "encounter03dropship" (players)) 15)
    (print "encounter03dropship")
    (if encounter03_test 
        (sleep_forever))
    (set encounter03_test true)
    (ai_place "dropship04")
    (wake encounter03fallback)
    (wake moonbasefront)
    (dropshiploadalt)
	(sleep 30)
    (dropshipunloadalt)
	(sleep 90)
	(cs_run_command_script dropship04 dropship04_fly)
	
)

(script command_script encounter03dropshipup_fly
	(cs_fly_by encounter03dropshipup/p0)
	(cs_fly_by encounter03dropshipup/p1)
	(cs_fly_by encounter03dropshipup/p2)
	(cs_fly_by encounter03dropshipup/p3)
	(cs_fly_by encounter03dropshipup/p4)
	(cs_fly_by encounter03dropshipup/p5)
	(cs_fly_by encounter03dropshipup/p6)
	(cs_fly_by encounter03dropshipup/p7)
	(cs_fly_by encounter03dropshipup/p8)
	(cs_fly_by encounter03dropshipup/p9)
	(cs_fly_by encounter03dropshipup/p10)
	(cs_fly_by encounter03dropshipup/p11)
	(cs_fly_by encounter03dropshipup/p12)
	(cs_fly_by encounter03dropshipup/p13)
	(cs_fly_by encounter03dropshipup/p14)
	(cs_fly_by encounter03dropshipup/p15)
	(ai_erase ai_current_squad)
)

(script dormant encounter03
    (sleep_until (volume_test_objects "encounter03" (players)))
    (print "encounter03")
    (if encounter03_test 
        (sleep_forever))
    (set encounter03_test true)
    (ai_place "encounter03dropshipup")
	(cs_run_command_script encounter03dropshipup encounter03dropshipup_fly)
    (wake encounter03fallback)
    (wake moonbasefront)
    (dropshipload)
    (dropshipunload)
)

(script dormant encounter03dropshipup
    (sleep_until (volume_test_objects "encounter03dropshipup" (players)))
    (print "encounter03dropshipup")
    (if encounter03_test 
        (sleep_forever))
    (set encounter03_test true)
    (ai_place "encounter03dropshipup")
	(cs_run_command_script encounter03dropshipup encounter03dropshipup_fly)
    (wake encounter03fallback)
    (wake moonbasefront)
    (dropshipload)
    (dropshipunload)
)

(script command_script dropship01_fly
	(cs_vehicle_boost true)
	(cs_fly_by dropship01/p0)
	(cs_vehicle_boost false)
	(cs_fly_by dropship01/p1)
	(cs_fly_by dropship01/p2)
	(cs_vehicle_boost true)
	(cs_fly_by dropship01/p3)
	(cs_vehicle_boost false)
	(cs_fly_by dropship01/p4)
	(cs_fly_by dropship01/p5)
	(cs_fly_by dropship01/p6)
	(cs_vehicle_boost true)
	(cs_fly_by dropship01/p7)
	(cs_fly_by dropship01/p8)
	(ai_erase ai_current_squad)
)

(script dormant dropship01
    (physics_set_gravity 0.36)
    (ai_place "dropship01")
	(cs_run_command_script dropship01 dropship01_fly)
)

(script command_script dropship02_fly
	(cs_vehicle_boost true)
	(cs_fly_by dropship02/p0)
	(cs_vehicle_boost false)
	(cs_fly_by dropship02/p1)
	(cs_fly_by dropship02/p2)
	(cs_fly_by dropship02/p3)
	(cs_fly_by dropship02/p4)
	(cs_fly_by dropship02/p5)
	(cs_vehicle_boost true)
	(cs_fly_by dropship02/p6)
	(cs_fly_by dropship02/p7)
	(ai_erase ai_current_squad)
)

(script command_script dropship03_fly
	(cs_vehicle_boost true)
	(cs_fly_by dropship03/p0)
	(cs_vehicle_boost false)
	(cs_fly_by dropship03/p1)
	(cs_fly_by dropship03/p2)
	(cs_fly_by dropship03/p3)
	(cs_fly_by dropship03/p4)
	(cs_fly_by dropship03/p5)
	(cs_fly_by dropship03/p6)
	(cs_vehicle_boost true)
	(cs_fly_by dropship03/p7)
	(ai_erase ai_current_squad)
)

(script static void dropship01play
    (physics_set_gravity 0.36)
    (wake dropship01)
    (ai_place "dropship02")
	(cs_run_command_script dropship02 dropship02_fly)
    (ai_place "dropship03")
	(cs_run_command_script dropship03 dropship03_fly)
)

(script static void record
    (print "record")
    (physics_set_gravity 0.36)
    (dropship01play)
)

(script dormant end_mission
    (sleep_until (volume_test_objects "mission_complete" (players)))
    (print "Digsite salutes you")
    (game_won)
)

(script static void set_space_sound_environment
	;Make it sound like we're in a space vacuum
	(set_global_sound_environment 1 1 0 0 1000 5)
	;(ai_dialogue_enable 0) ; This is here because AI spoken dialogue is not affected by whatever the above is doing in MCC. Seems like a port bug - General_101

)

(script static void set_world_sound_environment
	;Make it sound like we're not in a space vacuum
	(set_global_sound_environment 1 1 1 1 8000 0)
	;(ai_dialogue_enable 1)
)

(script dormant airlock
    (sleep_until (volume_test_objects "airlock" (players)))
	(volume_teleport_players_not_inside "airlock" airlock_flag)
	(device_set_position airlock_door_01 0)
	(device_set_position airlock_door_02 0)
	(sleep 60)
	(sound_impulse_start "sound\visual_effects\ss_airlock\airlock_repressurize" NONE 1)
	(device_set_position airlock_door_03 1)
	(set_world_sound_environment)
)

(script startup elites
	(if (>= (player_count) 2)
		(object_create_anew "caveghost02")
	)
	(set_space_sound_environment)
	(game_can_use_flashlights true)
	(ai_allegiance player human)
	(ai_allegiance covenant prophet)
	(ai_allegiance prophet covenant)
	(fade_in 0 0 0 0)
	(cinematic_show_letterbox 0)
    (physics_set_gravity 0.36)
    (ai_set_orders "elites" "0_test")
	(ai_place "elites")
    (device_group_set_immediate "lockeddoors" 0.0)
    (device_group_set_immediate "1stencounter02" 0.0)
	(wake airlock)
    (wake fallback)
    (wake cavegrunts)
    (wake caveback)
    (wake encounter03dropship)
    (wake encounter03dropshipup)
    (wake encounter03)
	(wake end_mission)
    (wake killplayer01)
    (wake killplayer02)
    (wake killplayer03)
    (record)
)

(script static void move
	(print "stub")
    ;(ai_set_orders "elites" "0_testorder02")
)

(script static void cheat
    (wake 2ndencounter)
    (volume_teleport_players_not_inside "null" "2ndencounter")
    (game_save_unsafe)
)
