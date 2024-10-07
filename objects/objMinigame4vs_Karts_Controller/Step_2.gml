event_inherited();

/*if instance_exists(objPlayerKart)
{
    if keyboard_check(ord("Z"))
    {
        x = objPlayerKart.x + (lengthdir_x(followDist, objPlayerKart.direction));
        y = objPlayerKart.y + (lengthdir_y(followDist, objPlayerKart.direction));
    }
    else
    {
        x = objPlayerKart.x - (lengthdir_x(followDist, objPlayerKart.direction));
        y = objPlayerKart.y - (lengthdir_y(followDist, objPlayerKart.direction));
    }
	
    dir = point_direction(x, y, objPlayerKart.x, objPlayerKart.y);
}