//
//  VakantieViewController.m
//  Vakantie
//
//  Created by Rob on 5/9/10.
//  Copyright FroggySoft 2010. All rights reserved.
//

#import "VakantieViewController.h"
#import "ListController.h"
#import "InfoController.h"
#import "FeestController.h"
#import "DatePicker.h"

@implementation VakantieViewController

@synthesize 	mBtnRegio , mBtnPeriode , mBtnJaar , mBtnDate;
@synthesize		mBtnFeest , mBtnInfo , mLabel1 , mLabel2;

NSString* REGIOS[] = {@"Noord",@"Midden",@"Zuid",@"Vlaanderen"};
NSString* PERIODEN[]={@"herfst",@"kerst",@"voorjaar",@"mei",@"zomer"}; 
NSString* JAREN[]  = {@"2013/2014",@"2014/2015",@"2015/2016"}; 

#define AANTAL_REGIOS		4
#define AANTAL_JAREN		3
#define AANTAL_PERIODEN		5

#define NOW_SELECTING_NOT		0
#define NOW_SELECTING_REGIO		1
#define NOW_SELECTING_PERIODE	2
#define NOW_SELECTING_JAREN		3
			
#define START_JAAR	2013
#define EIND_JAAR	2016

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	mGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	mSelecting = NOW_SELECTING_NOT;

	mRegio = 0;
	[self setButtonText:mBtnRegio   Text:REGIOS[mRegio]];
	mPeriode=0;
	[self setButtonText:mBtnPeriode Text:PERIODEN[mPeriode]];
	mJaar = 0;
	[self setButtonText:mBtnJaar    Text:JAREN[mJaar]];	
	[self toonVakantie];

	mSearchDate = [[NSDate alloc] init];
	[self receiveDateFromPicker:mSearchDate];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[mGregorian dealloc];
    [super dealloc];
}

- (IBAction) selectRegio: (id)sender
{
	ListController* controller = [[ListController alloc] 
								  initWithNibName:@"ListController"
								  bundle:nil];

	for( int i=0; i<AANTAL_REGIOS; i++)
	{
		[controller addItem:REGIOS[i] ];
	}
	
	[controller setReceiver: self];
	mSelecting = NOW_SELECTING_REGIO;
	
	[self.view addSubview:controller.view];	
}

- (IBAction) selectPeriode: (id)sender
{
	ListController* controller = [[ListController alloc] 
								  initWithNibName:@"ListController"
								  bundle:nil];
	
	for( int i=0; i<AANTAL_PERIODEN; i++)
	{
		[controller addItem:PERIODEN[i] ];
	}
	
	[controller setReceiver: self];
	mSelecting = NOW_SELECTING_PERIODE;
	
	[self.view addSubview:controller.view];	
}

- (IBAction) selectJaar: (id)sender
{
	ListController* controller = [[ListController alloc] 
					   initWithNibName:@"ListController"
					   bundle:nil];
	
	for( int i=0; i<AANTAL_JAREN; i++)
	{
		[controller addItem:JAREN[i] ];
	}
	
	[controller setReceiver: self];
	mSelecting = NOW_SELECTING_JAREN;
	
	[self.view addSubview:controller.view];	
}

- (void) makeSelection:(int)aSelection
{
	switch( mSelecting )
	{
		case NOW_SELECTING_REGIO:
			mRegio = aSelection;
			[self setButtonText:mBtnRegio Text:REGIOS[mRegio]];
			[self toonVakantie];
			break;
		case NOW_SELECTING_PERIODE:
			mPeriode = aSelection;
			[self setButtonText:mBtnPeriode Text:PERIODEN[mPeriode]];
			[self toonVakantie];
			break;
		case NOW_SELECTING_JAREN:
			mJaar = aSelection;
			[self setButtonText:mBtnJaar Text:JAREN[mJaar]];				
			[self toonVakantie];
			break;
	}
	mSelecting = NOW_SELECTING_NOT;
}

- (IBAction) selectDate: (id)sender
{
	DatePicker* controller = [[DatePicker alloc] 
								  initWithNibName:@"DatePicker"
								  bundle:nil];
	[controller setReceiver:self];
	[controller setDate:mSearchDate];
	[self.view addSubview:controller.view];		
}

- (void) receiveDateFromPicker:(NSDate*)aDate
{
	NSDateFormatter *format = [[NSDateFormatter alloc]init];
	[format setDateStyle:NSDateFormatterShortStyle];
	NSString* str = [format stringFromDate:aDate];
	[format release];
	[self setButtonText:mBtnDate Text:str];
	mSearchDate = [aDate copy];
	[self zoekVakantie:aDate];
}

- (IBAction) selectFeest: (id)sender
{
	FeestController* controller = [[FeestController alloc] 
					   initWithNibName:@"FeestController"
					   bundle:nil];
	[self.view addSubview:controller.view];	
}

