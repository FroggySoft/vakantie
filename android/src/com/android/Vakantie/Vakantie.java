package com.android.Vakantie;

import java.util.Calendar;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.TextView;

public class Vakantie extends Activity
{
	private int mRegio = 0 ;
	private int mPeriode = 0 ;
	private int mJaar = 0 ;
	private int mSelectedJaar,mSelectedMaand,mSelectedDag;

	private final String[] REGIOS = {"Noord","Midden","Zuid","Vlaanderen"};
	private final String[] PERIODEN={ "herfst","kerst","voorjaar","mei","zomer"}; 
	private final String[] JAREN  = { "2013/2014","2014/2015","2015/2016"}; 

	private final int	START_JAAR = 2013;
	private final int 	EIND_JAAR  = 2016;

    private final int MENU_GROUP_ID=0;
    private final int MENU_ID_INFO=0;
    private final int MENU_ID_REGIO=1;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        SharedPreferences settings = getSharedPreferences("Vakantie", 0);
        mRegio = settings.getInt("Regio",0);
        mPeriode= settings.getInt("Periode",0);
        mJaar = settings.getInt("Jaar",0);
        
        final Calendar c = Calendar.getInstance();  
        int year = c.get(Calendar.YEAR);  
        int month = c.get(Calendar.MONTH);  
        int day = c.get(Calendar.DAY_OF_MONTH);  

    	mSelectedJaar = settings.getInt("SelJaar",year);
    	mSelectedMaand = settings.getInt("SelMaand",month);
    	mSelectedDag = settings.getInt("SelDag",day);

		Button btn = (Button)findViewById(R.id.BtnRegio);
		btn.setOnClickListener( new RegioButtonListener() );
		btn.setText(REGIOS[mRegio]);
		
		btn = (Button)findViewById(R.id.BtnPeriode);
		btn.setOnClickListener( new PeriodeButtonListener() );
		btn.setText(PERIODEN[mPeriode]);
		
		btn = (Button)findViewById(R.id.BtnJaar);
		btn.setOnClickListener( new JaarButtonListener() );
		btn.setText(JAREN[mJaar]);
		
		btn = (Button)findViewById(R.id.BtnDate);
		btn.setOnClickListener(new DateButtonListener () );

		btn = (Button)findViewById(R.id.BtnFeest);
		btn.setOnClickListener( new FeestButtonListener() );

