function Recipe(aresultTemplate) : ListItem() constructor
{
	var res = aresultTemplate;
	if (is_array(aresultTemplate))
	{
		var t = aresultTemplate[0];
		if (t == "ResourceItem")
			res = new ResourceItem(aresultTemplate[1], aresultTemplate[2]);
		if (t == "FurnitureItem")
			res = new FurnitureItem(new aresultTemplate[1]());
		if (t == "ToolItem")
			res = new ToolItem(aresultTemplate[1], aresultTemplate[2]);
	}
	
	costs = [ ];
	canCraft = false; 
	self.resultTemplate = res; 

	addCost = function(resource, count)
	{
		array_push(costs, new ResourceItem(resource, count)); 
		return self;
	}
	checkCanCraft = function(player)
	{
		for (var i = 0; i < array_length(costs); i++)
		{ 
			var item = costs[i]; 
			if (is_instanceof(item, ResourceItem))
			{ 
				var ri = item; 
				if (!player.inventory.hasResources(ri.resource, ri.count))
				{
					canCraft = false;
					return;
				}
			}
		}
		canCraft = true;
	}
	renderInventory = function(screen, xx, yy)
	{
		screen.render(xx, yy, resultTemplate.getSprite(), resultTemplate.getColor(), 0); 
		var textColor = canCraft ? Color.get(-1, 555, 555, 555) : Color.get(-1, 222, 222, 222); 
		Font.draw(resultTemplate.getName(), screen, xx + 8, yy, textColor); 
	}
	craft = function(player) { }
	deductCost = function(player)
	{
		for (var i = 0; i < array_length(costs); i++)
		{
			var item = costs[i];
			if (is_instanceof(item, ResourceItem))
			{
				var ri = item; 
				player.inventory.removeResource(ri.resource, ri.count); 
			}
		}
	}
}