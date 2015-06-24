//
//  MRWikipediaViewController.h
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 22/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MRWikipediaViewController : UIViewController {
    
    IBOutlet UIWebView *webView;
    NSString *wikiString;

}

@property (nonatomic, retain) NSString *wikiString;

- (IBAction)closeWikiView;
@end
