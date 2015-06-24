//
//  MRAddFavouritePlaqueTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 26/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MRAddFavouritePlaqueTableViewController.h"


@implementation MRAddFavouritePlaqueTableViewController

- (void)viewDidLoad {

    
    appDelegate = (MRPlaqueAppDelegate *)[[UIApplication sharedApplication] delegate];
	
}

#pragma mark Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) reuseIdentifier:MyIdentifier] autorelease];
	}
    MRPlaque *plaque = [[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		
	// check the favorite status
	if (plaque.favorite == YES) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;


	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;

	}
	
    cell.textLabel.text = plaque.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 
		// we return the number of rows in a given section
        return [[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:section] count];	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSLog(@"Plaque list is being requested by %@", tableView);
	
   /* MRPlaqueDetailTableViewController *plaqueDetailView = [[MRPlaqueDetailTableViewController alloc] initWithNibName:@"PlaqueDetailView" bundle:nil];
    // check which table and set up the appropriate data

        
        // we need to set the data property of the incomming plaque details table view
        NSArray *currentPlaqueSection = [NSArray arrayWithArray:[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:indexPath.section]];
        plaqueDetailView.currentPlaque = [currentPlaqueSection objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:plaqueDetailView animated:YES];
        [plaqueDetailView release];*/
	


	// get the current plaque
	MRPlaque *plaque = [[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

	// test the current plaques favortie status
	if (plaque.favorite == YES) {
		// plaque is already a favorite make it not
		plaque.favorite =NO;
		[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

	} else {
		// plaque is not a favortie, make it one
		// set the accesory view to check mark
		[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
		// update the plaque so it is a favorite
		plaque.favorite = YES;
	}	
	// deselect the current row
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    // see if we have the search icon and respond
    if ( index == 0 ) {
        [tableView scrollRectToVisible:[[tableView tableHeaderView] bounds] animated:NO];
        return -1;
    }
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // check which table and return appropriate section titles
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        // let's see if we can put the magnifine glass in
        // make up a new array with the capacity of the old one plus 1
        NSMutableArray *modifiedSectionTitles = [NSMutableArray arrayWithArray:[[UILocalizedIndexedCollation currentCollation] sectionTitles]];
        // add the search item to the start of the new array
        [modifiedSectionTitles insertObject:UITableViewIndexSearch atIndex:0];
        
        // we return the entire section title array[
        return modifiedSectionTitles;
        [modifiedSectionTitles release];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // check which table and return approproate number of sections
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return [appDelegate.plaqueData.indexedPlaqueArray count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

		// we return the matching section title
		if ([[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:section] count] > 0) {
			return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
		}
		return nil;
}

- (void)dealloc {
    [appDelegate release];
    [super dealloc];
}
@end

