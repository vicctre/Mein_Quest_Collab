

if (room == rmTitleScreen)
	exit;

switch room {
	case rmAdventureLogsScreen:
        x = 1376
        y = 768
	break
	case W1_1_part5:
        x = 240
        y = 200
        cam_zoom_target = 0.8
        SnapCamera()
        follow = id
        cam_width = 480
	break
	case W1_2_part2:
        cam_zoom_target = 0.8125
        SnapCamera()
	break
	case W1_3BOSS:
        x = room_width * 0.5
        //cam_zoom_target = 0.8
        SnapCamera()
        follow = id
        //cam_width = 480
	break
	default:
        SetRoomStartCamera()
        ResizeCamera()
        follow = global.player
        cam_width = cam_width_base

}
