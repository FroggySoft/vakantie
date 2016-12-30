//
//  ListController.m
//  Chemotherapie
//
//  Created by Rob on 2/4/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import "ListController.h"
#import "VakantieViewController.h"

@implementation ListController
@synthesize mList;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		mReceiver = nil;
		mItems = [[NSMutableArray alloc]init];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    mList.layer.borderWidth=2;
    mList.layer.borderColor=[UIColor blackColor].CGColor;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)tableView: (UITableView*)aTableView numberOfRowsInSection: (NSInteger) section
{
	return [mItems count];
}

- (UITableViewCell*)tableView: (UITableView*)aTableView cellForRowAtIndexPath:(NSIndexPath*)aIndexPath
{
	static NSString* identifier = @"inditifier";
	
	UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:identifier];
	if( nil==cell )
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:identifier] autorelease];
	}
	int row = aIndexPath.row;
	cell.textLabel.text=[mItems objectAtIndex:row];
	
	return cell;
}

- (void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath*) aIndexPath
{
	if( mReceiver!=nil )
	{
		[mReceiver makeSelection:aIndexPath.row];
	}
	[self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void) setReceiver: (VakantieViewController*) aReceiver
{
	mReceiver = aReceiver;
}

- (void)addItem: (NSString*) aItem
{
	[mItems addObject:aItem];
}
	 
- (void)dealloc
{
	[mItems dealloc];
    [super dealloc];
}

@end
