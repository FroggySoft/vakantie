//
//  VakantieAppDelegate.h
//  Vakantie
//
//  Created by Rob on 5/9/10.
//  Copyright FroggySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VakantieViewController;

@interface VakantieAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    VakantieViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet VakantieViewController *viewController;

@end

