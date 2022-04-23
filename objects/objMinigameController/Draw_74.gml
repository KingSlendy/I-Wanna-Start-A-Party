if (instance_exists(objCameraSplit4)) {
	switch (info.type) {
		case "4vs":
			draw_4vs_squares();
			break;
			
		case "1":
			break;
			
		case "2vs2":
			draw_2vs2_squares(info);
			break;
	}
}
