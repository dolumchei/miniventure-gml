function Lantern() : Furniture("Lantern") constructor
{
	col = global.Color.get(-1, 000, 111, 555); 
	sprite = 5; 
	xr = 3; 
	yr = 2; 

	static getLightRadius = function()
	{
		return 8;
	}
}