//
//  MRMapViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 21/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MRPlaque.h"
#import "MRPlaqueData.h"
#import "MRPlaqueDetailTableViewController.h"


@interface MRMapViewController : UIViewController <CLLocationManagerDelegate> {
    
    IBOutlet MKMapView *theMapView;
    IBOutlet MRPlaqueData *plaqueData;
	CLLocationManager *locationManager;

}

@property (nonatomic, retain) CLLocationManager *locationManager;

-(IBAction)locateMe;

@end
