function string_save(str, fname)
{
	var buffer = buffer_create(string_byte_length(str), buffer_fixed, 1);
	buffer_write(buffer, buffer_text, str);
	buffer_save(buffer, fname);
	buffer_delete(buffer);
}
function string_load(fname)
{
	if (!file_exists(fname))
		return;

	var buffer = buffer_load(fname);
	var file_content = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);

	return file_content;
}

function keyboard_check_combo(master_key, sub_key)
{
	if (!is_array(master_key))
		master_key = [ master_key ];
	if (!is_array(sub_key))
		sub_key = [ sub_key ];
		
	if (!window_has_focus())
		return false;
		
	for (var i = 0; i < array_length(master_key); i++)
	{
		var master_keycode = master_key[i];
		if (is_string(master_keycode))
			master_keycode = ord(master_keycode);
		
		if (keyboard_check_direct(master_keycode))
		{
			for (var j = 0; j < array_length(sub_key); j++)
			{
				var sub_keycode = sub_key[j];
				if (is_string(sub_keycode))
					sub_keycode = ord(sub_keycode);
					
				if (keyboard_check_pressed(sub_keycode))
					return true;	
			}
			
			return false;
		}
		else
			return false;
	}
	
	return false;
}

function array_new_2d(width, height, value = undefined)
{
	var data =
	{
		height,
		value,
	};

	var func = function() { return array_create(height, value); };

	return array_create_ext(width, method(data, func));
}
function array_indexof(array, value)
{
	for (var i = 0; i < array_length(array); i++)
	{
		if (array[i] == value)
			return i;
	}

	return -1;
}
function array_delete_item(array, value)
{
	array_delete(array, array_indexof(array, value), 1);
}
function array_push_array(array1, array2)
{
	for (var i = 0; i < array_length(array2); i++)
		array_push(array1, array2[i]);
}
function array_removeall(array1, array2)
{
    var result = [];

    for (var i = 0; i < array_length(array1); i++)
    {
        var remove = false;

        for (var j = 0; j < array_length(array2); j++)
        {
            if (array1[i] == array2[j])
            {
                remove = true;
                break;
            }
        }

        if (!remove)
            array_push(result, array1[i]);
    }

    return result;
}

function draw_get_align() 
{
	return
	{
		halign: draw_get_halign(),
		valign: draw_get_valign(),
	};
}
function draw_set_align(halign = fa_left, valign = fa_top)
{
	if (is_struct(halign))
	{
		draw_set_halign(halign.halign);
		draw_set_valign(halign.valign);

		return;
	}

	draw_set_halign(halign);
	draw_set_valign(valign);
}
function draw_reset()
{
	gpu_set_blendmode(bm_normal);

	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_default);
	draw_set_align();
}

function print(str)
{
	var output_message = "";

	for (var i = 0; i < argument_count; i++)
	{
		var argument_message = string(argument[i]);
	
		output_message += argument_message;
		if (argument_count > 1 && i < argument_count - 1)
			output_message += " ";
	}

	show_debug_message(output_message);
	return output_message;
}