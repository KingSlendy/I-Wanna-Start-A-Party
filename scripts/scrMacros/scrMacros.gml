#macro null undefined
#macro DELTA objGameManager.delta
#macro LIVE if (live_call()) return live_result

//Colors
#macro c_chancetime make_color_rgb(255, 255, 0)
#macro c_gold #926F34

//Global
#macro VERSION "0.9.7.0"

//Network
#macro DEFAULT_URL "https://iwannastartaparty.com"
#macro DEFAULT_PORT "33321"
#macro DEFAULT_PLAYER "Player"
#macro FAILCHECK_ID 121

//Game
#macro IS_BOARD (string_count("Board", room_get_name(room)) > 0)
#macro IS_MINIGAME (string_count("Minigame", room_get_name(room)) > 0)
#macro DESC_START function() { return 
#macro DESC_END ; }