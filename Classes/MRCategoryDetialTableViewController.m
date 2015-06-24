//
//  MRCategoryDetialTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 25/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRCategoryDetialTableViewController.h"


@implementation MRCategoryDetialTableViewController

@synthesize filteredPlaques;
@synthesize categoryTitle;

- (void) viewDidLoad {
    self.title = self.categoryTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    MRPlaque *plaque = [self.filteredPlaques objectAtIndex:indexPath.row];
    cell.textLabel.text = plaque.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredPlaques count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MRPlaqueDetailTableViewController *plaqueDetailView = [[MRPlaqueDetailTableViewController alloc] initWithNibName:@"PlaqueDetailView" bundle:nil];
    // we need to set the data property of the incomming plaque details table view
    plaqueDetailView.currentPlaque = [self.filteredPlaques objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:plaqueDetailView animated:YES];
    [plaqueDetailView release];
}

@end
