(global boolean global_dialog_on false)
(global boolean global_music_on false)
(global long global_delay_music (* 30.0 300.0))
(global long global_delay_music_alt (* 30.0 300.0))
(global boolean debug true)
(global boolean coop false)
(global boolean begin_defense_phase false)
(global boolean begin_retreat_phase false)
(global short testing_save 5)
(global short ticks_per_minute 1800)
(global boolean save_now false)
(global boolean sniper_atv_01_continue false)
(global boolean sniper_atv_02_continue false)
(global unit swap_unit "null_unit")
(global unit crew01_driver "null_unit")
(global unit crew01_gunner "null_unit")
(global unit crew01_passenger "null_unit")
(global unit crew02_driver "null_unit")
(global unit crew02_gunner "null_unit")
(global unit crew02_passenger "null_unit")
(global unit crew03_driver "null_unit")
(global unit crew03_gunner "null_unit")
(global unit crew03_passenger "null_unit")
(global unit crew04_driver "null_unit")
(global unit crew04_gunner "null_unit")
(global unit crew04_passenger "null_unit")
(global unit engineer01_driver "null_unit")
(global unit engineer02_driver "null_unit")
(global unit engineer03_driver "null_unit")
(global unit engineer04_driver "null_unit")
(global unit mongoose01_driver "null_unit")
(global unit mongoose02_driver "null_unit")
(global boolean crew01_retreated false)
(global boolean crew02_retreated false)
(global boolean crew03_retreated false)
(global boolean crew04_retreated false)
(global boolean perimeter_warthog_01_continue false)
(global boolean perimeter_warthog_02_continue false)
(global boolean cov_wave_01_random_fork false)
(global boolean cov_wave_02_random_fork false)
(global boolean cov_wave_01b_should_begin false)
(global boolean cov_wave_02b_should_begin false)
(global boolean cov_wave_01_finished false)
(global boolean cov_wave_02_finished false)
(global boolean cov_hwave_01_finished false)
(global boolean cinematic_ran false)

(script static void cinematic_insertion
    (print "cinematic_insertion")
    (fade_in 0.0 0.0 0.0 0)
)

(script static void cinematic_extraction
    (print "cinematic_extraction")
)

(script static void cinematic_orbital_attack
    (player_effect_set_max_vibration 0.5 0.0)
    (player_effect_set_max_rotation 0.0 0.3 0.3)
    (fade_out 1.0 1.0 1.0 10)
    (player_effect_start 1.0 0.3)
    (sleep 45)
    (print "*hisss crackle 'auuugh, Chief help me!' hissss*")
    (fade_in 1.0 1.0 1.0 105)
    (player_effect_stop 2.5)
)

(script continuous save_loop
    (sleep_until save_now testing_save)
    (game_save_no_timeout)
    (set save_now false)
)

(script static void certain_save
    (set save_now true)
)

(script static void dialog_crew_01_request_reins
    (print "crew 01> looks like trouble here... we need some help.")
)

(script static void dialog_crew_02_request_reins
    (print "crew 02> looks like trouble here... we need some help.")
)

(script static void dialog_crew_03_request_reins
    (print "crew 03> looks like trouble here... we need some help.")
)

(script static void dialog_crew_04_request_reins
    (print "crew 04> looks like trouble here... we need some help.")
)

(script static void dialog_crew_01_retreating
    (print "crew 01> there's too many! falling back to ship!")
)

(script static void dialog_crew_02_retreating
    (print "crew 02> there's too many! falling back to ship!")
)

(script static void dialog_crew_03_retreating
    (print "crew 03> there's too many! falling back to ship!")
)

(script static void dialog_crew_04_retreating
    (print "crew 04> there's too many! falling back to ship!")
)

(script static void record
    (object_create_anew "cd_inbound_02")
)

(script command_script cd_inbound_01_start_path
	(cs_vehicle_boost true)
	(cs_fly_by cd_inbound_01_enter/p0)
	(cs_fly_by cd_inbound_01_enter/p1)
	(cs_fly_by cd_inbound_01_enter/p2)
	(cs_fly_by cd_inbound_01_enter/p3)
	(cs_vehicle_boost false)
	(cs_fly_by cd_inbound_01_enter/p4)
	(cs_fly_by cd_inbound_01_enter/p5)
	(cs_fly_by cd_inbound_01_enter/p6)
)

(script command_script cd_inbound_01_end_path
	(cs_fly_to_and_face cd_inbound_01_exit/p0 cd_inbound_01_exit/p1)
	(cs_fly_to_and_face cd_inbound_01_exit/p1 cd_inbound_01_exit/p2)
	(cs_fly_to_and_face cd_inbound_01_exit/p2 cd_inbound_01_exit/p3)
	(cs_fly_to_and_face cd_inbound_01_exit/p3 cd_inbound_01_exit/p4)
	(cs_fly_to_and_face cd_inbound_01_exit/p4 cd_inbound_01_exit/p5)
	(cs_fly_to_and_face cd_inbound_01_exit/p5 cd_inbound_01_exit/p6)
	(cs_fly_to_and_face cd_inbound_01_exit/p6 cd_inbound_01_exit/p7)
	(cs_fly_to_and_face cd_inbound_01_exit/p7 cd_inbound_01_exit/p8)
	(cs_fly_to_and_face cd_inbound_01_exit/p8 cd_inbound_01_exit/p9)
	(cs_fly_to_and_face cd_inbound_01_exit/p9 cd_inbound_01_exit/p10)
	(cs_fly_by cd_inbound_01_exit/p10)
	(ai_erase ai_current_squad)
)

