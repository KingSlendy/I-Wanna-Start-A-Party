if (ID != 0)
{
    if (other.lapCheckPoint == (ID - 1))
    {
        other.lapCheckPoint = ID
        other.checkX = checkX
        other.checkY = checkY
        other.checkDir = checkDir
        //with (objKartsGame)
            //event_user(5)
    }
}
else if (other.lapCheckPoint == (numCPs - 1))
{
    //with (other.id)
        //event_user(0)
    other.checkX = checkX
    other.checkY = checkY
    other.checkDir = checkDir
    //with (objKartsGame)
        //event_user(5)
}


