//
//  MRPlaque.h
//  Untitled
//
//  Created by Meyric Rawlings on 18/10/2009.
//  Copyright 2009 Yellow Box Software . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MRPlaque : NSObject <MKAnnotation> {
    
    NSString *title, *subtitle, *wikiString, *address, *category, *note; 
    float latitude;
    float longitude;
	BOOL favorite;
    NSInteger sectionNumber;
}

@property (copy, nonatomic) NSString *title, *subtitle, *wikiString, *address, *category, *note;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic) BOOL favorite;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property NSInteger sectionNumber;

@end
