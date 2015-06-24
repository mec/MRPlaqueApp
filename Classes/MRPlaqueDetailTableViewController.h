//
//  MRPlaqueDetailTableViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 19/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaque.h"
#import "MRWikipediaViewController.h"
#import "MRPlaqueAppDelegate.h"
#import "MRModalMapViewContoller.h"


@interface MRPlaqueDetailTableViewController : UITableViewController {

    MRPlaque *currentPlaque;
	UIButton *favoriteButton;
}

@property (nonatomic, retain) MRPlaque *currentPlaque;

@end
