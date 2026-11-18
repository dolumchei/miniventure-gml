var levelDebug = false;
var parameters = [ ];
for (var parameter_index = 0; parameter_index < parameter_count(); parameter_index++)
{
	parameters[parameter_index] = parameter_string(parameter_index + 1);
	if (parameters[parameter_index] == "-level_debug")
		levelDebug = true;
}

if (levelDebug)
{
	instance_destroy(obj_gameHandler);
	instance_create_depth(0, 0, 0, obj_levelGenerationDebug);
}