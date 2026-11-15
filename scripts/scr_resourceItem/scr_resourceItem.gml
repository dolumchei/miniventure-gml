function ResourceItem(resource, count = 1) : Item() constructor
{
	self.resource = resource;
	self.count = count;

	static getColor = function()
	{
		return resource.color;
	}
	static getSprite = function()
	{
		return resource.sprite;
	}
	static renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, resource.sprite, getColor(), 0);
	}
	static renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, resource.sprite, getColor(), 0);
		global.Font.draw(resource.name, screen, xx + 32, yy, global.Color.get(-1, 555, 555, 555));
		var cc = count;
		if (cc > 999)
			cc = 999;
		global.Font.draw(string(cc), screen, xx + 8, yy, global.Color.get(-1, 444, 444, 444));
	}
	static getName = function()
	{
		return resource.name;
	}
	static onTake = function(itemEntity) { }
	static interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		if (resource.interactOn(tile, level, xt, yt, player, attackDir))
		{
			count--;
			return true;
		}
		return false;
	}
	static isDepleted = function()
	{
		return count <= 0;
	}
}