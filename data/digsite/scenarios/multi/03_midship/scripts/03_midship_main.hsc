(global short left_elev_state 3)
(global short main_elev_state 0)
(global short right_elev_state 3)

(script continuous left
    (if (= left_elev_state 1) 
        (begin
            (device_set_position "left" 1.0)
            (sleep_until (>= (device_get_position "left") 1.0))
            (device_set_position "left" 0.0)
            (sleep_until (>= (device_get_position "left") 0.0))
            (set left_elev_state 3)
        )
    )
    (if (= left_elev_state 3) 
        (begin
            (sleep_until (volume_test_objects "left_activate" (players)) 10)
            (set left_elev_state 1)
        )
    )
)

(script continuous main1
    (if (= main_elev_state 0) 
        (begin
            (if (volume_test_objects "main_activate" (players)) 
                (begin
                    (set main_elev_state 1)
                )
            )
        )
    )
    (if (= main_elev_state 1) 
        (begin
            (device_set_position "main1" 1.0)
            (sleep_until (>= (device_get_position "main1") 1.0))
            (set main_elev_state 3)
        )
    )
    (if (= main_elev_state 2) 
        (begin
            (device_set_position "main1" 0.0)
            (sleep_until (<= (device_get_position "main1") 0.0))
            (set main_elev_state 0)
        )
    )
    (if (= main_elev_state 3) 
        (begin
            (sleep_until (volume_test_objects "floor_0_stop" (players)) 10 264)
            (set main_elev_state 2)
        )
    )
)

(script continuous right
    (if (= right_elev_state 1) 
        (begin
            (device_set_position "right" 1.0)
            (sleep_until (>= (device_get_position "right") 1.0))
            (device_set_position "right" 0.0)
            (sleep_until (>= (device_get_position "right") 0.0))
            (set right_elev_state 3)
        )
    )
    (if (= right_elev_state 3) 
        (begin
            (sleep_until (volume_test_objects "right_activate" (players)) 10)
            (set right_elev_state 1)
        )
    )
)

