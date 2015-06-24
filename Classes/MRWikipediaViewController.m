//
//  MRWikipediaViewController.m
//  MRPlaqueApp
//
//  Created by Meyric Rawlings on 22/10/2009.
//  Copyright 2009 Yellow Box Software. All rights reserved.
//

#import "MRWikipediaViewController.h"


@implementation MRWikipediaViewController

@synthesize wikiString;

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
    // build the URL to search wikipedia
    // first job is to create a useable string from the data model, should involve escaping the spaces
    NSString *cleanWikiString = [wikiString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    // combine the clean string with the Wikipedia search string
    NSString *wikiSearchString = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/index.php?search=%@", cleanWikiString];

    // tell the web view to load the wikipedia page
    NSURL *wikipediaURL = [NSURL URLWithString:wikiSearchString];
    NSURLRequest *wikiRequest = [NSURLRequest requestWithURL:wikipediaURL];
    [webView loadRequest:wikiRequest];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)closeWikiView {
    // action to close the modal view
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
