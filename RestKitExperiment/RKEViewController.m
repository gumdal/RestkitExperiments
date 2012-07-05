//
//  RKEViewController.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKEViewController.h"

@implementation RKEViewController
@synthesize footballClient=footballClient_;
-(void)setFootballClient:(TheStarFootballClient *)inFootballClient
{
    if (inFootballClient!=footballClient_)
    {
        [footballClient_ cancelPendingRequestsWithDelegate:self];
        footballClient_ = inFootballClient;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendRequests];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
- (void)sendRequests
{
    TheStarFootballClient *aFootballClient = [[TheStarFootballClient alloc] init];
    [aFootballClient sendRequestWithResponseDelegate:self];
    [self setFootballClient:aFootballClient];
}  

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{  
}

@end
