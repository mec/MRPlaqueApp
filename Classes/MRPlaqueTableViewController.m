//
//  MRPlaqueTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 20/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaqueTableViewController.h"


@implementation MRPlaqueTableViewController

@synthesize filteredPlaques;

- (void)viewDidLoad {
    // create an array to hold the search results
    self.filteredPlaques = [NSMutableArray arrayWithCapacity:[appDelegate.plaqueData.rawPlaqueArray count]];
    
    appDelegate = (MRPlaqueAppDelegate *)[[UIApplication sharedApplication] delegate];

    }

#pragma mark Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) reuseIdentifier:MyIdentifier] autorelease];
	}
    MRPlaque *plaque;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //filtered table data
        plaque = [filteredPlaques objectAtIndex:indexPath.row];

    } else {
        // normal table data
        plaque = [[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    }

    cell.textLabel.text = plaque.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredPlaques count];
    } else {
        // we return the number of rows in a given section
        return [[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:section] count];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSLog(@"Plaque list is being requested by %@", tableView);
	
    MRPlaqueDetailTableViewController *plaqueDetailView = [[MRPlaqueDetailTableViewController alloc] initWithNibName:@"PlaqueDetailView" bundle:nil];
    // check which table and set up the appropriate data
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        plaqueDetailView.currentPlaque = [filteredPlaques objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:plaqueDetailView animated:YES];
    } else {
        
        // we need to set the data property of the incomming plaque details table view
        NSArray *currentPlaqueSection = [NSArray arrayWithArray:[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:indexPath.section]];
        plaqueDetailView.currentPlaque = [currentPlaqueSection objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:plaqueDetailView animated:YES];
        [plaqueDetailView release];
    }


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
        // check which table and return appropriate section titles
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            return nil;
        } else {
            // we return the matching section title
            if ([[appDelegate.plaqueData.indexedPlaqueArray objectAtIndex:section] count] > 0) {
                return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
            }
            return nil;
        }   
}

#pragma mark Search Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText {
    // clear out the filtered array
    [self.filteredPlaques removeAllObjects];
    
    // find matching plaques and add to the filtered array
    for ( MRPlaque *plaque in appDelegate.plaqueData.rawPlaqueArray ) {
        
        // compare the search string to the plaque name
        //NSComparisonResult result = [plaque.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
       // if (result == NSOrderedSame) {
		
		NSRange result = [plaque.title rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
		if (result.location != NSNotFound)
		{
            [self.filteredPlaques addObject:plaque];
        }
        
    }    
}

- (void)dealloc {
    [appDelegate release];
    [super dealloc];
}

@end
