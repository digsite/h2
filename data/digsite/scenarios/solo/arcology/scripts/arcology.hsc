(global boolean g_s4_started false)
(global boolean g_s4_cov_courtyard_alerted false)
(global boolean g_s3_started false)

(script static void s4_cov_raise_courtyard_alarm
    (begin
        (set g_s4_cov_courtyard_alerted true)
    )
)

(script static boolean os_s4_cov_courtyard_alerted
    (begin
        (= g_s4_cov_courtyard_alerted true)
    )
)

(script static void oes_s4_cov_wraith0_load
    (begin
        (s4_cov_raise_courtyard_alarm)
        (ai_vehicle_enter "s4_cov_wraith0/driver0" (ai_vehicle_get_from_starting_location "s4_cov_wraith0/wraith0"))
    )
)

(script static void oes_s4_cov_ghosts0_load
    (begin
        (s4_cov_raise_courtyard_alarm)
        (ai_vehicle_enter "s4_cov_ghosts0/driver0" (ai_vehicle_get_from_starting_location "s4_cov_ghosts0/ghost0"))
        (ai_vehicle_enter "s4_cov_ghosts0/driver1" (ai_vehicle_get_from_starting_location "s4_cov_ghosts0/ghost1"))
    )
)

(script static void oes_s4_cov_ghosts1_load
    (begin
        (s4_cov_raise_courtyard_alarm)
        (ai_vehicle_enter "s4_cov_ghosts1/driver0" (ai_vehicle_get_from_starting_location "s4_cov_ghosts1/ghost0"))
        (ai_vehicle_enter "s4_cov_ghosts1/driver1" (ai_vehicle_get_from_starting_location "s4_cov_ghosts1/ghost1"))
    )
)

(script dormant s4_deactivate_roadblocks
    (sleep_until (volume_test_objects "tv_s4_deactivate_roadblock" (players)))
    (game_save)
    (object_destroy_containing "s4_roadblock")
    (print "end fun part")
    (print "end fun part")
    (print "end fun part")
    (game_won)
)

(script dormant s4_hum_warthog0_dialog
    (begin
        (sleep_until (ai_trigger_test "s4_hum_warthog0_attack_creep" "s4_hum_warthog0"))
        (sleep 20)
        (print "marine: chief! we've cornered a command creep, follow us!")
    )
)

(script dormant s4_cov_inf0_main
    (begin
        (sleep_until (volume_test_objects "tv_s4_cov_inf0_init" (players)))
        (game_save)
        (ai_place "s4_hum_warthog0")
        (ai_place "s4_cov_inf0")
    )
)

(script dormant s4_cov_phantom0_main
    (begin
        (sleep_until (<= (ai_living_count "s4_cov_ghosts0") 0))
        (ai_place "s4_cov_ghosts1_reins0")
    )
)

(script dormant s4_cov_roadblock_main
    (begin
        (sleep_until 
            (or
                (volume_test_objects "tv_section4_upper_entrance0" (players))
                (volume_test_objects "tv_section4_upper_entrance1" (players))
                (volume_test_objects "tv_section4_upper_entrance2" (players))
            )
        )
        (ai_place "s4_cov_inf2")
        (ai_place "s4_cov_inf3")
        (ai_place "s4_cov_creep2")
    )
)

(script dormant s4_cov_courtyard_main
    (begin
        (sleep_until 
            (or
                (volume_test_objects "tv_s4_courtyard_init0" (players))
                (volume_test_objects "tv_s4_courtyard_init1" (players))
                (volume_test_objects "tv_s4_courtyard_init2" (players))
            )
        )
        (game_save)
        (ai_place "s4_cov_inf1")
        (ai_place "s4_cov_wraith0")
        (ai_place "s4_cov_wraith1")
        (ai_place "s4_cov_ghosts0")
        (ai_place "s4_cov_ghosts1")
        (ai_place "s4_cov_creep0")
        (wake s4_cov_phantom0_main)
    )
)

(script dormant s4_main
    (begin
        (sleep_until (volume_test_objects "tv_section4" (players)))
        (set g_s4_started true)
        (game_save)
        (print "s4_main")
        (wake s4_cov_inf0_main)
        (wake s4_cov_courtyard_main)
        (wake s4_cov_roadblock_main)
        (wake s4_deactivate_roadblocks)
    )
)