		toonVakantie();
		setButtondatum();
		zoekVakantie(mSelectedJaar,mSelectedMaand,mSelectedDag);
    }
    
    @Override    
    protected void onStop()
    {
    	super.onStop();          
    	// Save user preferences. We need an Editor object to      
    	// make changes. All objects are from android.context.Context      
    	SharedPreferences settings = getSharedPreferences("Vakantie", 0);      
    	SharedPreferences.Editor editor = settings.edit();      
    	editor.putInt("Regio",mRegio);
    	editor.putInt("Periode",mPeriode);
    	editor.putInt("Jaar",mJaar);
    	// Don't forget to commit your edits!!!      
    	editor.commit();    
    }

    public boolean onCreateOptionsMenu(Menu menu)
    {
	    super.onCreateOptionsMenu(menu);

	    menu.add(MENU_GROUP_ID, MENU_ID_INFO, 0, "Info");
	    menu.add(MENU_GROUP_ID, MENU_ID_REGIO, 0, "Regioindeling");
	    return true;
    } 

    public boolean onOptionsItemSelected(MenuItem item)
    {
    	String str="";
    	Resources resources = this.getResources();
    	switch (item.getItemId())
    	{
			case MENU_ID_INFO:	
				str = resources.getString(R.string.Info);
				break;
			case MENU_ID_REGIO:	
				str = resources.getString(R.string.RegioNoord);
				str += "\n\n" + resources.getString(R.string.RegioMidden);
				str += "\n\n" + resources.getString(R.string.RegioZuid);
				str += "\n\n" + resources.getString(R.string.RegioVlaanderen);
				break;
    	}
    	if( str.length()>0 )
    	{
			DlgInfo dlg = new DlgInfo(this,str);
			dlg.show();
    		return true;
    	}
    	return false;
    }

    private class RegioButtonListener implements View.OnClickListener
    {
		@Override
		public void onClick(View v)
		{
        	ListDialog dlg = new ListDialog(Vakantie.this,new OnRegioReadyListener() );
        	dlg.setTitle("Regio:");
        	for( int i=0; i<REGIOS.length; i++)
        	{
        		dlg.addItem(REGIOS[i]);
        	}
    		dlg.show();
    	}
    }
    private class OnRegioReadyListener implements ListDialog.ReadyListener
    { 
        @Override 
        public void ready(int aSelection)
        {
        	mRegio = aSelection;
       		Button button  = (Button )findViewById(R.id.BtnRegio);
       		button.setText(REGIOS[mRegio]);
    		toonVakantie();
        }
   } 

    private class PeriodeButtonListener implements View.OnClickListener
    {
		@Override
		public void onClick(View v)
		{
        	ListDialog dlg = new ListDialog(Vakantie.this,new OnPeriodeReadyListener() );
        	dlg.setTitle("Periode:");
        	for( int i=0; i<PERIODEN.length; i++)
        	{
        		dlg.addItem(PERIODEN[i]);
        	}
    		dlg.show();
		}
    	
    }
    private class OnPeriodeReadyListener implements ListDialog.ReadyListener
    { 
        @Override 
        public void ready(int aSelection)
        {
        	mPeriode = aSelection;
       		Button button  = (Button )findViewById(R.id.BtnPeriode);
       		button.setText(PERIODEN[mPeriode]);
    		toonVakantie();
        }
    } 

    private class JaarButtonListener implements View.OnClickListener
    {
		@Override
		public void onClick(View v)
		{
        	ListDialog dlg = new ListDialog(Vakantie.this,new OnJarenReadyListener() );
        	dlg.setTitle("Schooljaar:");
        	for( int i=0; i<JAREN.length; i++)
        	{
        		dlg.addItem(JAREN[i]);
        	}
    		dlg.show();
		}
    }
    private class OnJarenReadyListener implements ListDialog.ReadyListener
    { 
        @Override 
        public void ready(int aSelection)
        {
        	mJaar = aSelection;
       		Button button  = (Button )findViewById(R.id.BtnJaar);
       		button.setText(JAREN[mJaar]);
    		toonVakantie();
        }
   } 
    
    private class DateButtonListener implements View.OnClickListener
    {
		@Override
		public void onClick(View v)
		{
			DatePickerDialog dlg = new DatePickerDialog(Vakantie.this,new DateEnteredListener(), mSelectedJaar,mSelectedMaand,mSelectedDag);
			dlg.show();
		}   	
    }

    private class FeestButtonListener implements View.OnClickListener
    {
		@Override
		public void onClick(View v)
		{
			FeestDialog dlg = new FeestDialog(Vakantie.this,mSelectedJaar);
			dlg.show();
		}   	
    }

    private class DateEnteredListener implements DatePickerDialog.OnDateSetListener
    {
		public void onDateSet(DatePicker view, int aYear, int aMonth,int aDay)
		{
			mSelectedJaar = aYear;
			mSelectedMaand= aMonth;
			mSelectedDag  = aDay;
			setButtondatum();
			zoekVakantie(mSelectedJaar,mSelectedMaand,mSelectedDag);
		}    	
    }

    private void setButtondatum()
    {
		String str;
		str = String.format("%02d-%02d-%4d",mSelectedDag,mSelectedMaand+1,mSelectedJaar);
		Button btn = (Button)findViewById(R.id.BtnDate);
		if( null!=btn )
		{
			btn.setText(str);
		}    	
    }
	 // Uitleg tabel:
	 // Data zijn als YYYYMMDD
	 // dan groepjes van begin-eind datum
	 // vervolgens de regio's NOORD MIDDEN ZUID en Vlaanderen
	 // daarna perioden (herft, kerst,voorjaar, mei en zomer)
	 // ten slotte jaren
	 // Basis onderwijs
    // [AANTAL_JAREN][AANTAL_PERIODEN][AANTAL_REGIOS][2]
    private final long[][][][] Bo= 
 	{ 
        //    NOORD              MIDDEN              ZUID               BELGIE
       	// 2013 - 2014
 	  {	{ {20131019,20131027},{20131019,20131027},{20131012,20131020},{20131028,20131103} },		// Herfst
 		{ {20131221,20140105},{20131221,20140105},{20131221,20140105},{20131223,20140105} },		// Kerst
 		{ {20140222,20140302},{20140215,20140223},{20140215,20140223},{20140303,20140309} },		// Voorjaar
 		{ {20140426,20140504},{20140426,20140504},{20140426,20140504},{20140407,20140421} },		// Mei
 		{ {20140705,20140817},{20140719,20140831},{20140712,20140824},{20140701,20140831} } },		// Zomer bo

       	// 2014 - 2015
 	  {	{ {20141011,20141019},{20141018,20141026},{20141018,20141026},{20141027,20141102} },		// Herfst
 		{ {20141220,20150104},{20141220,20150104},{20141220,20150104},{20141222,20150104} },		// Kerst
 		{ {20150221,20150301},{20150221,20150301},{20150214,20150222},{20150216,20150222} },		// Voorjaar
 		{ {20150502,20150510},{20150502,20150510},{20150502,20150510},{20150406,20150419} },		// Mei
 		{ {20150704,20150816},{20150711,20150823},{20150718,20150830},{20150701,20150831} } },		// Zomer bo
 		
       	// 2015 - 2016
 	  {	{ {20151017,20151025},{20151017,20151025},{20151024,20151101},{20151102,20151108} },		// Herfst
 		{ {20151219,20160103},{20151219,20160103},{20151219,20160103},{20151221,20160103} },		// Kerst
 		{ {20160227,20160306},{20160220,20160228},{20160220,20160228},{20160208,20160214} },		// Voorjaar
 		{ {20160430,20160508},{20160430,20160508},{20160430,20160508},{20160328,20160410} },		// Mei
 		{ {20160716,20160828},{20160709,20160821},{20160723,20160904},{20160701,20160831} } }		// Zomer bo


 	};


    //UInt16 Bouw[AANTAL_JAREN][AANTAL_REGIOS][2] = 
    private final long[][][] Bouw = 
 	{
 	  { {20140721,20140808},{20140804,20140822},{20140728,20140815} },	// 2014
 	  { {20150000,20150000},{20150000,20150000},{20150000,20150000} },	// 2015
 	  { {20160000,20160000},{20160000,20160000},{20160000,20160000} }	// 2016
 	};

    private void toonVakantie()
    {
		String str="Onbekend";
		try
		{
			long startBo = Bo[mJaar][mPeriode][mRegio][0];
			long eindBo  = Bo[mJaar][mPeriode][mRegio][1];

			str = String.format("Basis en V.O.: %02d-%02d-%02d t/m %02d-%02d-%02d",
						  getDag(startBo),getMaand(startBo),getJaar(startBo)-2000,
						  getDag(eindBo),getMaand(eindBo),getJaar(eindBo)-2000 );

			if( 4==mPeriode && mRegio<3 )	// only display when summerholiday selected, not in vlaanderen
			{
				if( mJaar==0 )
				{
					startBo = Bouw[mJaar][mRegio][0];
					eindBo  = Bouw[mJaar][mRegio][1];
					str += String.format("\nBouw: %02d-%02d-%02d t/m %02d-%02d-%02d",
									  getDag(startBo),getMaand(startBo),getJaar(startBo)-2000,
									  getDag(eindBo),getMaand(eindBo),getJaar(eindBo)-2000 );
				}
				else
				{
					str += "\nBouw: periode is nog onbekend.";
				}
			}
		}
		catch( Exception ex)
		{
			;
		}
		

    	TextView view = (TextView)findViewById(R.id.Result1View);
    	view.setText(str);
    }

    private int getJaar(long aCode)
    {
    	int jaar = (int)aCode/10000;
    	return jaar;
    }
    private int getMaand(long aCode)
    {
    	int maand = (int)aCode/100;
    	return (maand%100);
    }
    private int getDag(long aCode)
    {
    	return (int)(aCode%100);
    }

    private void zoekVakantie(int aJaar, int aMaand,int aDag)
    {
    	String str="";
    	
    	if( aJaar<START_JAAR ||
    		( aJaar==START_JAAR && aMaand<9 ) ||
    	    aJaar>EIND_JAAR ||
    	    ( aJaar==EIND_JAAR && aMaand>8 ) )
    	{
    	 	str = "Deze datum valt buiten de bekende periode.";
    	}
    	else
    	{
    		long datum = aJaar;
    		datum *= 100;
    		datum += (aMaand+1);
    		datum *= 100;
    		datum += aDag;

    		int nrOfRegios =0 ;
    		str = "regio ";

    		for(int jaar=0; jaar<JAREN.length && nrOfRegios==0 ; jaar++ )
    		{
    			for(int periode=0; periode<PERIODEN.length && nrOfRegios==0; periode++)
    			{
    				nrOfRegios = 0;
    				for(int regio=0; regio<REGIOS.length; regio++)
    				{
    					long startBo = Bo[jaar][periode][regio][0];
    					long eindBo  = Bo[jaar][periode][regio][1];
    					if( datum>=startBo && datum<=eindBo )
    					{
    						if( 0!=nrOfRegios )
    						{
    							str += "& ";
    						}
    						str += REGIOS[regio] + " ";
    						nrOfRegios++;
    					}
    				}
					if( nrOfRegios>1 )
						str += "hebben ";
					else if( 1==nrOfRegios )
						str += "heeft ";
					if( 0!=nrOfRegios )
						str += PERIODEN[periode];
    			}
    		}
    		if( 0==nrOfRegios )
    		{
    			str = "In deze periode is geen";
    		}
    		str += " vakantie";
    	}

    	TextView view = (TextView)findViewById(R.id.Result2View);
    	view.setText(str);
    }
 
    
}