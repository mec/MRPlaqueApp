//
//  MRCategoryDetialTableViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 25/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaque.h"
#import "MRPlaqueData.h"
#import "MRPlaqueDetailTableViewController.h"


@interface MRCategoryDetialTableViewController : UITableViewController {

    NSArray *filteredPlaques;
    NSString *categoryTitle;
}

@property (nonatomic, retain) NSArray *filteredPlaques;
@property (nonatomic, retain) NSString *categoryTitle;
@end
