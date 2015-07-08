package hypsystem;

import android.app.Activity;
import android.content.Context;

public class HypSystem
{
	public static Context mainContext;
	public static Activity mainActivity;

	public static void setMainActivity(Activity value)
	{
		mainActivity = value;
	}

	public static void setMainContext(Context value)
	{
		mainContext = value;
	}
}
