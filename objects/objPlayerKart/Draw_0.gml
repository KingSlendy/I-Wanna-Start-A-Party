
var cdir = (point_direction(objMinigameController.x, objMinigameController.y, x, y)) - 90
var cdirtan = (tan(objMinigameController.z / (point_distance(x, y, objMinigameController.x, objMinigameController.y)))) + 30

if (!lookBehind) {
	d3d_transform_set_translation(0, -0.5, 0);
    d3d_transform_add_scaling(8, 8, 8);
    d3d_transform_add_rotation_x(cdirtan);
    d3d_transform_add_rotation_z(cdir);
    d3d_transform_add_translation(x, y, z);
    d3d_model_draw(objMinigameController.model_player, 0, 0, 0, objMinigameController.player_tex[drawTex]);
    d3d_transform_set_identity();
} else {
    d3d_transform_set_translation(0, -0.5, 0);
    d3d_transform_add_scaling(8, 8, 8);
    d3d_transform_add_rotation_x(cdirtan);
    d3d_transform_add_rotation_z(cdir);
    d3d_transform_add_translation(x, y, z);
    d3d_model_draw(objMinigameController.model_player, 0, 0, 0, objMinigameController.player_texf[drawTex]);
    d3d_transform_set_identity();
}