(script static void load_cd_01
    (ai_place "cov_wave_01_drivers")
    (object_create "cov_wave_01_ghost_01")
    (object_create "cov_wave_01_ghost_02")
    (vehicle_load_magic "cov_wave_01_ghost_01" "ghost_d" (unit (list_get (ai_actors "cov_wave_01_drivers") 0)))
    (vehicle_load_magic "cov_wave_01_ghost_02" "ghost_d" (unit (list_get (ai_actors "cov_wave_01_drivers") 1)))
	(sleep 5)
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_sc" "cov_wave_01_ghost_01")
	(vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_sc" "cov_wave_01_ghost_02")
)

(script static void unload_cd_01
    (ai_place "cov_wave_01_scouts")
    (ai_place "cov_wave_01_grunts")
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p" (ai_actors "cov_wave_01_scouts"))
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p" (ai_actors "cov_wave_01_grunts"))
    (sleep 100)
    (vehicle_unload (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_sc")
    (ai_set_orders "cov_wave_01_drivers" "10_ghost_checkpoint_01")
    (sleep 30)
    (vehicle_unload (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p")
    (ai_set_orders "cov_wave_01_scouts" "10_advance_rally_point_01")
    (ai_set_orders "cov_wave_01_grunts" "10_init")
    (sleep 70)
)

(script static void cd_inbound_01
	(ai_place cd_inbound_01)
    (load_cd_01)
	(cs_run_command_script cd_inbound_01 cd_inbound_01_start_path)
	(sleep 1200)
    (unload_cd_01)
	(sleep 30)
    (cs_run_command_script cd_inbound_01 cd_inbound_01_end_path)
)

(script static void load_cd_01b
    (print "not loading anything...")
)

(script static void unload_cd_01b
    (ai_place "cov_wave_01b_scouts")
    (ai_place "cov_wave_01b_grunts")
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01b/starting_locations_0) "phantom_p" (ai_actors "cov_wave_01b_scouts"))
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01b/starting_locations_0) "phantom_p" (ai_actors "cov_wave_01b_grunts"))
    (sleep 90)
    (vehicle_unload (ai_vehicle_get cd_inbound_01b/starting_locations_0) "phantom_p")
    (ai_set_orders "cov_wave_01b_scouts" "10_advance_rally_point_01")
    (ai_set_orders "cov_wave_01b_grunts" "10_init")
    (sleep 110)
)

(script static void cd_inbound_01b
	(ai_place cd_inbound_01b)
    (load_cd_01b)
	(cs_run_command_script cd_inbound_01b cd_inbound_01_start_path)
	(sleep 1200)
    (unload_cd_01b)
	(sleep 30)
    (cs_run_command_script cd_inbound_01b cd_inbound_01_end_path)
)

(script command_script cd_inbound_02_start_path
	(cs_vehicle_boost true)
	(cs_fly_by cd_inbound_02_enter/p0)
	(cs_fly_by cd_inbound_02_enter/p1)
	(cs_fly_by cd_inbound_02_enter/p2)
	(cs_vehicle_boost false)
	(cs_fly_by cd_inbound_02_enter/p3)
	(cs_fly_by cd_inbound_02_enter/p4)
	(cs_fly_by cd_inbound_02_enter/p5)
	(cs_fly_by cd_inbound_02_enter/p6)
)

(script command_script cd_inbound_02_end_path
	(cs_fly_to_and_face cd_inbound_02_exit/p0 cd_inbound_02_exit/p1)
	(cs_fly_to_and_face cd_inbound_02_exit/p1 cd_inbound_02_exit/p2)
	(cs_fly_to_and_face cd_inbound_02_exit/p2 cd_inbound_02_exit/p3)
	(cs_fly_to_and_face cd_inbound_02_exit/p3 cd_inbound_02_exit/p4)
	(cs_fly_to_and_face cd_inbound_02_exit/p4 cd_inbound_02_exit/p5)
	(cs_fly_to_and_face cd_inbound_02_exit/p5 cd_inbound_02_exit/p6)
	(cs_fly_to_and_face cd_inbound_02_exit/p6 cd_inbound_02_exit/p7)
	(cs_fly_to_and_face cd_inbound_02_exit/p7 cd_inbound_02_exit/p8)
	(cs_fly_to_and_face cd_inbound_02_exit/p8 cd_inbound_02_exit/p9)
	(cs_fly_to_and_face cd_inbound_02_exit/p9 cd_inbound_02_exit/p10)
	(cs_fly_to_and_face cd_inbound_02_exit/p10 cd_inbound_02_exit/p11)
	(cs_fly_to_and_face cd_inbound_02_exit/p11 cd_inbound_02_exit/p12)
	(cs_fly_by cd_inbound_02_exit/p12)
	(ai_erase ai_current_squad)
)

(script static void load_cd_02
    (ai_place "cov_wave_02_drivers")
    (object_create "cov_wave_02_ghost_01")
    (object_create "cov_wave_02_ghost_02")
    (vehicle_load_magic "cov_wave_02_ghost_01" "ghost_d" (unit (list_get (ai_actors "cov_wave_02_drivers") 0)))
    (vehicle_load_magic "cov_wave_02_ghost_02" "ghost_d" (unit (list_get (ai_actors "cov_wave_02_drivers") 1)))
	(sleep 5)
    (vehicle_load_magic (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_sc01" "cov_wave_02_ghost_01")
    (vehicle_load_magic (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_sc02" "cov_wave_02_ghost_02")
)

(script static void unload_cd_02
    (ai_place "cov_wave_02_scouts")
    (ai_place "cov_wave_02_grunts")
    (vehicle_load_magic (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_p" (ai_actors "cov_wave_02_scouts"))
    (vehicle_load_magic (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_p" (ai_actors "cov_wave_02_grunts"))
    (sleep 100)
    (vehicle_unload (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_sc")
    (ai_set_orders "cov_wave_02_drivers" "11_ghosts_init")
    (sleep 50)
    (vehicle_unload (ai_vehicle_get cd_inbound_02/starting_locations_0) "phantom_p")
    (ai_set_orders "cov_wave_02_scouts" "11_rally_01")
    (ai_set_orders "cov_wave_02_grunts" "11_infantry_init")
    (sleep 70)
)

(script static void cd_inbound_02
	(ai_place cd_inbound_02)
    (load_cd_02)
	(cs_run_command_script cd_inbound_02 cd_inbound_02_start_path)
	(sleep 1200)
    (unload_cd_02)
	(sleep 30)
	(cs_run_command_script cd_inbound_02 cd_inbound_02_end_path)
)

(script static void load_cd_heavy_01
    (ai_place "cov_hwave_01_driver")
    (ai_place "cov_hwave_01_infantry_01")
    (ai_place "cov_hwave_01_infantry_02")
    (object_create "cov_hwave_01_wraith")
    (vehicle_load_magic "cov_hwave_01_wraith" "wraith_d" (unit (list_get (ai_actors "cov_hwave_01_driver") 0)))
	(sleep 5)
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_lc" "cov_hwave_01_wraith")
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p" (ai_actors "cov_hwave_01_infantry_01"))
    (vehicle_load_magic (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p" (ai_actors "cov_hwave_01_infantry_02"))
)

(script static void unload_cd_heavy_01
    (sleep 100)
    (vehicle_unload (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_lc")
    (ai_set_orders "cov_hwave_01_driver" "10_wraith_init")
    (vehicle_unload (ai_vehicle_get cd_inbound_01/starting_locations_0) "phantom_p")
    (ai_set_orders "cov_hwave_01_infantry_01" "10_wraith_escort_left")
    (ai_set_orders "cov_hwave_01_infantry_02" "10_wraith_escort_right")
    (sleep 100)
)

(script static void cd_heavy_inbound_01
	(ai_place cd_inbound_01)
    (load_cd_heavy_01)
	(cs_run_command_script cd_inbound_01 cd_inbound_01_start_path)
	(sleep 1200)
    (unload_cd_heavy_01)
	(sleep 30)
	(cs_run_command_script cd_inbound_01 cd_inbound_01_end_path)
)

(script command_script sniper_atv_01_start_path
	(cs_go_to sniper_atv_01_start/p0)
	(sleep 40)
    (if (not sniper_atv_01_continue)
		(unit_exit_vehicle mongoose01_driver))
)

(script command_script sniper_atv_01_cont_path
	(cs_go_to sniper_atv_01_cont/p0)
	(sleep 40)
	(cs_go_to sniper_atv_01_cont/p1)
	(sleep 40)
	(unit_exit_vehicle mongoose01_driver)
)

(script dormant sniper_atv_01
    (object_create_anew "sniper_atv_01")
	(ai_vehicle_reserve sniper_atv_01 true)
	(set mongoose01_driver (unit (list_get (ai_actors "marine_north_sniper") 0)))
    (vehicle_load_magic "sniper_atv_01" "mongoose_d" mongoose01_driver)
	(cs_run_command_script (object_get_ai mongoose01_driver) sniper_atv_01_start_path)
    (sleep_until sniper_atv_01_continue 5)
    (if (not (vehicle_test_seat "sniper_atv_01" "mongoose_d" mongoose01_driver))
        (unit_enter_vehicle mongoose01_driver "sniper_atv_01" "mongoose_d"))
    (sleep_until (vehicle_test_seat "sniper_atv_01" "mongoose_d" mongoose01_driver) 10)
	(cs_run_command_script (object_get_ai mongoose01_driver) sniper_atv_01_cont_path)
    (ai_set_orders "marine_north_sniper" "7_north_sniper")
)

(script command_script sniper_atv_02_start_path
	(cs_go_to sniper_atv_02_start/p0)
	(sleep 40)
    (if (not sniper_atv_02_continue)
		(unit_exit_vehicle mongoose02_driver))
)

(script command_script sniper_atv_02_cont_path
	(cs_go_to sniper_atv_02_cont/p0)
	(sleep 40)
	(cs_go_to sniper_atv_02_cont/p1)
	(sleep 40)
	(unit_exit_vehicle mongoose02_driver)
)

(script dormant sniper_atv_02
    (object_create_anew "sniper_atv_02")
	(ai_vehicle_reserve sniper_atv_02 true)
	(set mongoose02_driver (unit (list_get (ai_actors "marine_south_sniper") 0)))
    (vehicle_load_magic "sniper_atv_02" "mongoose_d" mongoose02_driver)
	(cs_run_command_script (object_get_ai mongoose02_driver) sniper_atv_02_start_path)
    (sleep_until sniper_atv_02_continue 5)
    (if (not (vehicle_test_seat "sniper_atv_02" "mongoose_d" mongoose02_driver))
        (unit_enter_vehicle mongoose02_driver "sniper_atv_02" "mongoose_d"))
    (sleep_until (vehicle_test_seat "sniper_atv_02" "mongoose_d" mongoose02_driver) 10)
	(cs_run_command_script (object_get_ai mongoose02_driver) sniper_atv_02_cont_path)
    (ai_set_orders "marine_south_sniper" "7_south_sniper")
)

(script dormant initial_deploy_snipers
    (if debug
        (print "initial_deploy_snipers"))
    (ai_place "marine_north_sniper")
    (ai_set_orders "marine_north_sniper" "7_turret_interlude")
    (ai_place "marine_south_sniper")
    (ai_set_orders "marine_south_sniper" "7_turret_interlude")
    (wake sniper_atv_01)
    (wake sniper_atv_02)
    (sleep 1800)
    (set sniper_atv_01_continue true)
    (set sniper_atv_02_continue true)
)

(script command_script perimeter_warthog_01_start_path
	(cs_go_to perimeter_warthog_01_start/p0)
	(sleep 50)
	(unit_exit_vehicle crew01_passenger)
)

(script static void perimeter_warthog_01_start
    (ai_place "marine_perimeter_crew_01")
    (set crew01_driver (unit (list_get (ai_actors "marine_perimeter_crew_01") 0)))
    (set crew01_gunner (unit (list_get (ai_actors "marine_perimeter_crew_01") 1)))
    (set crew01_passenger (unit (list_get (ai_actors "marine_perimeter_crew_01") 2)))
    (ai_set_orders "marine_perimeter_crew_01" "4_warthog_01_init")
    (object_create "perimeter_warthog_01")
	(ai_vehicle_reserve perimeter_warthog_01 true)
    (unit_set_enterable_by_player "perimeter_warthog_01" false)
    (vehicle_load_magic "perimeter_warthog_01" "warthog_d" crew01_driver)
    (vehicle_load_magic "perimeter_warthog_01" "warthog_g" crew01_gunner)
	(vehicle_load_magic "perimeter_warthog_01" "warthog_p" crew01_passenger)
	(cs_run_command_script (object_get_ai crew01_driver) perimeter_warthog_01_start_path)
)

(script static void handle_crew01_casualties
    (if (<= (unit_get_health crew01_driver) 0.0)
        (if (<= (unit_get_health crew01_passenger) 0.0)
            (if (<= (unit_get_health crew01_gunner) 0.0)
                (if debug
                    (print "crew01 all dead")) (begin
                    (unit_exit_vehicle crew01_gunner)
                    (set swap_unit crew01_driver)
                    (set crew01_driver crew01_gunner)
                    (set crew01_gunner swap_unit)
                )
            ) (begin
                (set swap_unit crew01_driver)
                (set crew01_driver crew01_passenger)
                (set crew01_passenger swap_unit)
            )
        ) (if (<= (unit_get_health crew01_gunner) 0.0)
            (if (> (unit_get_health crew01_passenger) 0.0)
                (begin
                    (set swap_unit crew01_gunner)
                    (set crew01_gunner crew01_passenger)
                    (set crew01_passenger swap_unit)
                )
            )
        )
    )
    (if (<= (unit_get_health crew01_driver) 0.0)
        (set crew01_driver "null_unit"))
    (if (<= (unit_get_health crew01_gunner) 0.0)
        (set crew01_gunner "null_unit"))
    (if (<= (unit_get_health crew01_passenger) 0.0)
        (set crew01_passenger "null_unit"))
)

(script static void load_crew01
    (if (> (unit_get_health crew01_driver) 0.0)
        (unit_enter_vehicle crew01_driver "perimeter_warthog_01" "warthog_d"))
    (if (not (vehicle_test_seat "perimeter_warthog_01" "warthog_g" crew01_gunner))
        (if (> (unit_get_health crew01_gunner) 0.0)
            (unit_enter_vehicle crew01_gunner "perimeter_warthog_01" "warthog_g"))
    )
    (if (> (unit_get_health crew01_passenger) 0.0)
        (unit_enter_vehicle crew01_passenger "perimeter_warthog_01" "warthog_p"))
    (sleep_until
        (and
            (or
                (vehicle_test_seat "perimeter_warthog_01" "warthog_d" crew01_driver)
                (<= (unit_get_health crew01_driver) 0.0)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_01" "warthog_g" crew01_gunner)
                (<= (unit_get_health crew01_gunner) 0.0)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_01" "warthog_p" crew01_passenger)
                (<= (unit_get_health crew01_passenger) 0.0)
            )
        )
    )
)

(script command_script perimeter_warthog_01_cont_path
	(cs_go_to perimeter_warthog_01_cont/p0)
	(sleep 300)
	(unit_exit_vehicle crew01_passenger)
)

(script dormant perimeter_warthog_01
    (perimeter_warthog_01_start)
    (sleep_until perimeter_warthog_01_continue)
    (handle_crew01_casualties)
    (load_crew01)
    (if (> (ai_living_count "marine_perimeter_crew_01") 0)
        (begin
			(cs_run_command_script (object_get_ai crew01_driver) perimeter_warthog_01_cont_path)
            (ai_set_orders "marine_perimeter_crew_01" "5_init")
        )
    )
)

(script command_script warthog_01_retreat_path
	(cs_go_to perimeter_warthog_01_retreat/p0)
	(sleep 200)
)

(script dormant warthog_01_retreat_thread
    (set crew01_retreated true)
    (handle_crew01_casualties)
    (load_crew01)
    (if (vehicle_test_seat "perimeter_warthog_01" "warthog_d" crew01_driver)
        (begin
			(cs_run_command_script (object_get_ai crew01_driver) warthog_01_retreat_path)
        )
    )
)

(script static void perimeter_warthog_01_retreat
    (wake warthog_01_retreat_thread)
    (dialog_crew_01_retreating)
)

(script command_script perimeter_warthog_02_start_path
	(cs_go_to perimeter_warthog_02_start/p0)
	(sleep 75)
	(unit_exit_vehicle crew02_passenger)
)

(script static void perimeter_warthog_02_start
    (ai_place "marine_perimeter_crew_02")
    (set crew02_driver (unit (list_get (ai_actors "marine_perimeter_crew_02") 0)))
    (set crew02_gunner (unit (list_get (ai_actors "marine_perimeter_crew_02") 1)))
    (set crew02_passenger (unit (list_get (ai_actors "marine_perimeter_crew_02") 2)))
    (ai_set_orders "marine_perimeter_crew_02" "4_warthog_02_init")
    (object_create "perimeter_warthog_02")
	(ai_vehicle_reserve perimeter_warthog_02 true)
    (unit_set_enterable_by_player "perimeter_warthog_02" false)
    (vehicle_load_magic "perimeter_warthog_02" "warthog_d" crew02_driver)
    (vehicle_load_magic "perimeter_warthog_02" "warthog_g" crew02_gunner)
	(vehicle_load_magic "perimeter_warthog_02" "warthog_p" crew02_passenger)
	(cs_run_command_script (object_get_ai crew02_driver) perimeter_warthog_02_start_path)
)

(script static void handle_crew02_casualties
    (if (<= (unit_get_health crew02_driver) 0.0)
        (if (<= (unit_get_health crew02_passenger) 0.0)
            (if (<= (unit_get_health crew02_gunner) 0.0)
                (if debug
                    (print "crew02 all dead")) (begin
                    (unit_exit_vehicle crew02_gunner)
                    (set swap_unit crew02_driver)
                    (set crew02_driver crew02_gunner)
                    (set crew02_gunner swap_unit)
                )
            ) (begin
                (set swap_unit crew02_driver)
                (set crew02_driver crew02_passenger)
                (set crew02_passenger swap_unit)
            )
        ) (if (<= (unit_get_health crew02_gunner) 0.0)
            (if (> (unit_get_health crew02_passenger) 0.0)
                (begin
                    (set swap_unit crew02_gunner)
                    (set crew02_gunner crew02_passenger)
                    (set crew02_passenger swap_unit)
                )
            )
        )
    )
    (if (<= (unit_get_health crew02_driver) 0.0)
        (set crew02_driver "null_unit"))
    (if (<= (unit_get_health crew02_gunner) 0.0)
        (set crew02_gunner "null_unit"))
    (if (<= (unit_get_health crew02_passenger) 0.0)
        (set crew02_passenger "null_unit"))
)

(script static void load_crew02
    (if (> (unit_get_health crew02_driver) 0.0)
        (unit_enter_vehicle crew02_driver "perimeter_warthog_02" "warthog_d"))
    (if (not (vehicle_test_seat "perimeter_warthog_02" "warthog_g" crew02_gunner))
        (if (> (unit_get_health crew02_gunner) 0.0)
            (unit_enter_vehicle crew02_gunner "perimeter_warthog_02" "warthog_g"))
    )
    (if (> (unit_get_health crew02_passenger) 0.0)
        (unit_enter_vehicle crew02_passenger "perimeter_warthog_02" "warthog_p"))
    (sleep_until
        (and
            (or
                (vehicle_test_seat "perimeter_warthog_02" "warthog_d" crew02_driver)
                (<= (unit_get_health crew02_driver) 0.0)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_02" "warthog_g" crew02_gunner)
                (<= (unit_get_health crew02_gunner) 0.0)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_02" "warthog_p" crew02_passenger)
                (<= (unit_get_health crew02_passenger) 0.0)
            )
        )
    )
)

(script command_script perimeter_warthog_02_cont_path
	(cs_go_to perimeter_warthog_02_cont/p0)
	(sleep 300)
	(unit_exit_vehicle crew02_passenger)
)

(script dormant perimeter_warthog_02
    (perimeter_warthog_02_start)
    (sleep_until perimeter_warthog_02_continue)
    (handle_crew02_casualties)
    (load_crew02)
    (if (> (ai_living_count "marine_perimeter_crew_02") 0)
        (begin
			(cs_run_command_script (object_get_ai crew02_driver) perimeter_warthog_02_cont_path)
            (ai_set_orders "marine_perimeter_crew_02" "6_init")
        )
    )
)

(script command_script warthog_02_retreat_path
	(cs_go_to perimeter_warthog_02_retreat/p0)
	(sleep 200)
)

(script dormant warthog_02_retreat_thread
    (set crew02_retreated true)
    (handle_crew02_casualties)
    (load_crew02)
    (if (vehicle_test_seat "perimeter_warthog_02" "warthog_d" crew02_driver)
        (begin
			(cs_run_command_script (object_get_ai crew02_driver) warthog_02_retreat_path)
        )
    )
)

(script static void perimeter_warthog_02_retreat
    (wake warthog_02_retreat_thread)
    (dialog_crew_02_retreating)
)

(script command_script perimeter_warthog_03_start_path
	(cs_go_to perimeter_warthog_03/p0)
	(sleep 200)
    (unit_exit_vehicle crew03_passenger)
)

(script dormant perimeter_warthog_03
    (if debug
        (print "perimeter_warthog_03"))
    (ai_place "marine_perimeter_crew_03")
    (set crew03_driver (unit (list_get (ai_actors "marine_perimeter_crew_03") 0)))
    (set crew03_gunner (unit (list_get (ai_actors "marine_perimeter_crew_03") 1)))
    (set crew03_passenger (unit (list_get (ai_actors "marine_perimeter_crew_03") 2)))
    (object_create "perimeter_warthog_03")
	(ai_vehicle_reserve perimeter_warthog_03 true)
    (unit_set_enterable_by_player "perimeter_warthog_03" false)
    (vehicle_load_magic "perimeter_warthog_03" "warthog_d" crew03_driver)
    (vehicle_load_magic "perimeter_warthog_03" "warthog_g" crew03_gunner)
    (vehicle_load_magic "perimeter_warthog_03" "warthog_p" crew03_passenger)
    (cs_run_command_script (object_get_ai crew03_driver) perimeter_warthog_03_start_path)
    (ai_set_orders "marine_perimeter_crew_03" "8_init")
)

(script static void handle_crew03_casualties
    (if debug
        (print "handle_crew03_casualties"))
    (if (<= (unit_get_health crew03_driver) 0.0)
        (if (<= (unit_get_health crew03_passenger) 0.0)
            (if (<= (unit_get_health crew03_gunner) 0.0)
                (if debug
                    (print "crew03 all dead")) (begin
                    (unit_exit_vehicle crew03_gunner)
                    (set swap_unit crew03_driver)
                    (set crew03_driver crew03_gunner)
                    (set crew03_gunner swap_unit)
                )
            ) (begin
                (set swap_unit crew03_driver)
                (set crew03_driver crew03_passenger)
                (set crew03_passenger swap_unit)
            )
        ) (if (<= (unit_get_health crew03_gunner) 0.0)
            (if (> (unit_get_health crew03_passenger) 0.0)
                (begin
                    (set swap_unit crew03_gunner)
                    (set crew03_gunner crew03_passenger)
                    (set crew03_passenger swap_unit)
                )
            )
        )
    )
    (if (<= (unit_get_health crew03_driver) 0.0)
        (set crew03_driver "null_unit"))
    (if (<= (unit_get_health crew03_gunner) 0.0)
        (set crew03_gunner "null_unit"))
    (if (<= (unit_get_health crew03_passenger) 0.0)
        (set crew03_passenger "null_unit"))
)

(script static void load_crew03
    (if (> (unit_get_health crew03_driver) 0.0)
        (unit_enter_vehicle crew03_driver "perimeter_warthog_03" "warthog_d"))
    (if (not (vehicle_test_seat "perimeter_warthog_03" "warthog_g" crew03_gunner))
        (if (> (unit_get_health crew03_gunner) 0.0)
            (unit_enter_vehicle crew03_gunner "perimeter_warthog_03" "warthog_g"))
    )
    (if (> (unit_get_health crew03_passenger) 0.0)
        (unit_enter_vehicle crew03_passenger "perimeter_warthog_03" "warthog_p"))
    (sleep_until
        (and
            (or
                (vehicle_test_seat "perimeter_warthog_03" "warthog_d" crew03_driver)
                (<= (unit_get_health crew03_driver) 0.01)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_03" "warthog_g" crew03_gunner)
                (<= (unit_get_health crew03_gunner) 0.01)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_03" "warthog_p" crew03_passenger)
                (<= (unit_get_health crew03_passenger) 0.01)
            )
        )
    )
)

(script command_script warthog_03_retreat_path
	(cs_go_to perimeter_warthog_03_retreat/p0)
	(sleep 200)
)

(script dormant warthog_03_retreat_thread
    (set crew03_retreated true)
    (handle_crew03_casualties)
    (load_crew03)
    (if (vehicle_test_seat "perimeter_warthog_03" "warthog_d" crew03_driver)
        (begin
			(cs_run_command_script (object_get_ai crew03_driver) warthog_03_retreat_path)
        )
    )
)

(script static void perimeter_warthog_03_retreat
    (wake warthog_03_retreat_thread)
    (dialog_crew_03_retreating)
)

(script command_script perimeter_warthog_04_start_path
	(cs_go_to perimeter_warthog_04/p0)
	(sleep 200)
    (unit_exit_vehicle crew04_passenger)
)

(script dormant perimeter_warthog_04
    (ai_place "marine_perimeter_crew_04")
    (set crew04_driver (unit (list_get (ai_actors "marine_perimeter_crew_04") 0)))
    (set crew04_gunner (unit (list_get (ai_actors "marine_perimeter_crew_04") 1)))
    (set crew04_passenger (unit (list_get (ai_actors "marine_perimeter_crew_04") 2)))
    (object_create "perimeter_warthog_04")
	(ai_vehicle_reserve perimeter_warthog_03 true)
    (unit_set_enterable_by_player "perimeter_warthog_04" false)
    (vehicle_load_magic "perimeter_warthog_04" "warthog_d" crew04_driver)
    (vehicle_load_magic "perimeter_warthog_04" "warthog_g" crew04_gunner)
    (vehicle_load_magic "perimeter_warthog_04" "warthog_p" crew04_passenger)
	(cs_run_command_script (object_get_ai crew04_driver) perimeter_warthog_04_start_path)
    (ai_set_orders "marine_perimeter_crew_04" "9_init")
)

(script static void handle_crew04_casualties
    (if debug
        (print "handle_crew04_casualties"))
    (if (<= (unit_get_health crew04_driver) 0.0)
        (if (<= (unit_get_health crew04_passenger) 0.0)
            (if (<= (unit_get_health crew04_gunner) 0.0)
                (if debug
                    (print "crew04 all dead")) (begin
                    (unit_exit_vehicle crew04_gunner)
                    (set swap_unit crew04_driver)
                    (set crew04_driver crew04_gunner)
                    (set crew04_gunner swap_unit)
                )
            ) (begin
                (set swap_unit crew04_driver)
                (set crew04_driver crew04_passenger)
                (set crew04_passenger swap_unit)
            )
        ) (if (<= (unit_get_health crew04_gunner) 0.0)
            (if (> (unit_get_health crew04_passenger) 0.0)
                (begin
                    (set swap_unit crew04_gunner)
                    (set crew04_gunner crew03_passenger)
                    (set crew04_passenger swap_unit)
                )
            )
        )
    )
    (if (<= (unit_get_health crew04_driver) 0.0)
        (set crew04_driver "null_unit"))
    (if (<= (unit_get_health crew04_gunner) 0.0)
        (set crew04_gunner "null_unit"))
    (if (<= (unit_get_health crew04_passenger) 0.0)
        (set crew04_passenger "null_unit"))
)

(script static void load_crew04
    (if (> (unit_get_health crew04_driver) 0.0)
        (unit_enter_vehicle crew04_driver "perimeter_warthog_04" "warthog_d"))
    (if (not (vehicle_test_seat "perimeter_warthog_04" "warthog_g" crew04_gunner))
        (if (> (unit_get_health crew04_gunner) 0.0)
            (unit_enter_vehicle crew04_gunner "perimeter_warthog_04" "warthog_g"))
    )
    (if (> (unit_get_health crew04_passenger) 0.0)
        (unit_enter_vehicle crew04_passenger "perimeter_warthog_04" "warthog_p"))
    (sleep_until
        (and
            (or
                (vehicle_test_seat "perimeter_warthog_04" "warthog_d" crew04_driver)
                (<= (unit_get_health crew04_driver) 0.01)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_04" "warthog_g" crew04_gunner)
                (<= (unit_get_health crew04_gunner) 0.01)
            )
            (or
                (vehicle_test_seat "perimeter_warthog_04" "warthog_p" crew04_passenger)
                (<= (unit_get_health crew04_passenger) 0.01)
            )
        )
    )
)

(script command_script warthog_04_retreat_path
	(cs_go_to perimeter_warthog_04_retreat/p0)
	(sleep 200)
)

(script dormant warthog_04_retreat_thread
    (set crew04_retreated true)
    (handle_crew04_casualties)
    (load_crew04)
    (if (vehicle_test_seat "perimeter_warthog_04" "warthog_d" crew04_driver)
        (begin
			(cs_run_command_script (object_get_ai crew04_driver) warthog_04_retreat_path)
        )
    )
)

(script static void perimeter_warthog_04_retreat
    (wake warthog_04_retreat_thread)
    (dialog_crew_04_retreating)
)

(script command_script engineer_warthog_01_path
	(cs_go_to engineer_warthog/p0)
	(sleep 40)
	(object_destroy engineer01_driver)
	(object_destroy engineer_warthog_01)
)

(script command_script engineer_warthog_02_path
	(cs_go_to engineer_warthog/p1)
	(sleep 40)
	(object_destroy engineer02_driver)
	(object_destroy engineer_warthog_02)
)

(script command_script engineer_warthog_03_path
	(cs_go_to engineer_warthog/p2)
	(sleep 40)
	(object_destroy engineer03_driver)
	(object_destroy engineer_warthog_03)
)

(script command_script engineer_warthog_04_path
	(cs_go_to engineer_warthog/p3)
	(sleep 40)
	(object_destroy engineer04_driver)
	(object_destroy engineer_warthog_04)
	(ai_erase marine_engineer_drivers)
)

(script static void engineer_warthog_01
    (object_create "engineer_warthog_01")
	(ai_vehicle_reserve engineer_warthog_01 true)
    (unit_set_enterable_by_player "engineer_warthog_01" false)
    (set engineer01_driver (unit (list_get (ai_actors "marine_engineer_drivers") 0)))
    (vehicle_load_magic "engineer_warthog_01" "warthog_d" engineer01_driver)
    (cs_run_command_script (object_get_ai engineer01_driver) engineer_warthog_01_path)
)

(script static void engineer_warthog_02
    (object_create "engineer_warthog_02")
	(ai_vehicle_reserve engineer_warthog_02 true)
    (unit_set_enterable_by_player "engineer_warthog_02" false)
	(set engineer02_driver (unit (list_get (ai_actors "marine_engineer_drivers") 1)))
    (vehicle_load_magic "engineer_warthog_02" "warthog_d" engineer02_driver)
	(cs_run_command_script (object_get_ai engineer02_driver) engineer_warthog_02_path)
)

(script static void engineer_warthog_03
    (object_create "engineer_warthog_03")
	(ai_vehicle_reserve engineer_warthog_03 true)
    (unit_set_enterable_by_player "engineer_warthog_03" false)
	(set engineer03_driver (unit (list_get (ai_actors "marine_engineer_drivers") 2)))
    (vehicle_load_magic "engineer_warthog_03" "warthog_d" engineer03_driver)
    (cs_run_command_script (object_get_ai engineer03_driver) engineer_warthog_03_path)
)

(script static void engineer_warthog_04
    (object_create "engineer_warthog_04")
	(ai_vehicle_reserve engineer_warthog_04 true)
    (unit_set_enterable_by_player "engineer_warthog_04" false)
	(set engineer04_driver (unit (list_get (ai_actors "marine_engineer_drivers") 3)))
    (vehicle_load_magic "engineer_warthog_04" "warthog_d" engineer04_driver)
    (cs_run_command_script (object_get_ai engineer04_driver) engineer_warthog_04_path)
)

(script static void engineer_warthogs
    (if debug
        (print "engineer_warthogs"))
    (ai_place "marine_engineer_drivers")
    (object_cannot_take_damage (ai_actors "marine_engineer_drivers"))
    (engineer_warthog_01)
    (sleep 30)
    (engineer_warthog_02)
    (sleep 120)
    (engineer_warthog_03)
    (sleep 50)
    (engineer_warthog_04)
)

(script dormant enc01_annex_defense
    (if debug
        (print "enc01_annex_defense"))
    (certain_save)
    ;(ai_vehicle_enterable_team "south_sniper_turret" covenant)
    ;(ai_vehicle_enterable_distance "south_sniper_turret" 4.0)
    (ai_place "cov_annex_elites")
    (ai_set_orders "cov_annex_elites" "3_guard_tower")
    (ai_place "cov_annex_tower")
    (ai_set_orders "cov_annex_tower" "3_tower")
    (ai_place "cov_annex_turret")
    (ai_set_orders "cov_annex_turret" "3_man_turret")
    (ai_place "cov_annex_grunts_01")
    (ai_set_orders "cov_annex_grunts_01" "3_guard_entrance_to_cower")
    (ai_place "cov_annex_grunts_02")
    (ai_set_orders "cov_annex_grunts_02" "3_guard_entrance_to_turret")
    (ai_place "marine_annex_assault_team")
    (ai_set_orders "marine_annex_assault_team" "4_assault_team_init")
    ;(ai_try_to_fight "marine_perimeter_crew_01" "cov_annex")
    ;(ai_try_to_fight "marine_perimeter_crew_02" "cov_annex")
    (wake perimeter_warthog_01)
    (wake perimeter_warthog_02)
    (sleep_until (<= (ai_living_count "cov_annex_elites") 1) 30 300)
    (ai_place "cov_annex_reinforcements")
    (ai_set_orders "cov_annex_reinforcements" "3_reinforcements")
    (sleep_until (<= (ai_living_count "cov_annex_reinforcements") 3))
    (sleep_until (<= (ai_living_count "cov_annex_elites") 0))
    (set perimeter_warthog_01_continue true)
    (set perimeter_warthog_02_continue true)
    (sleep 90)
    (wake perimeter_warthog_03)
    (wake perimeter_warthog_04)
    (sleep 300)
    (wake initial_deploy_snipers)
    (sleep 60)
    (sleep_until sniper_atv_01_continue)
    (set begin_defense_phase true)
    (sleep 300)
    (print "attack imminent...")
    (sleep 200)
    (cinematic_orbital_attack)
    (sleep 450)
    (engineer_warthogs)
)

(script static void enc01_commandeer_ghost
    (if debug
        (print "enc01_load_ghost"))
    (if (< 0 (ai_living_count ai_current_squad))
        (unit_enter_vehicle (unit (list_get (ai_actors ai_current_squad) 0)) "annex_ghost_01" "ghost_d"))
    (if (< 1 (ai_living_count ai_current_squad))
        (unit_enter_vehicle (unit (list_get (ai_actors ai_current_squad) 1)) "annex_ghost_02" "ghost_d"))
)

(script static void enc01_turret_captured
    (if debug
        (print "enc01_turret_captured"))
    ;(ai_vehicle_enterable_team "south_sniper_turret" human)
    ;(ai_vehicle_enterable_distance "south_sniper_turret" 4.0)
    (set sniper_atv_01_continue true)
    (set sniper_atv_02_continue true)
)

(script dormant mission_insertion_phase
    (if debug
        (print "mission_insertion_phase"))
    (wake enc01_annex_defense)
)

(script static void cleanup_insertion_phase
    (if debug
        (print "cleanup_insertion_phase"))
    (sleep_forever mission_insertion_phase)
)

(script dormant cov_hwave_01_start
    (if debug
        (print "cov_hwave_01_start"))
    (cd_heavy_inbound_01)
    (sleep_until (<= (ai_living_count "cov_hwave_01_driver") 0))
    (set cov_hwave_01_finished true)
)

(script dormant cov_wave_02_start
    (if debug
        (print "cov_wave_02_start"))
    (begin_random
        (set cov_wave_02_random_fork false)
        (set cov_wave_02_random_fork true)
    )
    (cd_inbound_02)
    (sleep_until (<= (ai_living_count "cov_wave_02_scouts") 0))
    (set cov_wave_02b_should_begin true)
    (set cov_wave_02_finished true)
)

(script dormant cov_wave_01b_start
    (if debug
        (print "cov_wave_01b_start"))
    (begin_random
        (set cov_wave_01_random_fork true)
    )
    (cd_inbound_01b)
    (sleep_until (<= (ai_living_count "cov_wave_01b_scouts") 0))
    (set cov_wave_01_finished true)
)

(script dormant cov_wave_01_start
    (if debug
        (print "cov_wave_01_start"))
    (begin_random
        (set cov_wave_01_random_fork false)
        (set cov_wave_01_random_fork true)
    )
    (cd_inbound_01)
    (sleep_until (<= (ai_living_count "cov_wave_01_scouts") 0))
    (set cov_wave_01b_should_begin true)
)

(script static boolean cov_wave_01_fork
    (and
        (= cov_wave_01_random_fork true)
        (not crew01_retreated)
    )
)

(script static boolean cov_wave_01_ghost_fork
    (or
        (= cov_wave_01_random_fork false)
        crew01_retreated
    )
)

(script static boolean cov_wave_01_checkpoint_01
    (volume_test_objects_all "cov_wave_01_checkpoint_01" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_rally_point_01
    (volume_test_objects_all "cov_wave_01_rally_point_01" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_rally_point_02
    (volume_test_objects_all "cov_wave_01_rally_point_02" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_warthog_01
    (volume_test_objects_all "cov_wave_01_warthog_01" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_warthog_03
    (volume_test_objects_all "cov_wave_01_warthog_03" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_rally_point_03
    (volume_test_objects_all "cov_wave_01_rally_point_03" (ai_actors ai_current_squad))
)

(script static boolean cov_hwave_01_rally_point_01
    (volume_test_objects_all "cov_hwave_01_rally_point_01" (ai_actors ai_current_squad))
)

(script static boolean cov_hwave_01_rally_vs_hogs
    (volume_test_objects_all "cov_hwave_01_attack_hogs" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_01_rout_warthog_01
    (not (vehicle_test_seat_list "perimeter_warthog_01" "warthog_g" (ai_actors "marine_perimeter_crew_01")))
)

(script static boolean cov_wave_02_rout_warthog_02
    (not (vehicle_test_seat_list "perimeter_warthog_02" "warthog_g" (ai_actors "marine_perimeter_crew_02")))
)

(script static boolean cov_wave_01_rout_warthog_03
    (not (vehicle_test_seat_list "perimeter_warthog_03" "warthog_g" (ai_actors "marine_perimeter_crew_03")))
)

(script static boolean cov_wave_02_rout_warthog_04
    (not (vehicle_test_seat_list "perimeter_warthog_04" "warthog_g" (ai_actors "marine_perimeter_crew_04")))
)

(script static void cov_wave_01_reveal_warthog_01
    (if (not crew01_retreated)
        (ai_magically_see ai_current_squad "marine_perimeter_crew_01"))
)

(script static void cov_wave_01_reveal_warthog_03
    (if (not crew03_retreated)
        (ai_magically_see ai_current_squad "marine_perimeter_crew_03"))
)

(script static boolean perimeter_crew_01_retreated
    (= crew01_retreated true)
)

(script static boolean perimeter_crew_02_retreated
    (= crew02_retreated true)
)

(script static boolean perimeter_crew_03_retreated
    (= crew03_retreated true)
)

(script static boolean perimeter_crew_04_retreated
    (= crew04_retreated true)
)

(script static boolean cov_wave_02_rally_01
    (volume_test_objects_all "cov_wave_02_rally_01" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_02_rally_02
    (volume_test_objects_all "cov_wave_02_rally_02" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_02_rally_vs_hog_02
    (volume_test_objects_all "cov_wave_02_rally_vs_hog_02" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_02_rally_vs_hog_04
    (volume_test_objects_all "cov_wave_02_rally_vs_hog_04" (ai_actors ai_current_squad))
)

(script static boolean cov_wave_02_fork
    (and
        (= cov_wave_02_random_fork true)
        (not crew02_retreated)
    )
)

(script static boolean cov_wave_02_ghost_fork
    (or
        (= cov_wave_02_random_fork false)
        crew04_retreated
    )
)

(script dormant mission_defense_phase
    (sleep_until begin_defense_phase)
    (if debug
        (print "mission_defense_phase"))
    (cleanup_insertion_phase)
    (wake cov_wave_01_start)
    (sleep (* ticks_per_minute 2.0))
    (wake cov_wave_02_start)
    (sleep (* ticks_per_minute 2.0))
    (wake cov_wave_01b_start)
    (sleep (* ticks_per_minute 2.0))
    (begin_random
        (begin
            (wake cov_hwave_01_start)
            (sleep (* ticks_per_minute 3.0))
        )
    )
)

(script static void cleanup_defense_phase
    (if debug
        (print "cleanup_defense_phase"))
    (sleep_forever mission_defense_phase)
)

(script dormant mission_retreat_phase
    (if debug
        (print "mission_retreat_phase"))
    (cleanup_defense_phase)
)

(script static void cleanup_retreat_phase
    (if debug
        (print "cleanup_retreat_phase"))
    (sleep_forever mission_insertion_phase)
)

(script static void entry_test2
    (print "entered order!!")
)

(script static void entry_test
    (print "entered order!!")
)

(script static boolean grenade_pulled
    (player_action_test_grenade_trigger)
)

(script static void coop_control
    (if (< (list_count (players)) 1)
        (begin
            (if debug
                (print "difficulty adjusted for coop"))
            (set coop true)
        )
    )
)

(script static void diff_control
    (if (= heroic (game_difficulty_get))
        (begin
            (if debug
                (print "difficulty adjusted for hard"))
        )
    )
    (if (= legendary (game_difficulty_get))
        (begin
            (if debug
                (print "difficulty adjusted for impossible"))
        )
    )
)

(script startup mission
    (fade_out 0.0 0.0 0.0 0)
	(cinematic_show_letterbox 0)
	(ai_vehicle_reserve annex_ghost_01 true)
	(ai_vehicle_reserve annex_ghost_02 true)
    (coop_control)
    (diff_control)
    (ai_allegiance human player)
    (if (cinematic_skip_start)
        (begin
            (set cinematic_ran true)
            (cinematic_insertion)
        )
    )
    (cinematic_skip_stop)
    (if (not cinematic_ran)
        (fade_in 0.0 0.0 0.0 0))
    (wake mission_insertion_phase)
    (wake mission_defense_phase)
)
