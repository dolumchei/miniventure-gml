function ToolItem(type, level) : Item() constructor 
{
	prandom = new Random();

	MAX_LEVEL = 5;
	LEVEL_NAMES = [ "Wood", "Rock", "Iron", "Gold", "Gem" ];

	LEVEL_COLORS = [
		Color.get(-1, 100, 321, 431),
		Color.get(-1, 100, 321, 111),
		Color.get(-1, 100, 321, 555),
		Color.get(-1, 100, 321, 550),
		Color.get(-1, 100, 321, 055)
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
		Font.draw(getName(), screen, xx + 8, yy, Color.get(-1, 555, 555, 555));
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
		if (type == ToolType.axe)
			return (level + 1) * 2 + prandom.nextInt(4);
		if (type == ToolType.sword)
			return (level + 1) * 3 + prandom.nextInt(2 + level * level * 2);

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
