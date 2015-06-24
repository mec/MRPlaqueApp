//
//  MRPlaqueTableViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 20/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaqueDetailTableViewController.h"
#import "MRPlaque.h"
#import "MRPlaqueData.h"
#import "MRPlaqueAppDelegate.h"

@interface MRPlaqueTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
    
    NSMutableArray *filteredPlaques;
    MRPlaqueAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableArray *filteredPlaques;

- (void)filterContentForSearchText:(NSString*)searchText;

@end
