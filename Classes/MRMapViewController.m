//
//  MRMapViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 21/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRMapViewController.h"


@implementation MRMapViewController

@synthesize locationManager;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"Map view did load");
 // add all the plaques to the map
 for ( MRPlaque *plaque in plaqueData.rawPlaqueArray ) {
 [theMapView addAnnotation:plaque];
 }
 
 MKCoordinateRegion region;
 region.center.longitude = -0.145871;
 region.center.latitude = 51.512983;
 region.span.longitudeDelta = 0.5;
 region.span.latitudeDelta = 0.5;
 [theMapView setRegion:region animated:YES];
    
    [super viewDidLoad];
}

- (void)showAllPlaques {

    
    // let's centre the map on something
    // zooming the map on to Jimi but open the view out to the whole of london
    MKCoordinateRegion region;
    region.center.longitude = -0.145871;
    region.center.latitude = 51.512983;
    region.span.longitudeDelta = 0.5;
    region.span.latitudeDelta = 0.5;
    [theMapView setRegion:region animated:YES];
    NSLog(@"user is located: %f", theMapView.userLocation.location.coordinate.longitude);
    NSLog(@"user is located: %f",  theMapView.userLocation.location.coordinate.latitude);
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

// overide how placemarks are disaplyed
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // which kind of placemark is this?  If we write our own placemark class, have to check for it here.    
    if ([[annotation class] isEqual:[MRPlaque class]]) {
        // create the call out button
        UIButton *moreInfoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        // placemark
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
        annView.pinColor = MKPinAnnotationColorRed;
        annView.animatesDrop=TRUE;
        annView.canShowCallout = YES;
        annView.rightCalloutAccessoryView = moreInfoButton;
        return annView;
    } else {
        
        //something else, so don't overide.
        NSLog(@"Not calling MKPlacemark! Calling for %@", annotation);
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // make a new plaque detail table view controller
    MRPlaqueDetailTableViewController *plaqueDetailView = [[MRPlaqueDetailTableViewController alloc] initWithNibName:@"PlaqueDetailView" bundle:nil];
    // set the data of the new table view controller to the plaque that was tapped, found in view.annotation
    plaqueDetailView.currentPlaque = view.annotation;
    NSLog(@"the anno view calling is %@", view.annotation);
    [self.navigationController pushViewController:plaqueDetailView animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [plaqueDetailView release];
}

-(IBAction)locateMe {
	NSLog(@"Locate me please.");
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

// CLLocation Manager Delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	CLLocationCoordinate2D location=newLocation.coordinate;
	//One location is obtained.. just zoom to that location
	NSLog(@"Your location is %f longitude %f latitude", location.longitude, location.latitude);
	MKCoordinateRegion region;
	region.center=location;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.005;
	span.longitudeDelta=.005;
	region.span=span;
	theMapView.showsUserLocation = YES;
	[theMapView setRegion:region animated:TRUE];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
}

- (void)dealloc {
    [super dealloc];
}


@end
