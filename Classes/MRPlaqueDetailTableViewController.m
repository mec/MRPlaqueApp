//
//  MRPlaqueDetailTableViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 19/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaqueDetailTableViewController.h"


@implementation MRPlaqueDetailTableViewController

@synthesize currentPlaque;

- (void)viewDidLoad {
    // make the buttons to put in to the footer view.
	UIButton *wikipediaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    wikipediaButton.frame = CGRectMake(0.0, 0.0, 300.0, 45.0);//cell.frame;
    [wikipediaButton addTarget:self action:@selector(showWikipediaView) forControlEvents:UIControlEventTouchUpInside];
    [wikipediaButton setTitle:@"Lookup on Wikipedia" forState:UIControlStateNormal];
	
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [mapButton addTarget:self action:@selector(showPlaqueOnMap) forControlEvents:UIControlEventTouchUpInside];
    mapButton.frame = CGRectMake(0.0, 55.0, 300.0, 45.0);//cell.frame;
    [mapButton setTitle:@"Show on map" forState:UIControlStateNormal];
	
	favoriteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	favoriteButton.frame = CGRectMake(0.0, 110.0, 300.0, 45.0);
	if (currentPlaque.favorite == NO) {
		[favoriteButton setTitle:@"Add to favorites" forState:UIControlStateNormal];
		[favoriteButton addTarget:self action:@selector(toggleFavoritePlaque) forControlEvents:UIControlEventTouchUpInside];

	
	} else {
		[favoriteButton setTitle:@"Remove from favorites" forState:UIControlStateNormal];
		[favoriteButton addTarget:self action:@selector(toggleFavoritePlaque) forControlEvents:UIControlEventTouchUpInside];
	}

    
    // try and add a footer to the table
    UIView *myTableFooterView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 165.0)];
	self.tableView.tableFooterView = myTableFooterView;
    [myTableFooterView release];
	[self.tableView.tableFooterView addSubview:wikipediaButton];
    [self.tableView.tableFooterView addSubview:mapButton];
	[self.tableView.tableFooterView	addSubview:favoriteButton];
	
    // change the title of the navigation bar
    self.title = @"Info";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // create a button if we need to        
    UIButton *wikipediaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    wikipediaButton.frame = CGRectMake(0.0, 0.0, 300.0, 45.0);//cell.frame;
    [wikipediaButton addTarget:self action:@selector(action: forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [wikipediaButton setTitle:@"Lookup on Wikipedia" forState:UIControlStateNormal];
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mapButton.frame = CGRectMake(0.0, 0.0, 300.0, 45.0);//cell.frame;
    [mapButton setTitle:@"Show on map" forState:UIControlStateNormal];
    
    static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if ( indexPath.section == 0 ) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MyIdentifier] autorelease];
        }
		cell.textLabel.text = @"About";
		cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = currentPlaque.subtitle;
        
    } else if ( indexPath.section == 1 ) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MyIdentifier] autorelease];
        }
		cell.textLabel.text = @"Address";
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = currentPlaque.address;

    } else if (indexPath.section == 2) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MyIdentifier] autorelease];
        }

		
		cell.textLabel.text = @"Note";
		cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = currentPlaque.note;
		
    } else if (indexPath.section == 3) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        }
        //[cell.contentView addSubview:wikipediaButton];            

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // we return the number of rows in a given section
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // we don't want to be able to selct the rows in this table!
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        //return [currentPlaque objectForKey:@"Title"];
        return currentPlaque.title;
    } else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section <= 2 ) {
        return 90.0;

    }else {
       return 45.0; 
    }
}

- (void)showWikipediaView {
    // if the sender was the wikipedia button bring up the web view and load the relevant wikipedia page
    MRWikipediaViewController *wikiViewContoller = [[MRWikipediaViewController alloc] initWithNibName:@"wikipediaView" bundle:nil];
    //if there is a special wiki string, pass it, if not pass the title
    if ( !currentPlaque.wikiString ) {
        //there is no wiki string, use title
        wikiViewContoller.wikiString = currentPlaque.title;
    } else {
        // there is a wiki string, so use it
        wikiViewContoller.wikiString = currentPlaque.wikiString;
    }
    
    [self presentModalViewController:wikiViewContoller animated:YES];
    [wikiViewContoller release];
}

- (void)showPlaqueOnMap {
	// we need to center the map on the current plaque
	NSLog(@"plaque co ordinates are %f %f ", currentPlaque.longitude, currentPlaque.latitude);
	
	MRModalMapViewContoller *mapView = [[MRModalMapViewContoller alloc] initWithNibName:@"ModalMapView" bundle:nil];

	//mapView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:mapView animated:YES];
	// set the map plaque to the current plaque
	[mapView showPlaque:currentPlaque];
}

- (void)toggleFavoritePlaque {
	
	if (currentPlaque.favorite == YES) {
		currentPlaque.favorite = NO;
		[favoriteButton setTitle:@"Add to favorites" forState:UIControlStateNormal];

	} else {
		currentPlaque.favorite = YES;
		[favoriteButton setTitle:@"Remove from favorites" forState:UIControlStateNormal];

	}
	// set the favorite flag

}

@end
