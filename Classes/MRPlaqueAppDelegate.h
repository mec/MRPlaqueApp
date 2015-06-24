//
//  MRPlaqueAppDelegate.h
//  Untitled
//
//  Created by Meyric Rawlings on 17/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRPlaque.h"
#import "MRPlaqueData.h"

@interface MRPlaqueAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IBOutlet UITabBarController *tabBarController;
    IBOutlet MRPlaqueData *plaqueData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) MRPlaqueData *plaqueData;

@end

