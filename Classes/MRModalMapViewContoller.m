//
//  MRModalMapViewContoller.m
//  MRPlaqueApp
//
//  Created by Mec Rawlings on 23/01/2010.
//  Copyright 2010 Dragon Rouge. All rights reserved.
//

#import "MRModalMapViewContoller.h"


@implementation MRModalMapViewContoller

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

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 NSLog(@"Map view did load");
 
 [super viewDidLoad];
 }
 */
- (void)showAllPlaques {
    // add all the plaques to the map
    for ( MRPlaque *plaque in plaqueData.rawPlaqueArray ) {
        [theMapView addAnnotation:plaque];
    }
    
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
    
    // which kind of placemark is this?  If we write our own placemark class, have to check for it here. My MRPlaque class is complient for MKAnnotationView.
    if ([[annotation class] isEqual:[MRPlaque class]]) {
        // create the call out button
        //UIButton *moreInfoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        // placemark
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
        annView.pinColor = MKPinAnnotationColorRed;
        annView.animatesDrop=TRUE;
        annView.canShowCallout = YES;
        //annView.rightCalloutAccessoryView = moreInfoButton;
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

- (IBAction)close {
    // action to close the modal view
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)showPlaque:(MRPlaque *)plaque
{
	NSLog(@"Plaque is now %@",plaque.title);
	
	[theMapView addAnnotation:plaque];
	
	MKCoordinateRegion region;
    region.center.longitude = plaque.longitude;
    region.center.latitude = plaque.latitude;
    region.span.longitudeDelta = 0.02;
    region.span.latitudeDelta = 0.02;
    [theMapView setRegion:region animated:YES];
	//Remember the current plaque so we can calculate distance from user location to this plaque
	if(currentPlaque != nil) [currentPlaque release];
	currentPlaque = [plaque retain];
	
}

-(IBAction)locateMe {
	NSLog(@"Locate me please.");

	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
	
	/*UIActivityIndicatorView *locateMeIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[locateMeIndicator setFrame:CGRectMake(0, 0, 40, 40)];
	//NSLog(@"uibarbutton frame is %@", [locateMeButton view]);
	[locateMeButton setCustomView:locateMeIndicator];
	[locateMeIndicator startAnimating];*/
}

// CLLocation Manager Delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	CLLocationCoordinate2D location=newLocation.coordinate;
	//One location is obtained.. just zoom to that location
	NSLog(@"Your location is %f longitude %f latitude", location.longitude, location.latitude);
	//NSLog(@"The current plaque is %f longitude %f latitude", plaque.longitude, plaque.latitude);
	MKCoordinateRegion region;
	region.center=location;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=179.0;
	span.longitudeDelta=179.0;
	region.span=span;
	//[theMapView setRegion:region animated:TRUE];
	theMapView.showsUserLocation = YES;

	//Get centre point between plaque and user's location
	CLLocation *midPoint;
	CLLocationDegrees halfLongitude, halfLatitude;
	
	halfLongitude = (currentPlaque.longitude + location.longitude) / 2.0;
	halfLatitude = (currentPlaque.latitude + location.latitude) / 2.0;
	midPoint = [[CLLocation alloc] initWithLatitude:halfLatitude longitude:halfLongitude];
	
	//CLLocation *plaqueLocation = [[CLLocation alloc] initWithLatitude:currentPlaque.latitude longitude:currentPlaque.longitude];
	
	CLLocation *locationForMeasuringDistanceInLongitudinalMetres = [[CLLocation alloc] initWithLatitude:midPoint.coordinate.latitude longitude:location.longitude];
	CLLocation *locationForMeasuringDistanceInLatitudinalMetres = [[CLLocation alloc] initWithLatitude:location.latitude longitude:midPoint.coordinate.longitude];

	CLLocationDistance longitudinalDistance = [midPoint distanceFromLocation:locationForMeasuringDistanceInLongitudinalMetres] * 2.0; // + 10000000.0;
	CLLocationDistance latitudinalDistance = [midPoint distanceFromLocation:locationForMeasuringDistanceInLatitudinalMetres] * 2.0;
	
	//Get the distance between centre point and either edge of the map (latitude)
	//CLLocationDistance hypotenuse = [midPoint getDistanceFrom:location];
	
	//Get the distance between centre point and either edge of the map (longitude)
	
	MKCoordinateRegion totalMapToShow = MKCoordinateRegionMakeWithDistance(midPoint.coordinate, latitudinalDistance, longitudinalDistance);
	//MKCoordinateRegion totalMapToShow = MKCoordinateRegionMakeWithDistance(midPoint.coordinate, longitudinalDistance, latitudinalDistance);
	[theMapView setRegion:totalMapToShow animated:TRUE];
	//[theMapView setRegion:[theMapView regionThatFits:totalMapToShow] animated:TRUE];

	NSLog(@"Region being shown is %@", NSStringFromCGRect([theMapView convertRegion:totalMapToShow toRectToView:nil]));
	NSLog(@"Pixel coords for midpoint is %@", NSStringFromCGPoint([theMapView convertCoordinate:midPoint.coordinate toPointToView:theMapView]));
	NSLog(@"Mapview frame = %@", NSStringFromCGRect([theMapView frame]));
	NSLog(@"Mapview bounds = %@", NSStringFromCGRect([theMapView bounds]));
	//Add the midpoint to the view
	MRPlaque *midPlaque = [[MRPlaque alloc] init];
	midPlaque.latitude = halfLatitude;
	midPlaque.longitude = halfLongitude;
	midPlaque.title = @"This is the mid point";
	[theMapView addAnnotation:midPlaque];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Location error!");
}

- (void)dealloc {
    [super dealloc];
}


@end
