//
//  MRPlaqueData.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 24/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRPlaqueData.h"

@implementation MRPlaqueData

@synthesize rawPlaqueArray, indexedPlaqueArray, favouritePlaques;

- (id)init
{
    if ((self = [super init])) {
        NSLog(@"Plaque data is alive.");
		
		NSString *pathToNewData = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];

		// try and asve the plaque data
		NSString *pathToDataFile = [NSString stringWithFormat:@"%@/Documents/data.plist",NSHomeDirectory()];
		//NSLog(@"directory %@",pathToDataFile);
		
		// if there is on load it, if not leave create an empty one
		NSFileManager *fileManger = [NSFileManager defaultManager];
		
		if ( [fileManger fileExistsAtPath:pathToDataFile] ) {
			NSLog(@"There is a data file!");
			
		} else {
			NSLog(@"There is NO data file!");
			// copy the file over
			[fileManger copyItemAtPath:pathToNewData toPath:pathToDataFile error:nil];
		}
		
        // trying to build a proper data model of objects
        UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
        self.indexedPlaqueArray = [[NSMutableArray arrayWithCapacity:1] retain];
        
        NSArray *tempArray;
       // NSMutableArray *plaquesTemp;
        
        
        if (pathToDataFile && (tempArray = [NSArray arrayWithContentsOfFile:pathToDataFile])) {
            self.rawPlaqueArray = [NSMutableArray arrayWithCapacity:1];
            
            for ( NSDictionary *plaqueDictionary in tempArray) {
                MRPlaque *plaque = [[MRPlaque alloc] init];
                plaque.title = [plaqueDictionary objectForKey:@"Title"];
                plaque.subtitle = [plaqueDictionary objectForKey:@"Subtitle"];
                plaque.longitude = [[plaqueDictionary objectForKey:@"Longitude"] floatValue];
                plaque.latitude = [[plaqueDictionary objectForKey:@"Latitude"] floatValue];
				//NSLog(@"long is %f and lat is %f", plaque.longitude, plaque.latitude);
                plaque.wikiString = [plaqueDictionary objectForKey:@"Wiki String"];
                plaque.address = [plaqueDictionary objectForKey:@"Address"];
                plaque.category = [plaqueDictionary objectForKey:@"Category"];
				plaque.note = [plaqueDictionary objectForKey:@"Note"];
				plaque.favorite = [[plaqueDictionary objectForKey:@"Favorite"] boolValue];
				
				//NSLog(@"favorite is %i", plaque.favorite);

                [self.rawPlaqueArray addObject:plaque];
                [plaque release];
            }
        }
		//NSLog(@"upon creation raw contains %@", rawPlaqueArray);
        
        // Getting the sections based on Title from the plaque object
        for (MRPlaque *plaque in self.rawPlaqueArray) {
            NSInteger section = [theCollation sectionForObject:plaque collationStringSelector:@selector(title)];
            plaque.sectionNumber = section;
        }
        
        // creating arrays for each section
        NSInteger sectionCount = [[theCollation sectionTitles] count];
        NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:sectionCount];
        for ( int i=0; i<=sectionCount; i++ ) {
            NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
            [sectionArrays  addObject:sectionArray];
			}
        
        // adding the plaques to the sections
        for (MRPlaque *plaque in self.rawPlaqueArray) {
            [(NSMutableArray *)[sectionArrays objectAtIndex:plaque.sectionNumber] addObject:plaque];
        }
        
        for (NSMutableArray *sectionArray in sectionArrays) {
            NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(title)];
            [indexedPlaqueArray addObject:sortedSection];
			}
	}
    return self;
}

- (void)saveUserData {
	NSLog(@"Trying to write the raw plaques to a file");
	
	NSString *fileDataPath = [NSString stringWithFormat:@"%@/Documents/data.plist",NSHomeDirectory()];
	
	// take the raw plaque array enumerate through it creating an array of dictionaries to write out
	
	NSMutableArray *fileDataArray = [NSMutableArray arrayWithCapacity:self.rawPlaqueArray.count];
	
	for ( MRPlaque *currentPlaque in self.rawPlaqueArray) {
		//NSLog(@"current plaque is %@", currentPlaque);
		// for each plaque, create a dictionary of its values
		NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
		[tempDictionary setValue:currentPlaque.title forKey:@"Title"];
		[tempDictionary setValue:currentPlaque.subtitle forKey:@"Subtitle"];
		// create NSNumbers from the float values
		NSNumber *longitudeNumber = [NSNumber numberWithFloat:currentPlaque.longitude];
		NSNumber *latitudeNumber = [NSNumber numberWithFloat:currentPlaque.latitude];
		
		[tempDictionary setValue:longitudeNumber forKey:@"Longitude"];
		[tempDictionary setValue:latitudeNumber forKey:@"Latitude"];
		
		[tempDictionary setValue:currentPlaque.wikiString forKey:@"Wiki String"];
		[tempDictionary setValue:currentPlaque.address forKey:@"Address"];
		[tempDictionary setValue:currentPlaque.category forKey:@"Category"];
		[tempDictionary setValue:currentPlaque.note forKey:@"Note"];
		
		// create a number to store our BOOL
		NSNumber *favourite = [NSNumber numberWithBool:currentPlaque.favorite];
		[tempDictionary setValue:favourite forKey:@"Favorite"];
		//NSLog(@"trying to write favorite as %i",currentPlaque.favorite);
		
		// add the current dictionary to the file array
		[fileDataArray addObject:tempDictionary];
	}
	//NSLog(@"file array looks like %@", fileDataArray);
	BOOL result = [fileDataArray writeToFile:fileDataPath atomically:YES];
	NSLog(@"Did we save the file? %i", result);
	
}

@end
