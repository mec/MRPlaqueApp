//
//  MRPlaqueData.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 24/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRPlaque.h"

@interface MRPlaqueData : NSObject {
    
    NSMutableArray *rawPlaqueArray, *indexedPlaqueArray, *favouritePlaques;
}

@property (nonatomic, retain) NSMutableArray *rawPlaqueArray, *indexedPlaqueArray, *favouritePlaques;

- (void)saveUserData;
@end
