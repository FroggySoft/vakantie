package com.android.Vakantie;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.Window;
import android.view.ViewGroup.LayoutParams;
import android.widget.TextView;

public class DlgInfo extends Dialog
{
	private	String mInfo;

	public DlgInfo(Context context,String aString)
	{
		super(context);
		mInfo = aString;
	}

@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
	
   		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.info);
   		getWindow().setLayout(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);
   		getWindow().setBackgroundDrawable(null);

   		TextView view = (TextView)findViewById(R.id.label);
   		view.setText(mInfo);
	}
	

}
