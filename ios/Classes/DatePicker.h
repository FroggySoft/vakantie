//
//  DatePicker.h
//  Chemotherapie
//
//  Created by Rob on 2/16/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VakantieViewController.h"

@interface DatePicker : UIViewController
{
	UIButton*			mTerugButton;
	UIDatePicker*		mPicker;
	NSDate*				mDate;
	VakantieViewController*	mReceiver;
}

-(void) setDate: (NSDate*) aDate;
-(void) setReceiver: (VakantieViewController*) aReceiver;
-(void) selectOk: (id)sender;

@property (nonatomic, retain) IBOutlet UIButton*		mTerugButton;
@property (nonatomic, retain) IBOutlet UIDatePicker*	mPicker;

@end
