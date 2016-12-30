package com.android.Vakantie;

import android.app.Dialog;
import android.content.Context;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.AdapterView.OnItemClickListener;

public class ListDialog extends Dialog 
{
	private ListView mList;
	private int		 mIndex=-1;
	private ArrayAdapter<String> adapter;

	private ReadyListener readyListener;
	
	public interface ReadyListener
	{
        public void ready(int aSelection);
    } 

	public ListDialog(Context context,ReadyListener aReadyListener)
	{
		super(context);
		readyListener = aReadyListener;
		
   		//requestWindowFeature(Window.FEATURE_NO_TITLE);
   		setContentView(R.layout.listdialog);

   		mList = (ListView)findViewById(R.id.ListView01);
   		adapter = new ArrayAdapter<String>(mList.getContext(), R.layout.list ,R.id.label);

   		mList.setAdapter( adapter );
   		mList.setOnItemClickListener( new Selector() );
	}
	
	public void addItem(String aItem)
	{
		adapter.add(aItem);
	}
	
	public int getSelection()
	{
		return mIndex;
	}
    private class Selector implements OnItemClickListener
    {
		public void onItemClick(AdapterView<?> aParent, View v, int position,long id)
		{
			ListDialog.this.dismiss(); 
			readyListener.ready(position);
		}
    }

}
