function Inventory() constructor
{
	items = []; 

	add = function(a, b)
	{
		if (!is_undefined(a) && !is_undefined(b))
			return add2(a, b);
		else if (!is_undefined(a) && is_undefined(b))
			return add1(a);
	}

	add1 = function(item)
	{
		add(array_length(items), item); 
	}
	add2 = function(slot, item)
	{
		if (is_instanceof(item, ResourceItem))
		{
			var toTake = item; 
			var has = findResource(toTake.resource); 
			if (has == undefined) 
				array_insert(items, slot, toTake); 
			else
				has.count += toTake.count; 
		}
		else
			array_insert(items, slot, item); 
	}
	findResource = function(resource)
	{
		for (var i= 0; i < array_length(items); i++)
		{ 
			if (is_instanceof(items[i], ResourceItem))
			{ 
				var has = items[i]; 
				if (has.resource == resource)
					return has; 
			}
		}
		return undefined; 
	}
	hasResources = function(r, count)
	{
		var ri = findResource(r); 
		if (ri == undefined)
			return false; 
		return ri.count >= count; 
	}
	removeResource = function(r, count)
	{
		var ri = findResource(r); 
		if (ri == undefined)
			return false; 
		if (ri.count < count)
			return false; 
		ri.count -= count; 
		if (ri.count <= 0)
			array_delete_item(items, ri); 
		return true;
	}
	count = function(item)
	{
		if (is_instanceof(item, ResourceItem))
		{ 
			var ri = findResource((item).resource); 
			if (ri != undefined)
				return ri.count; 
		}
		else
		{ 
			var count = 0; 
			for (var i = 0; i < array_length(items); i++) 
			{ 
				if (items[i].matches(item))
					count++; 
			}
			return count; 
		}
		return 0;
	}
}
