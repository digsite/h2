(script static void skip_to_bsp1_post_lz
	(ai_kill 3turrets)
	(ai_kill 0guntower)
	
	(if (!= (structure_bsp_index) 0) (switch_bsp 0))
	(sleep_until (= (structure_bsp_index) 0))
	(object_teleport (player0) dig_bsp1_test_entry_lz)
	
	(ai_place allied_ghost01_02)
	(ai_place allied_wraith01)
	(object_create_anew player_wraith01)
	
	(sleep 2)
	(vehicle_load_magic player_wraith01 "" (player0))
)

(script static void skip_to_bsp1_pre_lz
	(ai_kill 3turrets)
	(if (!= (structure_bsp_index) 0) (switch_bsp 0))
	(sleep_until (= (structure_bsp_index) 0))
	(object_teleport (player0) dig_bsp1_test_entry_lz)

	(ai_place 3turrets) ; full chaos
	; comment these out to see the ships take out the turrets themselves (they can do it)
	(unit_kill 0guntower_right)
	(unit_kill 0guntower_center)
	(unit_kill 0guntower_left)
	
	
	
)

(script static void skip_to_bsp2

	(if (!= (structure_bsp_index) 1) (switch_bsp 1))
	(sleep_until (= (structure_bsp_index) 1))
	(object_teleport (player0) dig_bsp2_testing_entry)
	(object_create_anew dig_bsp2_testing_entry)
	
	(ai_place a_1turret_wraiths)
	(ai_place a_1turret_ghosts)
	
	(vehicle_load_magic dig_bsp2_testing_entry "" (player0))
)

(script static void skip_to_bsp3

	(if (!= (structure_bsp_index) 2) (switch_bsp 2))
	(sleep_until (= (structure_bsp_index) 2))
	(object_teleport (player0) dig_bsp3_testing_entry)
	(object_create_anew dig_bsp3_testing_entry)
	(sleep 2)
	(vehicle_load_magic dig_bsp3_testing_entry "" (player0))
)

(script static void skip_to_bsp3_final_battle
	
	(if (!= (structure_bsp_index) 2) (switch_bsp 2))
	(sleep_until (= (structure_bsp_index) 2))
	(object_teleport (player0) dig_bsp2_final_testing_entry)
	(object_create_anew dig_bsp2_final_testing_entry)
	(sleep 2)
	(vehicle_load_magic dig_bsp2_final_testing_entry "" (player0))
)

(script dormant ai_kill01
	(print "ai_kill01")
	
	(ai_erase intro_elites)
	(ai_erase intro_grunts)
	(ai_erase turret01_elites)
	(ai_erase turret_left_elites)
	(ai_erase trap01_grunts)
	(ai_erase turret_right_elites01)
	(ai_erase turret_right_elites02)
	(ai_erase turret_right_grunts02)
	(ai_erase turret_right_grunts01)
)
	;vvvvvvvvvvvv-- AI kill02 --vvvvvvvvvvvvv

(script dormant ai_kill02

	(print "ai_kill02")
	
	(ai_erase runandgun01_ghostelites)
	(ai_erase runandgun01_ghostelites02)
	(ai_erase runandgun01_i_elites01)
	(ai_erase runandgun01_i_grunts01)
	(ai_erase runandgun01_i_elites02)
	(ai_erase runandgun01_i_grunts02)
	(ai_erase runandgun01_t_grunts02)
	(ai_erase runandgun01_t_grunts03)
	(ai_erase runandgun01_ghostelites03)
	(ai_erase runandgun01_ghostelites04)
	
	(ai_erase view_i_01)
	(ai_erase view_tankelites01)
	(ai_erase view_ghostelites01)
	(ai_erase view_shadow01)
	(ai_erase view_shadow02)
	
	;3turrets
	;lz_dig_phantoms
	;runandgun01 (trap01)
	;view (view_v, view_dropships)
	; 1turret
	; 2turret
	; supertrap (supertrap_enemies)
	; controlroom
	; final_battle
	
	
	(ai_erase 1turret_tankelites01)
	(ai_erase 1turret_shadows01)
	(ai_erase 1turret_tankelites02)
	(ai_erase 1turret_ghostelites01)
	(ai_erase 1turret_ghostelites02)
	(ai_erase 1turret_turret_elites01)
	(ai_erase 1turret_end_grunts01)
	
	(ai_erase 1turret_jack_elites01)
	
	(ai_erase 1turret_turretgrunts01)
	(ai_erase 1turret_wraith_behind)
	
	(ai_erase 1turret_interior_low)
	(ai_erase 1turret_interior_back)
	
)

(script dormant ai_kill03

	(print "ai_kill03")
	
	(ai_erase runandgun02_t_grunts01)
	(ai_erase runandgun02_t_grunts02)
	(ai_erase runandgun02_ghostelites01)
	(ai_erase runandgun02_tankelites01)
	(ai_erase runandgun02_interior)

)

(script dormant ai_kill04

	(ai_erase 2turret_av_turrets)
	(ai_erase 2turret_interior_back)
	(ai_erase 2turret_interior_front)
	(ai_erase 2turret_ghostelites01)
	(ai_erase 2turret_tankelites01)

)

(script dormant ai_kill05

	(print "ai_kill05")

	(ai_erase supertrap_turretgrunts01)
	(ai_erase supertrap_tankelites01)
	(ai_erase supertrap_grunts01)
	(ai_erase supertrap_grunts02)
	(ai_erase supertrap_grunts03)
	(ai_erase supertrap_left_v)
	(ai_erase supertrap_right_v)
	
	(wake ai_kill04)
	(wake ai_kill03)
	(wake ai_kill02)
	(wake ai_kill01)
)
