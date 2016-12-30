//
//  DatePicker.m
//  Chemotherapie
//
//  Created by Rob on 2/16/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import "DatePicker.h"


@implementation DatePicker
@synthesize mTerugButton, mPicker;

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
	[mPicker setDate:mDate animated:NO];
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

-(void) setDate: (NSDate*) aDate
{
	mDate = aDate;
}

-(void) setReceiver: (VakantieViewController*) aReceiver
{
	mReceiver = aReceiver;
}

-(void) selectOk: (id)sender
{
	NSDate* datum = [mPicker date];
	if( mReceiver!=nil )
	{
		[mReceiver receiveDateFromPicker:datum];
	}
	[self.view removeFromSuperview];
}

- (void)dealloc
{
	[mPicker release];
	[mTerugButton release];
    [super dealloc];
}


@end
