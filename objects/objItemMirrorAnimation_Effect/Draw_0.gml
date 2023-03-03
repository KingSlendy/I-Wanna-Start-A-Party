var center_cam_x = camera_get_view_x(view_camera[0]) + 400;
var center_cam_y = camera_get_view_y(view_camera[0]) + 304;

gpu_set_blendmode(bm_add);
gpu_set_tex_filter(true);

var angle_reversed;
for (var i = 0; i < total_spark; i++) {
    var c = (90 / total_spark) * i + angle;	
	angle_reversed = (i % 2 == 0) ? -1 : 1;
    
    var xscale = image_xscale;
    draw_sprite_ext(sprItemMirrorAnimation_SparkEffect, 0, center_cam_x,center_cam_y, xscale, xscale, c * angle_reversed, c_ltgray, 0.1);
}

var ball_xscale = image_xscale * 1.3;
draw_sprite_ext(sprItemMirrorAnimation_SparkLightBallEffect, 0, center_cam_x,center_cam_y, ball_xscale, ball_xscale, 0, c_ltgray, 0.5);
draw_sprite_ext(sprItemMirrorAnimation_LightEffect, 0, center_cam_x,center_cam_y, ball_xscale * 8, ball_xscale * 8, 0, c_ltgray, image_alpha);

gpu_set_tex_filter(false);
gpu_set_blendmode(bm_normal);