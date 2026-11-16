function ResourceItem(resource, count = 1) : Item() constructor
{
	self.resource = resource;
	self.count = count;

	getColor = function()
	{
		return resource.color;
	}
	getSprite = function()
	{
		return resource.sprite;
	}
	renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, resource.sprite, getColor(), 0);
	}
	renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, resource.sprite, getColor(), 0);
		global.Font.draw(resource.name, screen, xx + 32, yy, global.Color.get(-1, 555, 555, 555));
		var cc = count;
		if (cc > 999)
			cc = 999;
		global.Font.draw(string(cc), screen, xx + 8, yy, global.Color.get(-1, 444, 444, 444));
	}
	getName = function()
	{
		return resource.name;
	}
	onTake = function(itemEntity) { }
	interactOn = function(tile, level, xt, yt, player, attackDir)
	{
		if (resource.interactOn(tile, level, xt, yt, player, attackDir))
		{
			count--;
			return true;
		}
		return false;
	}
	isDepleted = function()
	{
		return count <= 0;
	}
}