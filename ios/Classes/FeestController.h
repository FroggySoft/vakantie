//
//  FeestController.h
//  Vakantie
//
//  Created by Rob on 5/14/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeestController : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate>
{
	UIButton*			mTerugButton;
	UIButton*			mInfoButton;
	UIPickerView*		mPicker;
	UILabel*			mLabel1;
	UILabel*			mLabel2;
	NSCalendar*			mGregorian;
}

-(void) showFestivities: (int) aYear;
- (int) GetDay:(NSDate*)aDate;
- (int) GetMonth:(NSDate*)aDate;
- (NSString*) GetDayMonth:(NSDate*)aDate;
- (int) GetYear:(NSDate*)aDate;
- (NSString*) GetWeekday:(NSDate*)aDate;

-(void) selectOk: (id)sender;
- (IBAction) selectInfo: (id)sender;

@property (nonatomic, retain) IBOutlet UIButton*		mTerugButton;
@property (nonatomic, retain) IBOutlet UIButton*		mInfoButton;
@property (nonatomic, retain) IBOutlet UIPickerView*	mPicker;
@property (nonatomic, retain) IBOutlet UILabel*			mLabel1;
@property (nonatomic, retain) IBOutlet UILabel*			mLabel2;

@end
