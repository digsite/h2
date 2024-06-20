(script static void place_marines_support
    (ai_set_orders "marines_support" "left")
    (ai_place "marines_support")

)

(script static void load_marines_support
    (unit_enter_vehicle (unit (list_get (ai_actors "marines_support_driver") 0)) "warthog_marines_support" "warthog_d")
    (vehicle_load_magic "warthog_marines_support" "warthog_g" (unit (list_get (ai_actors "marines_support_gunner") 0)))
    (unit_enter_vehicle (unit (list_get (ai_actors "marines_support_passenger") 0)) "warthog_marines_support" "warthog_p")
)

(script static void place_marines_assault
    (ai_set_orders "marines_assault" "right")
    (ai_place "marines_assault")
)

(script static void load_marines_assault
    (unit_enter_vehicle (unit (list_get (ai_actors "marines_assault_driver") 0)) "warthog_marines_assault" "warthog_d")
    (vehicle_load_magic "warthog_marines_assault" "warthog_g" (unit (list_get (ai_actors "marines_assault_gunner") 0)))
    (unit_enter_vehicle (unit (list_get (ai_actors "marines_assault_passenger") 0)) "warthog_marines_assault" "warthog_p")
)

(script static void place_covenant
    (ai_place "cov_elites_base_top")
    (ai_set_orders "cov_elites_base_top" "def_top_front")
    (ai_place "cov_elites_base_inner")
    (ai_set_orders "cov_elites_base_inner" "guard_front_rear")
    (ai_place "cov_base_right")
    (ai_set_orders "cov_base_right" "guard_ground_right")
    (ai_place "cov_base_left")
    (ai_set_orders "cov_base_left" "guard_ground_left")
)

(script startup main
	(fade_in 0 0 0 0)
	(cinematic_show_letterbox 0)
    (ai_allegiance human player)
    (print "startup")
    (place_marines_support)
    (load_marines_support)
    (place_marines_assault)
    (load_marines_assault)
    (place_covenant)
)
