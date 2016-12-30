//
//  ListController.h
//  Chemotherapie
//
//  Created by Rob on 2/4/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VakantieViewController.h"


@interface ListController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableArray		*mItems;
	UITableView			*mList;
	VakantieViewController	*mReceiver;
	int					mSelectedRow;
}

-(void) addItem: (NSString*) aItem;
-(void) setReceiver: (VakantieViewController*) aReceiver;

@property (nonatomic, retain) IBOutlet UITableView*	mList;

@end
