(global short elevator1_state 0)

(script continuous elevator1
    (if (= elevator1_state 0) 
        (begin
            (if 
                (or
                    (volume_test_objects "floor_0_pad_0" (players))
                    (volume_test_objects "floor_0_pad_1" (players))
                ) 
                    (begin
                        (set elevator1_state 1)
                    )
            )
            (if (volume_test_objects "floor_1_stop" (players)) 
                (begin
                    (set elevator1_state 1)
                )
            )
        )
    )
    (if (= elevator1_state 1) 
        (begin
            (device_set_position "elevator1" 1.0)
            (sleep_until (>= (device_get_position "elevator1") 1.0))
            (set elevator1_state 3)
            (sleep 50)
        )
    )
    (if (= elevator1_state 2) 
        (begin
            (device_set_position "elevator1" 0.0)
            (sleep_until (<= (device_get_position "elevator1") 0.0))
            (set elevator1_state 0)
            (sleep 50)
        )
    )
    (if (= elevator1_state 3) 
        (begin
            (if 
                (or
                    (volume_test_objects "floor_1_pad_0" (players))
                    (volume_test_objects "floor_1_pad_1" (players))
                ) 
                    (begin
                        (set elevator1_state 2)
                    )
            )
            (if (volume_test_objects "floor_0_stop" (players)) 
                (begin
                    (set elevator1_state 2)
                )
            )
        )
    )
)
