function Sound() constructor
{
	static playerHurt = new SoundClip(sfx_playerhurt);
	static playerDeath = new SoundClip(sfx_death);
	static monsterHurt = new SoundClip(sfx_monsterhurt);
	static test = new SoundClip(sfx_test);
	static pickup = new SoundClip(sfx_pickup);
	static bossdeath = new SoundClip(sfx_bossdeath);
	static craft = new SoundClip(sfx_craft);		
	static sounds = [ playerHurt, playerDeath, monsterHurt, test, pickup, bossdeath, craft ];
	
	static updateAll = function()
	{
		for (var soundItr = 0; soundItr < array_length(sounds); soundItr++)
			sounds[soundItr].update();
	}
}
function SoundClip(name) constructor
{
	played_recently = 0;
	clip = name;
	play = function()
	{
		if (played_recently > 0)
			return;
			
		audio_play_sound(clip, 0, false, audio_sound_get_gain(clip));
		
		played_recently = 2;
	}
	update = function()
	{
		if (played_recently > 0)
			played_recently--;
	}
}