
for (var i = 0; i < array_length(sprites); ++i) {
    draw_sprite(
        sprites[i],
        image_index,
        bbox_left + i * width,
        bbox_top
    )
}
