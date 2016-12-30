//
//  InfoController.h
//  Vakantie
//
//  Created by Rob on 5/14/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoController : UIViewController
{
	UIButton*			mBtnTerug;
	UIButton*			mBtnInfo;
	UIButton*			mBtnNoord;
	UIButton*			mBtnMidden;
	UIButton*			mBtnZuid;
	UIButton*			mBtnVlaanderen;
	UITextView*			mLabel;
}

-(void) selectOk: (id)sender;
-(void) selectInfo: (id)sender;
-(void) selectNoord: (id)sender;
-(void) selectMidden: (id)sender;
-(void) selectZuid: (id)sender;
-(void) selectVlaanderen: (id)sender;

@property (nonatomic, retain) IBOutlet UIButton*		mBtnInfo;
@property (nonatomic, retain) IBOutlet UIButton*		mBtnNoord;
@property (nonatomic, retain) IBOutlet UIButton*		mBtnMidden;
@property (nonatomic, retain) IBOutlet UIButton*		mBtnZuid;
@property (nonatomic, retain) IBOutlet UIButton*		mBtnVlaanderen;
@property (nonatomic, retain) IBOutlet UIButton*		mBtnTerug;
@property (nonatomic, retain) IBOutlet UITextView*		mLabel;

@end
