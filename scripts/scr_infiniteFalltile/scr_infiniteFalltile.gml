function InfiniteFallTile(vid) : singleton_Tile(vid, false) constructor
{
	render = function(screen, level, xx, yy) { }	
	tick = function(level, xt, yt) { }
	mayPass = function(level, xx, yy, e)
	{
		if (is_instanceof(e, AirWizard))
			return true;
		return false;
	}
}