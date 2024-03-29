function __input_validate_macros()
{
    #region General
    
    if (!is_numeric(INPUT_MAX_PLAYERS) || (floor(INPUT_MAX_PLAYERS) != INPUT_MAX_PLAYERS) || (INPUT_MAX_PLAYERS < 1))
    {
        __input_error("INPUT_MAX_PLAYERS must be an integer that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_MAX_ALTERNATE_BINDINGS) || (floor(INPUT_MAX_ALTERNATE_BINDINGS) != INPUT_MAX_ALTERNATE_BINDINGS) || (INPUT_MAX_ALTERNATE_BINDINGS < 1))
    {
        __input_error("INPUT_MAX_ALTERNATE_BINDINGS must be an integer that is greater than or equal to 0");
    }
    
    if (!is_bool(INPUT_TIMER_MILLISECONDS))
    {
        __input_error("INPUT_TIMER_MILLISECONDS must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_ANDROID_KEYBOARD_ALLOWED))
    {
        __input_error("INPUT_ANDROID_KEYBOARD_ALLOWED must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SWITCH_KEYBOARD_ALLOWED))
    {
        __input_error("INPUT_SWITCH_KEYBOARD_ALLOWED must be either <true> or <false>");
    }
    
    if (!is_numeric(INPUT_BINDING_SCAN_TIMEOUT) || (INPUT_BINDING_SCAN_TIMEOUT < 1000))
    {
        __input_error("INPUT_MAX_ALTERNATE_BINDINGS must be a number that is greater than 1000ms (1 second)");
    }
    
    if ((INPUT_IGNORE_RESERVED_KEYS_LEVEL != 0)
    &&  (INPUT_IGNORE_RESERVED_KEYS_LEVEL != 1)
    &&  (INPUT_IGNORE_RESERVED_KEYS_LEVEL != 2))
    {
        __input_error("INPUT_IGNORE_RESERVED_KEYS_LEVEL must be either 0, 1, or 2");
    }
    
    #endregion
    
    
    
    #region Verbs
    
    if (!is_numeric(INPUT_REPEAT_DEFAULT_DELAY) || (INPUT_REPEAT_DEFAULT_DELAY < 1))
    {
        __input_error("INPUT_REPEAT_DEFAULT_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_REPEAT_DEFAULT_PREDELAY) || (INPUT_REPEAT_DEFAULT_PREDELAY < 1))
    {
        __input_error("INPUT_REPEAT_DEFAULT_PREDELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_LONG_DELAY) || (INPUT_LONG_DELAY < 1))
    {
        __input_error("INPUT_LONG_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_DOUBLE_DELAY) || (INPUT_DOUBLE_DELAY < 1))
    {
        __input_error("INPUT_DOUBLE_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_CHORD_DEFAULT_TIME) || (INPUT_CHORD_DEFAULT_TIME < 1))
    {
        __input_error("INPUT_CHORD_DEFAULT_TIME must be a number that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_2D_CLAMP))
    {
        __input_error("INPUT_2D_CLAMP must be either <true> or <false>");
    }
    
    if ((INPUT_2D_XY_AXIS_BIAS < 0) || (INPUT_2D_XY_AXIS_BIAS > 1))
    {
        __input_error("INPUT_2D_XY_AXIS_BIAS should be between 0.0 and 1.0 (was ", INPUT_2D_XY_AXIS_BIAS, ")");
    }
    
    if (!is_bool(INPUT_2D_XY_AXIS_BIAS_DIAGONALS))
    {
        __input_error("INPUT_2D_XY_AXIS_BIAS_DIAGONALS must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Profiles and Default Bindings
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_KEYBOARD) && !is_undefined(INPUT_AUTO_PROFILE_FOR_KEYBOARD))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_KEYBOARD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MOUSE) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MOUSE))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_KEYBOARD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_GAMEPAD) && !is_undefined(INPUT_AUTO_PROFILE_FOR_GAMEPAD))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_GAMEPAD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MIXED) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MIXED))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_MIXED must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MULTIDEVICE) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MULTIDEVICE))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_MULTIDEVICE must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_bool(INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER))
    {
        __input_error("INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES))
    {
        __input_error("INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Source Modes
    
    if ((INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.FIXED)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.JOIN)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.HOTSWAP)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.MIXED)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.MULTIDEVICE))
    {
        __input_error("INPUT_STARTING_SOURCE_MODE must be a member of the INPUT_SOURCE_MODE enum");
    }
    
    if (!is_string(INPUT_MULTIPLAYER_LEAVE_VERB) && !is_undefined(INPUT_MULTIPLAYER_LEAVE_VERB))
    {
        __input_error("INPUT_MULTIPLAYER_LEAVE_VERB must be a string or <undefined>");
    }
    
    if (!is_method(INPUT_MULTIPLAYER_ABORT_CALLBACK) && !(is_numeric(INPUT_MULTIPLAYER_ABORT_CALLBACK) && script_exists(INPUT_MULTIPLAYER_ABORT_CALLBACK)) && !is_undefined(INPUT_MULTIPLAYER_ABORT_CALLBACK))
    {
        __input_error("INPUT_MULTIPLAYER_ABORT_CALLBACK must be a function, a script, or <undefined>");
    }
    
    if (!is_numeric(INPUT_HOTSWAP_DELAY) || (INPUT_HOTSWAP_DELAY < 1))
    {
        __input_error("INPUT_HOTSWAP_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_HOTSWAP_ON_GAMEPAD_AXIS))
    {
        __input_error("INPUT_HOTSWAP_ON_GAMEPAD_AXIS must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_HOTSWAP_ON_MOUSE_MOVEMENT))
    {
        __input_error("INPUT_HOTSWAP_ON_MOUSE_MOVEMENT must be either <true> or <false>");
    }
    
    if (!is_method(INPUT_HOTSWAP_CALLBACK) && !(is_numeric(INPUT_HOTSWAP_CALLBACK) && script_exists(INPUT_HOTSWAP_CALLBACK)) && !is_undefined(INPUT_HOTSWAP_CALLBACK))
    {
        __input_error("INPUT_HOTSWAP_CALLBACK must be a function, a script, or <undefined>");
    }
    
    if (!is_bool(INPUT_HOTSWAP_AUTO_PROFILE))
    {
        __input_error("INPUT_HOTSWAP_AUTO_PROFILE must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Gamepad Data
    
    if (!is_bool(INPUT_SDL2_REMAPPING))
    {
        __input_error("INPUT_SDL2_REMAPPING must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SDL2_ALLOW_EXTERNAL))
    {
        __input_error("INPUT_SDL2_ALLOW_EXTERNAL must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SDL2_ALLOW_EXTENDED))
    {
        __input_error("INPUT_SDL2_ALLOW_EXTENDED must be either <true> or <false>");
    }
    
    if (!is_string(INPUT_SDL2_DATABASE_PATH) && !is_undefined(INPUT_SDL2_DATABASE_PATH))
    {
        __input_error("INPUT_SDL2_DATABASE_PATH must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CONTROLLER_TYPE_PATH) && !is_undefined(INPUT_CONTROLLER_TYPE_PATH))
    {
        __input_error("INPUT_CONTROLLER_TYPE_PATH must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_BLACKLIST_PATH) && !is_undefined(INPUT_BLACKLIST_PATH))
    {
        __input_error("INPUT_BLACKLIST_PATH must be a string or <undefined>");
    }
    
    #endregion
    
    
    
    #region Mouse, Touch, Cursor
    
    if (!is_numeric(INPUT_MOUSE_MOVE_DEADZONE) || (INPUT_MOUSE_MOVE_DEADZONE < 0))
    {
        __input_error("INPUT_MOUSE_MOVE_DEADZONE must be a number that is greater than or equal to 0");
    }
    
    if (!is_numeric(INPUT_MAX_TOUCHPOINTS) || (floor(INPUT_MAX_TOUCHPOINTS) != INPUT_MAX_TOUCHPOINTS) || (INPUT_MAX_TOUCHPOINTS < 1))
    {
        __input_error("INPUT_MAX_TOUCHPOINTS must be an integer that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_TOUCH_EDGE_DEADZONE) || (INPUT_TOUCH_EDGE_DEADZONE < 0))
    {
        __input_error("INPUT_TOUCH_EDGE_DEADZONE must be a number that is greater than or equal to 0");
    }
    
    if (!is_bool(INPUT_TOUCH_POINTER_ALLOWED))
    {
        __input_error("INPUT_TOUCH_POINTER_ALLOWED must be either <true> or <false>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_UP) && !is_undefined(INPUT_CURSOR_VERB_UP))
    {
        __input_error("INPUT_CURSOR_VERB_UP must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_DOWN) && !is_undefined(INPUT_CURSOR_VERB_DOWN))
    {
        __input_error("INPUT_CURSOR_VERB_DOWN must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_LEFT) && !is_undefined(INPUT_CURSOR_VERB_LEFT))
    {
        __input_error("INPUT_CURSOR_VERB_LEFT must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_RIGHT) && !is_undefined(INPUT_CURSOR_VERB_RIGHT))
    {
        __input_error("INPUT_CURSOR_VERB_RIGHT must be a string or <undefined>");
    }
    
    if (!is_numeric(INPUT_CURSOR_START_SPEED) || (INPUT_CURSOR_START_SPEED <= 0))
    {
        __input_error("INPUT_CURSOR_START_SPEED must be a number that is greater than 0");
    }
    
    if (!is_numeric(INPUT_CURSOR_EXPONENT))
    {
        __input_error("INPUT_CURSOR_START_SPEED must be a number");
    }
    
    #endregion
    
    
    
    #region Gamepads
    
    if (!is_numeric(INPUT_DEFAULT_AXIS_MIN_THRESHOLD) || (INPUT_DEFAULT_AXIS_MIN_THRESHOLD < 0) || (INPUT_DEFAULT_AXIS_MIN_THRESHOLD >= INPUT_DEFAULT_AXIS_MAX_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_AXIS_MIN_THRESHOLD must be a number greater than or equal to 0, and lesser than INPUT_DEFAULT_AXIS_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_AXIS_MAX_THRESHOLD) || (INPUT_DEFAULT_AXIS_MAX_THRESHOLD > 1) || (INPUT_DEFAULT_AXIS_MAX_THRESHOLD < INPUT_DEFAULT_AXIS_MIN_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_AXIS_MAX_THRESHOLD must be a number less than or equal to 1, and greater than INPUT_DEFAULT_AXIS_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD) || (INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD < 0) || (INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD >= INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD must be a number greater than or equal to 0, and lesser than INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD) || (INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD > 1) || (INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD < INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD must be a number less than or equal to 1, and greater than INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD");
    }
    
    if (!is_bool(INPUT_SWITCH_HORIZONTAL_HOLDTYPE))
    {
        __input_error("INPUT_SWITCH_HORIZONTAL_HOLDTYPE must be either <true> or <false>");
    }
    
    #endregion
}