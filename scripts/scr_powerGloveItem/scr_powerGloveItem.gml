function PowerGloveItem() : Item() constructor
{
	static getColor = function()
	{
		return global.Color.get(-1, 100, 320, 430);
	}
	static getSprite = function()
	{
		return 7 + 4 * 32;
	}
	static renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);
	}
	static renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);	
		global.Font.draw(getName(), screen, xx + 8, yy, global.Color.get(-1, 555, 555, 555));
	}
	static getName = function()
	{
		return "Pow glove";	
	}
	static interact = function(player, entity, attackDir)
	{
		if (is_instanceof(entity, Furniture))
		{
			var f = entity;
			f.take(player);
			return true;
		}
		return false;
	}
}