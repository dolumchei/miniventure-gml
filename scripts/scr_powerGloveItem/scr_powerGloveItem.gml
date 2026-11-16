function PowerGloveItem() : Item() constructor
{
	getColor = function()
	{
		return Color.get(-1, 100, 320, 430);
	}
	getSprite = function()
	{
		return 7 + 4 * 32;
	}
	renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);
	}
	renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);	
		Font.draw(getName(), screen, xx + 8, yy, Color.get(-1, 555, 555, 555));
	}
	getName = function()
	{
		return "Pow glove";	
	}
	interact = function(player, entity, attackDir)
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