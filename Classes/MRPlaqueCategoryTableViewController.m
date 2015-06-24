//
//  MRPlaqueCategoryTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 25/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaqueCategoryTableViewController.h"


@implementation MRPlaqueCategoryTableViewController

@synthesize indexedCategories;
@synthesize indexedCategoriesArray;
@synthesize filteredPlaques;

- (void)viewDidLoad {
    appDelegate = (MRPlaqueAppDelegate *)[[UIApplication sharedApplication] delegate];

    // getting the filtered plaques array ready 
    self.filteredPlaques = [NSMutableArray arrayWithCapacity:[appDelegate.plaqueData.rawPlaqueArray count]];
    
    self.indexedCategories = [[NSMutableSet alloc] init];
    // we need to build a list of category
    NSLog(@"Set is : %@", indexedCategories);
    // enumerate the array of plaues.  Pull out the category and addd to the set
    MRPlaque *plaque;
    for ( plaque in appDelegate.plaqueData.rawPlaqueArray ) {
        [self.indexedCategories addObject:plaque.category];
        
    }
    NSLog(@"Catgories are %@", self.indexedCategories);
    // add the set to the array for use as the table data, we'll sort the items while we're at it.
    self.indexedCategoriesArray = [[NSArray arrayWithArray:[self.indexedCategories allObjects]] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    [self.indexedCategories release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.indexedCategoriesArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.indexedCategories count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // we need to get the matching plaques out of the raw plaque array
    // clear out the filtered array
    [self.filteredPlaques removeAllObjects];
    
    // find matching plaques and add to the filtered array
    for ( MRPlaque *plaque in appDelegate.plaqueData.rawPlaqueArray ) {
        
        // compare the search string to the plaque name
        NSComparisonResult result = [plaque.category compare:[self.indexedCategoriesArray objectAtIndex:indexPath.row] options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [[self.indexedCategoriesArray objectAtIndex:indexPath.row] length])];
        if (result == NSOrderedSame) {
            [self.filteredPlaques addObject:plaque];
        }
    } 
    NSLog(@"filtered plaques is %@", self.filteredPlaques);

    MRCategoryDetialTableViewController *categoryTableController = [[MRCategoryDetialTableViewController alloc] initWithNibName:@"CategoryDetailView" bundle:nil];
    // set the filtered plaques
    categoryTableController.filteredPlaques = self.filteredPlaques;
    // set the category title
    categoryTableController.categoryTitle = [indexedCategoriesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:categoryTableController animated:YES];
    NSLog(@"About to push %@", categoryTableController.filteredPlaques);
    [categoryTableController release];
}
@end
