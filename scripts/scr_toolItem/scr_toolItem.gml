function ToolItem(type, level) : Item() constructor 
{
	prandom = new Random();

	MAX_LEVEL = 5;
	LEVEL_NAMES = [ "Wood", "Rock", "Iron", "Gold", "Gem" ];

	LEVEL_COLORS = [
		global.Color.get(-1, 100, 321, 431),
		global.Color.get(-1, 100, 321, 111),
		global.Color.get(-1, 100, 321, 555),
		global.Color.get(-1, 100, 321, 550),
		global.Color.get(-1, 100, 321, 055)
	];

	self.type = type;
	self.level = level;

	getColor = function()
	{
		return LEVEL_COLORS[level];
	}
	getColor = function()
	{
		return LEVEL_COLORS[level];
	}
	getSprite = function()
	{
		return type.sprite + 5 * 32;
	}
	renderIcon = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);
	}
	renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, getSprite(), getColor(), 0);
		global.Font.draw(getName(), screen, xx + 8, yy, global.Color.get(-1, 555, 555, 555));
	}
	getName = function()
	{
		return LEVEL_NAMES[level] + " " + type.name;
	}
	onTake = function (itemEntity) { }
	canAttack = function()
	{
		return true; 
	}
	getAttackDamageBonus = function(e)
	{
		if (type == global.ToolType.axe)
			return (level + 1) * 2 + prandom.NextInt(4);
		if (type == global.ToolType.sword)
			return (level + 1) * 3 + prandom.NextInt(2 + level * level * 2);

		return 1;
	}
	matches = function(item)
	{
		if (is_instanceof(item, ToolItem))
		{
			var vother = item;
			if (vother.type != type)
				return false;
			if (vother.level != level)
				return false;
			return true;
		}
		return false;
	}
}
