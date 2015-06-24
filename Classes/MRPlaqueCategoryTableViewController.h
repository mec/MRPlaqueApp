//
//  MRPlaqueCategoryTableViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 25/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaque.h"
#import "MRPlaqueData.h"
#import "MRCategoryDetialTableViewController.h"
#import "MRPlaqueAppDelegate.h"

@interface MRPlaqueCategoryTableViewController : UITableViewController {

    NSMutableSet *indexedCategories;
    NSArray *indexedCategoriesArray;
    NSMutableArray *filteredPlaques;
    MRPlaqueAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableSet *indexedCategories;
@property (nonatomic, retain) NSArray *indexedCategoriesArray;
@property (nonatomic, retain) NSMutableArray *filteredPlaques;

@end
