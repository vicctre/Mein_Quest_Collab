
event_inherited()

enum TongueState {
    toss,
    pull,
}

sp_max = 7.3
sp = sp_max
dist_moved = 0
fast_move_dist = 240
max_dist = 320
// some more kinematic equations
// how fast tongue tip decelrates after reaching fast_move_dist
decel = power(sp, 2) / 2 / (max_dist - fast_move_dist)