(script dormant navpoints
	(sleep_until (volume_test_objects tv_s3_cov_chokepoint_init0 (players)))
	(activate_nav_point_flag "default" (player0) navpoint_1 0.5)
	
	(sleep_until (volume_test_objects tv_navpoint1 (players)))
	(deactivate_nav_point_flag (player0) navpoint_1)
	(activate_nav_point_flag "default" (player0) navpoint_2 0.5)
	
	(sleep_until (volume_test_objects tv_navpoint2 (players)))
	(deactivate_nav_point_flag (player0) navpoint_2)
	
	(sleep_until (volume_test_objects tv_section4 (players)))
	(activate_nav_point_flag "default" (player0) navpoint_3 0.5)
	
	(sleep_until (volume_test_objects tv_s4_deactivate_roadblock (players)))
	(deactivate_nav_point_flag (player0) navpoint_3)
)

(script static void s4_test
    (begin
        (object_teleport (player0) "s4_test")
    )
)

(script command_script cs_s3_cov_phantom0_intro
    (begin
        (cs_fly_to_and_face s3_cov_phantom0_intro/p0 s3_cov_phantom0_intro/p0_facing)
        (cs_pause 2.0)
        (vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
        (cs_pause 1.0)
        (cs_fly_to_and_face s3_cov_phantom0_intro/p1 s3_cov_phantom0_intro/p2)
        (cs_fly_by s3_cov_phantom0_intro/p2)
        (cs_fly_by s3_cov_phantom0_intro/p3)
        (ai_erase ai_current_squad)
    )
)

(script command_script cs_s3_cov_phantom1_intro
    (begin
        (cs_fly_by s3_cov_phantom1_intro/p0)
        (cs_enable_looking true)
        (cs_enable_targeting true)
        (cs_enable_moving true)
        (cs_enable_looking false)
        (cs_enable_targeting false)
        (cs_enable_moving false)
        (cs_fly_by s3_cov_phantom1_intro/p0_1)
        (cs_fly_to s3_cov_phantom1_intro/p1)
        (cs_pause 2.0)
        (vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_sc")
        (cs_pause 1.0)
        (cs_fly_to_and_face s3_cov_phantom1_intro/p2 s3_cov_phantom1_intro/p2_facing)
        (cs_pause 2.0)
        (vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_p")
        (cs_pause 1.0)
        (cs_fly_by s3_cov_phantom1_intro/p0)
        (cs_fly_by s3_cov_phantom1_intro/p3)
        (ai_erase ai_current_squad)
    )
)

(script command_script cs_s3_cov_creep0_intro
    (begin
        (cs_enable_pathfinding_failsafe true)
        (cs_go_to s3_cov_creep0_intro/p0 0.5)
        (cs_vehicle_speed 0.5)
        (cs_go_to_and_face s3_cov_creep0_intro/p1 s3_cov_creep0_intro/p1_facing)
        (cs_go_to_and_face s3_cov_creep0_intro/p2 s3_cov_creep0_intro/p2_facing)
        (ai_vehicle_exit ai_current_actor)
    )
)

(script static void oes_s3_cov_ghosts1_load
    (begin
        (ai_vehicle_enter "s3_cov_ghosts1/driver0" (ai_vehicle_get_from_starting_location "s3_cov_ghosts1/ghost0"))
        (ai_vehicle_enter "s3_cov_ghosts1/driver1" (ai_vehicle_get_from_starting_location "s3_cov_ghosts1/ghost1"))
    )
)

(script dormant s3_cov_phantom0_main
    (begin
        (ai_place "s3_cov_wraith0")
        (sleep 300)
        (print "cortana: well, looks like they're bringing out the big guns.")
        (sleep_until (<= (ai_living_count "s3_cov_wraith0") 0))
        (game_save)
    )
)

(script dormant s3_cov_phantom1_main
    (begin
        (sleep_until (<= (ai_living_count "s3_cov_ghosts0") 0))
        (game_save)
        (ai_place "s3_cov_phantom1")
        (ai_place_in_vehicle "s3_cov_ghosts2" "s3_cov_phantom1")
        (cs_run_command_script "s3_cov_phantom1/driver" cs_s3_cov_phantom1_intro)
    )
)

(script dormant s3_hum_inf0_main
    (begin
        (sleep_until (volume_test_objects "tv_s3_b_building" (players)))
        (ai_place "s3_hum_inf0_init")
        (sleep_until (ai_trigger_test "s3_hum_inf0_should_guard" "s3_hum_inf0_init"))
        (sleep_until 
            (begin
                (if 
                    (and
                        (< (ai_living_count "s3_hum_inf0") 2)
                        (not (volume_test_objects "tv_s3_hum_inf0_unsafe_to_spawn" (players)))
                    ) 
                        (ai_place "s3_hum_inf0_reins0"))
                (= 1.0 0.0)
            ) 
        900)
    )
)

(script dormant s3_cov_inf0_main
    (begin
        (sleep_until 
            (or
                (volume_test_objects "tv_s3_cov_chokepoint_init0" (players))
                (volume_test_objects "tv_s3_cov_chokepoint_init1" (players))
            )
        )
        (ai_place "s3_cov_inf0_init")
        (sleep_until 
            (or
                (<= (ai_living_count "s3_cov_inf0") 2)
                (volume_test_objects "tv_s3_cov_inf0_retreat0" (players))
            )
        )
        (ai_place "s3_cov_inf0_reins0")
        (ai_set_orders "s3_cov_inf0_reins0" "s3_cov_inf0_retreat0")
        (wake s3_cov_phantom1_main)
        (sleep_until 
            (or
                (<= (ai_living_count "s3_cov_inf0") 2)
                (volume_test_objects "tv_s3_cov_inf0_retreat1" (players))
            )
        )
        (ai_place "s3_cov_inf0_reins1")
        (ai_set_orders "s3_cov_inf0_reins0" "s3_cov_inf0_retreat1")
        (ai_set_orders "s3_cov_inf0_reins1" "s3_cov_inf0_retreat1")
    )
)

(script dormant s3_cov_inf2_main
    (begin
        (sleep_until (volume_test_objects "tv_s3_cov_inf2_init" (players)))
        (ai_place "s3_cov_inf2")
        (sleep_until (volume_test_objects "tv_s3_cov_inf2_reins0" (players)))
        (ai_place "s3_cov_inf2_reins0")
        (ai_migrate "s3_cov_inf2_reins0" "s3_cov_inf2")
    )
)

(script dormant s3_cov_inf4_main
    (begin
        (ai_place "s3_cov_inf4")
        (sleep_until (ai_trigger_test "s3_cov_inf4_should_retreat" "s3_cov_inf4"))
        (ai_place "s3_cov_inf4_reins0")
    )
)

(script dormant s3_hum_warthog0_main
    (begin
        (if (<= (ai_living_count "s3_hum_warthog0") 0) 
            (ai_place "s3_hum_warthog0"))
        (sleep_until (<= (ai_living_count "s3_cov_wraith0") 0) 30 900)
        (ai_set_orders "s3_hum_warthog0" "s3_hum_warthog0_assist_inf0")
    )
)

(script dormant s3_cov_chokepoint_main
    (begin
        (sleep_until 
            (or
                (volume_test_objects "tv_s3_cov_chokepoint_init0" (players))
                (volume_test_objects "tv_s3_cov_chokepoint_init1" (players))
            )
        )
        (ai_place "s3_cov_ghosts0")
    )
)

(script dormant s3_dialog0
    (begin
        (print "cortana: we have friendlies at 11:00. sounds like they could use some help.")
    )
)

(script dormant s3_dialog1
    (begin
        (sleep_until (volume_test_objects "tv_s3_dialog1_trigger" (players)))
        (print "cortana: the covenant control that building ahead of us.")
        (sleep 40)
        (print "cortana: we should probably do something about that.")
    )
)

(script dormant s3_main
    (begin
        (sleep_until 
            (or
                (volume_test_objects "tv_section3" (players))
                false
            )
        )
        (set g_s3_started true)
        (game_save)
        (print "s3_main")
        (ai_place "s3_cov_creep1")
        (ai_place "s3_cov_inf3")
        (ai_place "s3_cov_av_turrets0")
        (wake s3_cov_chokepoint_main)
        (wake s3_hum_warthog0_main)
        (wake s3_cov_phantom0_main)
        (wake s3_hum_inf0_main)
        (wake s3_cov_inf0_main)
        (wake s3_cov_inf2_main)
        (wake s3_cov_inf4_main)
        (wake s3_dialog0)
        (wake s3_dialog1)
        (sleep_until g_s4_started)
        (sleep_forever s3_cov_chokepoint_main)
        (sleep_forever s3_hum_warthog0_main)
        (sleep_forever s3_cov_phantom0_main)
        (sleep_forever s3_cov_phantom1_main)
        (sleep_forever s3_hum_inf0_main)
        (sleep_forever s3_cov_inf0_main)
        (sleep_forever s3_cov_inf2_main)
        (sleep_forever s3_cov_inf4_main)
    )
)

(script startup mission_main
    (begin
        (cinematic_fade_from_white)
        (game_can_use_flashlights true)
        ;(ai_allegiance grunt jackal)
        (print "begin fun part")
        (print "begin fun part")
        (print "begin fun part")
		(wake navpoints)
        (wake s3_main)
        (wake s4_main)
    )
)

