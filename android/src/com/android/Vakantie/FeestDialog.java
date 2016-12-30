package com.android.Vakantie;

import java.sql.Date;
import java.util.Calendar;

import android.app.Dialog;
import android.content.Context;
import android.text.Editable;
import android.view.KeyEvent;
import android.view.Window;
import android.widget.EditText;
import android.widget.TextView;

public class FeestDialog extends Dialog 
{
	private int		mYear ;
	public FeestDialog(Context context,int aYear)
	{
		super(context);
		
		mYear = aYear;
		String str = String.format("%4d",mYear);
		
   		requestWindowFeature(Window.FEATURE_NO_TITLE);
   		setContentView(R.layout.feestdialog);
   			
   		EditText edit = (EditText)findViewById(R.id.EditJaar);
   		edit.setText(str);
   		edit.setOnEditorActionListener (new YearChangedListener() ); 
   		
   		showScreen(mYear);
	}
	
	private class YearChangedListener implements TextView.OnEditorActionListener
	{
		@Override
		public boolean onEditorAction(TextView v, int actionId, KeyEvent event)
		{
	   		EditText edit = (EditText)v;
	   		Editable str = edit.getText();
	   		if( str.length()==4 )
	   		{
	   			mYear = new Integer( str.toString() ).intValue();
	   			showScreen(mYear);
	   		}
			return false;
		}	
	}
	
	private void showScreen(int aYear)
	{
		long  dayInMilSecs = 24*3600*1000;
		// calculate easter:
		int a = aYear % 19;
		int b = aYear / 100;
		int c = aYear % 100;
		int d = b/4;
		int e = b%4;
		int g = (8*b+13)/25;
		int x = (11*(b-d-g)-4)/30;
		int y = (7*a+x+6)/11;
		int z = (19*a + (b-d-g)+15-y)%29;
		int	i = c/4;
		int k = c%4;
		int l = ((32+2*e)+2*i-k-z)%7;
		int paasMaand = (90+z+l)/25;
		int paasDag   = (19+z+l+paasMaand)%32;

		final Calendar calendar = Calendar.getInstance();  
		calendar.set(Calendar.HOUR_OF_DAY,10);
		calendar.set(Calendar.MINUTE,0);
		calendar.set(Calendar.SECOND,0);
		calendar.set(Calendar.MILLISECOND,0);
		calendar.set(Calendar.YEAR,aYear);
		calendar.set(Calendar.MONTH,paasMaand-1);				// january = 0 
		calendar.set(Calendar.DATE,paasDag);

		java.util.Date paasDate  = calendar.getTime();
		long paasTime 		= paasDate.getTime();
		long carnavalTime 	= paasTime - 49*dayInMilSecs;   		// 7 weken=49 dagen voor pasen 
		long hemelvaartTime = paasTime + 39*dayInMilSecs;		// 10 dagen voor pinksteren (=39 dagen na pasen)
		long pinksterTime   = paasTime + 49*dayInMilSecs;		// 7 weken=49 dagen na pasen
		Date carnavalDate 	= new Date(carnavalTime);
		Date hemelvaartDate = new Date(hemelvaartTime);
		Date pinksterDate   = new Date(pinksterTime);

		calendar.setTime(carnavalDate);
		int carnavalMaand = calendar.get(Calendar.MONTH)+1;
		int carnavalDag = 	calendar.get(Calendar.DATE);
		calendar.setTime(hemelvaartDate);
		int hemelvaartMaand = calendar.get(Calendar.MONTH)+1;
		int hemelvaartDag =   calendar.get(Calendar.DATE);
		calendar.setTime(pinksterDate);
		int pinksterMaand = calendar.get(Calendar.MONTH)+1;
		int pinksterDag = 	calendar.get(Calendar.DATE);

		calendar.set(Calendar.MONTH,Calendar.JANUARY);
		calendar.set(Calendar.DATE,1);
		int nieuwDag = calendar.get(Calendar.DAY_OF_WEEK); 			// sunday=1

		calendar.set(Calendar.MONTH,Calendar.DECEMBER);				// kerst is 25 en 26 dec
		calendar.set(Calendar.DATE,25);
		int kerstDag = calendar.get(Calendar.DAY_OF_WEEK); 			// sunday=1
		String dagen[] = {"","zondag","maandag","dinsdag","woensdag","donderdag","vrijdag","zaterdag","zondag"};

		String str = dagen[nieuwDag] + "\n";
		str += carnavalDag + "-" + carnavalMaand + "\n";
		str += paasDag + "-" + paasMaand + "\n";
		str += hemelvaartDag + "-" + hemelvaartMaand + "\n";
		str += pinksterDag + "-" + pinksterMaand + "\n";
		str += dagen[kerstDag] + " en " + dagen[kerstDag+1] + "\n";

		TextView view = (TextView)findViewById(R.id.TextView01);
		view.setText(str);
	}

}
