function InfiniteFallTile(vid) : singleton_Tile(vid, false) constructor
{
	static render = function(screen, level, xx, yy) { }	
	static tick = function(level, xt, yt) { }
	static mayPass = function(level, xx, yy, e)
	{
		if (is_instanceof(e, AirWizard))
			return true;
		return false;
	}
}