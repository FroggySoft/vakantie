//
//  VakantieViewController.h
//  Vakantie
//
//  Created by Rob on 5/9/10.
//  Copyright FroggySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VakantieViewController : UIViewController
{
	UIButton*	mBtnRegio;
	UIButton*	mBtnPeriode;
	UIButton*	mBtnJaar;
	UIButton*	mBtnDate;
	UIButton*	mBtnFeest;
	UIButton*	mBtnInfo;
	
	UILabel*	mLabel1;
	UILabel*	mLabel2;
	
	int			mRegio , mPeriode , mJaar;
	int			mSelecting;
	NSCalendar*	mGregorian;
	NSDate*		mSearchDate;
}

- (void) toonVakantie;
- (int) getJaar:(int) aCode;
- (int) getMaand:(int) aCode;
- (int) getDag:(int) aCode;
- (void) zoekVakantie:(NSDate*) aDate;

@property (nonatomic, retain) IBOutlet UIButton *mBtnRegio;
@property (nonatomic, retain) IBOutlet UIButton *mBtnPeriode;
@property (nonatomic, retain) IBOutlet UIButton *mBtnJaar;
@property (nonatomic, retain) IBOutlet UIButton *mBtnDate;
@property (nonatomic, retain) IBOutlet UIButton *mBtnFeest;
@property (nonatomic, retain) IBOutlet UIButton *mBtnInfo;
@property (nonatomic, retain) IBOutlet UILabel  *mLabel1;
@property (nonatomic, retain) IBOutlet UILabel  *mLabel2;

- (IBAction) selectRegio: (id)sender;
- (IBAction) selectPeriode: (id)sender;
- (IBAction) selectJaar: (id)sender;
- (IBAction) selectDate: (id)sender;
- (IBAction) selectFeest: (id)sender;
- (IBAction) selectInfo: (id)sender;

- (void) receiveDateFromPicker:(NSDate*)aDate;
- (void) makeSelection:(int)aSelection;
- (void) setButtonText: (UIButton*) aButton
				  Text: (NSString*) aText;

@end

