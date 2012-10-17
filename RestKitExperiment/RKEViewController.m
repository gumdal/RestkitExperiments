//
//  RKEViewController.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKEViewController.h"
#import "RKFootballItem.h"
#import "RKFootball.h"

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
@synthesize footballFetchController = footballFetchController_;
-(NSFetchedResultsController*)footballFetchController
{
    if (nil==footballFetchController_)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([RKFootball class])];
        NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"lastBuildDate"
                                                                   ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDesc]];
        footballFetchController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                       managedObjectContext:[NSManagedObjectContext contextForCurrentThread]
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
        [footballFetchController_ setDelegate:self];
    }
    return footballFetchController_;
}
@synthesize footballTableView = footballTableView_;

- (void)dealloc
{
    [[self footballFetchController] setDelegate:nil];
    [self setFootballFetchController:nil];
    [self setFootballTableView:nil];
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

    // Lets fetch the objects from coredata and also update the UI when live objects arrive!
    NSError *fetchingError = nil;
    [[self footballFetchController] performFetch:&fetchingError];
    if (fetchingError)
        NSLog(@"Error = %@", fetchingError);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setFootballTableView:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendRequests];    // Also Restkit setup is done inside this!
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

#pragma mark - Coredata model objects updated
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"Objects: %@", [controller fetchedObjects]);
//    NSArray *fetchedFootballObjects = [controller fetchedObjects];
    
    [self.footballTableView reloadData];
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.footballFetchController fetchedObjects] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RKFootball *footballObject = [[self.footballFetchController fetchedObjects] objectAtIndex:section];    // Ideally only 1 object should be there
    return [[footballObject itemArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"FootballCell";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil==aCell)
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:identifier];
    
    RKFootball *footballObject = [[self.footballFetchController fetchedObjects] objectAtIndex:indexPath.section];
    RKFootballItem *anItem = [[[footballObject itemArray] allObjects] objectAtIndex:indexPath.row];
    [[aCell textLabel] setText:[anItem title]];
    [[aCell detailTextLabel] setText:[anItem storyDescription]];
    return aCell;
}

@end
