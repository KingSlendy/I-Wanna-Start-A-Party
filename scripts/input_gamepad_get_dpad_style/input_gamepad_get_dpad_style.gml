/// @desc    Returns the style of the given gamepad (after SDL remapping)
/// @param   gamepadIndex

function input_gamepad_get_dpad_style(_index)
{
    switch(input_gamepad_get_type(_index))
    {
        case "unknown":
            return "unknown";
        break;
        
        case "xbox 360":
        case "saturn":
            return "disc";
        break;
        
        case "psx":
        case "ps4":
        case "ps5":
            return "segments";
        break;
        
        case "switch":
            return "arrows";
        break;
        
        case "switch joycon left":
        case "switch joycon right":
            return "none";
        break;

        default:
            return "cross";
        break;
    }
}
