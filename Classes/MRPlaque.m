//
//  MRPlaque.m
//  Untitled
//
//  Created by Meyric Rawlings on 18/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaque.h"


@implementation MRPlaque

@synthesize title, subtitle, wikiString, address, category, note;
@synthesize longitude;
@synthesize latitude;
@synthesize favorite;
@synthesize sectionNumber;

- (CLLocationCoordinate2D)coordinate {
    
    CLLocationCoordinate2D coord = {self.latitude, self.longitude};
    return coord;
}
@end
