//
//  MRFavouritePlaquesTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 28/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRFavouritePlaquesTableViewController.h"


@implementation MRFavouritePlaquesTableViewController

@synthesize favourtiePlaques;

- (void)viewDidLoad
{
    self.navigationItem.leftBarButtonItem = self.editButtonItem;  
	
    // hook up plaque data to the model from the app delegate
    appDelegate = (MRPlaqueAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)edit:(id)sender {
    NSLog(@"Editing!");
    [self.tableView setEditing:YES animated: YES];
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
	NSLog(@"deleted row %@", indexPaths);
}

- (IBAction)add:(id)sender {
    // push the complete plaque list and let the user add a plaque.
	MRAddFavouritePlaqueTableViewController *plaqueTableView = [[MRAddFavouritePlaqueTableViewController alloc] init];
	[self.navigationController pushViewController:plaqueTableView animated:YES];
	
	// make up the path to the favourites
	NSString *pathToFavoritesDataFile = [NSString stringWithFormat:@"%@/Documents/favorites.plist",NSHomeDirectory()];
	// save the favourite data
	[appDelegate.plaqueData.favouritePlaques writeToFile:pathToFavoritesDataFile atomically:YES];
}

// allow the table to remove a line
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSLog(@"Deleting row %@", indexPath);
	[[favourtiePlaques objectAtIndex:indexPath.row] setFavorite:NO];
	[self updateFavorites];
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Updating favorite data");
	[self updateFavorites];
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.textLabel.text = [[favourtiePlaques objectAtIndex:indexPath.row] title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [appDelegate.plaqueData.favouritePlaques count];

	return [favourtiePlaques count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MRPlaqueDetailTableViewController *plaqueDetailView = [[MRPlaqueDetailTableViewController alloc] initWithNibName:@"PlaqueDetailView" bundle:nil];
    // we need to set the data property of the incomming plaque details table view
    plaqueDetailView.currentPlaque = [favourtiePlaques objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:plaqueDetailView animated:YES];
    [plaqueDetailView release];
}

- (void)updateFavorites {
	// create the favorite plaque array by filtering the raw plaque array
	//NSLog(@"Raw array contains: %@", appDelegate.plaqueData.rawPlaqueArray);
	
	NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"favorite == 1"];

	[favourtiePlaques release];
	
	favourtiePlaques = [[NSMutableArray arrayWithArray:appDelegate.plaqueData.rawPlaqueArray] retain];
	
	[favourtiePlaques filterUsingPredicate:bPredicate];

	// sort the favorites alphabetically
	NSSortDescriptor *sortMyFavorites = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
	[favourtiePlaques sortUsingDescriptors:[NSArray arrayWithObject:sortMyFavorites]];
	[sortMyFavorites release];
	
	//NSLog(@"favorite plaques is now %@", favourtiePlaques);
}
@end
