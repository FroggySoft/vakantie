//
//  FeestController.m
//  Vakantie
//
//  Created by Rob on 5/14/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import "FeestController.h"
#import "InfoController.h"

@implementation FeestController
@synthesize 	mTerugButton , mInfoButton , mPicker , mLabel1 , mLabel2;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	mPickerYears = [[NSMutableArray alloc] init];
//	for( int i=1500; i<2300; i++)
//	{
//		[mPickerYears addObject:[NSString stringWithFormat:@"%d",i]];
//	}
	
	mGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	int jaar = [self GetYear:[NSDate date]];
	[mPicker selectRow:jaar-1500 inComponent:0 animated:NO];
	[mLabel1 setText:@"Nieuwjaarsdag:\nCarnaval:\nPasen:\nHemelvaart:\nPinksteren:\nKerst:\n\n"];
	[self showFestivities:jaar];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)aView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView*)aView numberOfRowsInComponent:(NSInteger)aComponent
{
	return 2300-1500;
}

- (NSString*)pickerView:(UIPickerView*)aView titleForRow:(NSInteger)aRow
		   forComponent:(NSInteger)aComponent
{
	int jaar = aRow;
	jaar += 1500;
	return [NSString stringWithFormat:@"%4d",jaar];
}

- (void)pickerView:(UIPickerView*)aView didSelectRow:(NSInteger)aRow
			inComponent:(NSInteger)aComponent
{
	int jaar = aRow;
	jaar += 1500;
	[self showFestivities:jaar];
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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
	[mGregorian dealloc];
    [super dealloc];
}

-(void) selectOk: (id)sender
{
	[self.view removeFromSuperview];
}

- (IBAction) selectInfo: (id)sender
{
	InfoController* controller = [[InfoController alloc] 
								  initWithNibName:@"InfoController"
								  bundle:nil];
	[self.view addSubview:controller.view];	
}

-(void) showFestivities: (int) aYear
{
	long  dayInSecs = 24*3600;

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
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setYear:aYear];
	[comps setMonth:paasMaand];
	[comps setDay:paasDag];
	[comps setHour:12];
	[comps setMinute:0];
	[comps setSecond:0];
	NSDate* paasDate = [mGregorian dateFromComponents:comps];

	NSDate* carnavalDate = [[NSDate alloc ]initWithTimeInterval:-49*dayInSecs sinceDate:paasDate];	// 7 weken=49 dagen voor pasen 
	NSDate* hemelvaartDate = [[NSDate alloc ]initWithTimeInterval:39*dayInSecs sinceDate:paasDate];	// 10 dagen voor pinksteren (=39 dagen na pasen)
	NSDate* pinksterDate = [[NSDate alloc ]initWithTimeInterval:49*dayInSecs sinceDate:paasDate];	// 7 weken=49 dagen na pasen 

	[comps setMonth:1];
	[comps setDay:1];
	NSDate* nieuwjaarDate = [mGregorian dateFromComponents:comps];
	
	[comps setMonth:12];
	[comps setDay:25];											// kerst is 25 en 26 dec
	NSDate* kerstDate = [mGregorian dateFromComponents:comps];
		
	NSMutableString* str = [[NSMutableString alloc]init];
	[str appendString:[self GetWeekday:nieuwjaarDate]];
	[str appendFormat:@"\n"];

	[str appendString:[self GetDayMonth:carnavalDate]];
	[str appendString:[self GetDayMonth:paasDate]];
	[str appendString:[self GetDayMonth:hemelvaartDate]];
	[str appendString:[self GetDayMonth:pinksterDate]];
	
	[str appendString:[self GetWeekday:kerstDate]];
	[str appendFormat:@" en\n"];
	kerstDate = [kerstDate dateByAddingTimeInterval:dayInSecs];
	[str appendString:[self GetWeekday:kerstDate]];
	
	[mLabel2 setText:str];
}

- (int) GetDay:(NSDate*)aDate
{
	unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int day = [comp day];
	return day;
}
- (int) GetMonth:(NSDate*)aDate
{
	unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int month = [comp month];
	return month;
}
- (NSString*) GetDayMonth:(NSDate*)aDate
{
	unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int month = [comp month];
	int day = [comp day];
	return [NSString stringWithFormat:@"%02d-%02d\n",day,month];
}
- (int) GetYear:(NSDate*)aDate
{
	unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int year = [comp year];
	return year;
}					 
- (NSString*) GetWeekday:(NSDate*)aDate
{
	NSString* dagen[] = {@"",@"zondag",@"maandag",@"dinsdag",@"woensdag",@"donderdag",@"vrijdag",@"zaterdag"};

	unsigned flags = NSWeekdayCalendarUnit;
	NSDateComponents* comp = [mGregorian components:flags fromDate:aDate];
	int day = [comp weekday];
	if( day>0 && day<8 )
	{
		return dagen[day];
	}
	return @"";
}					 
@end
