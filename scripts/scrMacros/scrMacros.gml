#macro null undefined
#macro DELTA objGameManager.delta

//Colors
#macro c_chancetime make_color_rgb(255, 255, 0);
#macro c_gold #926F34

//Global
#macro VERSION "0.8.3.11"

//Network
#macro FAILCHECK_ID 121

//Boards
#macro IS_BOARD (string_count("Board", room_get_name(room)) > 0)