- (IBAction) selectInfo: (id)sender
{
	InfoController* controller = [[InfoController alloc] 
					   initWithNibName:@"InfoController"
					   bundle:nil];
	[self.view addSubview:controller.view];	
}

- (void) setButtonText: (UIButton*) aButton
	 Text: (NSString*) aText
{
	[aButton setTitle:aText forState:UIControlStateNormal];
	[aButton setTitle:aText forState:UIControlStateSelected];
	[aButton setTitle:aText forState:UIControlStateHighlighted];		
}


// Uitleg tabel:
// Data zijn als YYYYMMDD
// dan groepjes van begin-eind datum
// vervolgens de regio's NOORD MIDDEN ZUID en Vlaanderen
// daarna perioden (herft, kerst,voorjaar, mei en zomer)
// ten slotte jaren
// Basis onderwijs
long Bo[AANTAL_JAREN][AANTAL_PERIODEN][AANTAL_REGIOS][2]=
//long[][][][] Bo= 
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


long Bouw[AANTAL_JAREN][AANTAL_REGIOS][2] = 
{
    { {20140721,20140808},{20140804,20140822},{20140728,20140815} },	// 2014
    { {20150000,20150000},{20150000,20150000},{20150000,20150000} },	// 2015
    { {20160000,20160000},{20160000,20160000},{20160000,20160000} }	// 2016
};


- (void) toonVakantie
{
	NSString* str=@"Onbekend";
		long startBo = Bo[mJaar][mPeriode][mRegio][0];
		long eindBo  = Bo[mJaar][mPeriode][mRegio][1];
		
        str = [NSString stringWithFormat:@"Basis en V.O.: %02d-%02d-%02d t/m %02d-%02d-%02d",
                            [self getDag:startBo],[self getMaand:startBo],[self getJaar:startBo]-2000,
                            [self getDag:eindBo ],[self getMaand:eindBo ],[self getJaar:eindBo ]-2000 ];

        if( 4==mPeriode && mRegio<(AANTAL_REGIOS-1))		// add bouwvak for summer holiday, not in Vlaanderen
		{
            if( mJaar==0 )
            {
                long start = Bouw[mJaar][mRegio][0];
                long eind  = Bouw[mJaar][mRegio][1];
                str = [str stringByAppendingFormat:@"\nBouw: %02d-%02d-%02d t/m %02d-%02d-%02d",
                                     [self getDag:start],[self getMaand:start],[self getJaar:start]-2000,
                                     [self getDag:eind ],[self getMaand:eind ],[self getJaar:eind ]-2000 ];
            }
            else
            {
                str = [str stringByAppendingString:@"\nBouw: periode is nog onbekend."];
            }

		}
	
		[mLabel1 setText:str];
}

- (int) getJaar:(int) aCode
{
	int jaar = (int)aCode/10000;
	return jaar;
}
- (int) getMaand:(int) aCode
{
	int maand = (int)aCode/100;
	return (maand%100);
}
- (int) getDag:(int) aCode
{
	return (int)(aCode%100);
}

- (void) zoekVakantie:(NSDate*) aDate
{
	unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int aJaar = [comp year];
	int aMaand= [comp month];
	int aDag  = [comp day];

	NSString* str = @"";

	if( aJaar<START_JAAR ||
	   ( aJaar==START_JAAR && aMaand<9 ) ||
	   aJaar>EIND_JAAR ||
	   ( aJaar==EIND_JAAR && aMaand>8 ) )
	{
		str = @"Deze datum valt buiten de bekende periode.";
	}
	else
	{
		long datum = aJaar;
		datum *= 100;
		datum += aMaand;
		datum *= 100;
		datum += aDag;
		
		int nrOfRegios =0 ;
		str = @"regio ";
		
		for(int jaar=0; jaar<AANTAL_JAREN && nrOfRegios==0 ; jaar++ )
		{
			for(int periode=0; periode<AANTAL_PERIODEN && nrOfRegios==0; periode++)
			{
				nrOfRegios = 0;
				for(int regio=0; regio<AANTAL_REGIOS; regio++)
				{
					long startBo = Bo[jaar][periode][regio][0];
					long eindBo  = Bo[jaar][periode][regio][1];
					if( datum>=startBo && datum<=eindBo )
					{
						if( 0!=nrOfRegios )
						{
							str = [str stringByAppendingString:@"& "];
						}
						str = [str stringByAppendingString:REGIOS[regio]];
						str = [str stringByAppendingString:@" "];
						nrOfRegios++;
					}
				}
				if( nrOfRegios>1 )
					str = [str stringByAppendingString:@"hebben " ];
				else if( 1==nrOfRegios )
					str = [str stringByAppendingString:@"heeft " ];
				if( 0!=nrOfRegios )
					str = [str stringByAppendingString:PERIODEN[periode]];
			}
		}
		if( 0==nrOfRegios )
		{
			str = @"In deze periode is geen";
		}
		str = [str stringByAppendingString:@" vakantie"];
	}
	
	[mLabel2 setText:str];
}

@end
