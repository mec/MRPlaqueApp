//
//  MRFavouritePlaquesTableViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 28/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaqueAppDelegate.h"
#import "MRPlaqueData.h"
#import "MRAddFavouritePlaqueTableViewController.h"
#import "MRPlaqueTableViewController.h"



@interface MRFavouritePlaquesTableViewController : UITableViewController {

    NSMutableArray *favourtiePlaques;
    MRPlaqueAppDelegate *appDelegate;
    IBOutlet MRPlaqueData *plaqueData;

}

@property (nonatomic, retain) NSMutableArray *favourtiePlaques;

- (IBAction)edit:(id)sender;
- (IBAction)add:(id)sender;
- (void)updateFavorites;
@end
