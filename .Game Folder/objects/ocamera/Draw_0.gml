if DEV {
    draw_circle(x, y, 4, false)
    if instance_exists(follow) {
        draw_line(x, y, follow.x, follow.y)
    }
}