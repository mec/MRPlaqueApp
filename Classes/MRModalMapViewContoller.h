//
//  MRModalMapViewContoller.h
//  MRPlaqueApp
//
//  Created by Mec Rawlings on 23/01/2010.
//  Copyright 2010 Dragon Rouge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MRPlaque.h"
#import "MRPlaqueData.h"
#import "MRPlaqueDetailTableViewController.h"


@interface MRModalMapViewContoller : UIViewController <CLLocationManagerDelegate> {

    IBOutlet MKMapView *theMapView;
    IBOutlet MRPlaqueData *plaqueData;
	IBOutlet UIBarButtonItem *locateMeButton;
	CLLocationManager *locationManager;
	MRPlaque *currentPlaque;

}

- (IBAction)locateMe;
- (IBAction)close;
- (void)showPlaque:(MRPlaque *)plaque;
- (void)showAllPlaques;

@property (nonatomic, retain) CLLocationManager *locationManager;


@end
