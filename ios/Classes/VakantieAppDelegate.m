//
//  VakantieAppDelegate.m
//  Vakantie
//
//  Created by Rob on 5/9/10.
//  Copyright FroggySoft 2010. All rights reserved.
//

#import "VakantieAppDelegate.h"
#import "VakantieViewController.h"

@implementation VakantieAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
