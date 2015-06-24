//
//  MRPlaqueAppDelegate.m
//  Untitled
//
//  Created by Meyric Rawlings on 17/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaqueAppDelegate.h"

@implementation MRPlaqueAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize plaqueData;

- (void)applicationDidFinishLaunching:(UIApplication *)application { 

    // Override point for customization after application launch
    [window makeKeyAndVisible];
    // add the tab bar to the window
    [window addSubview:tabBarController.view]; 
	

}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"app is terminating");
	[plaqueData saveUserData];
}
- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
