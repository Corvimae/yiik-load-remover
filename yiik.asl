state("YIIK A Postmodern RPG") {}

startup
{
	vars.Log = (Action<object>)(output => print("[YIIK] " + output));
	vars.Helper = Assembly.Load(File.ReadAllBytes(@"Components\asl-help")).CreateInstance("Unity");
	vars.Helper.GameName = "YIIK A Postmodern RPG";

	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{
		var mbox = MessageBox.Show(
			"The YIIK: A Postmodern RPG auto-splitter uses in-game time.\nWould you like to switch to it?",
			"LiveSplit | YIIK: A Postmodern RPG",
			MessageBoxButtons.YesNo);

		if (mbox == DialogResult.Yes)
			timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
}

init
{
	current.Event = "";
	current.Scene = -1;

  current.isLoading = false;

	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
	{
		vars.Helper["scene"] = mono.MakeString("LevelStoreAndReturnClass", "currentScene");
		vars.Helper["rememberFrame"] = mono.MakeString("LevelStoreAndReturnClass", "rememberFrame");

		return true;
	});
}

update
{
  current.isLoading = vars.Helper["scene"].Current == vars.Helper["rememberFrame"].Current;

  current.Scene = vars.Helper["scene"].Current;

  vars.Log("Scene: " + current.Scene + " | " + vars.Helper["rememberFrame"].Current);
}

start
{
	return old.Scene != "BeginningOfGameQuestionnaireScene" && current.Scene == "AlexNarrations";
}

split
{
  return false;
}

reset
{
  return old.Scene != "1TitleScene" && current.Scene == "1TitleScene";
}

isLoading
{
	return current.isLoading;
}
