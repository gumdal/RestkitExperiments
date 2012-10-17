//
//  RKEViewController.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Restkit/Restkit.h>
#import "TheStarFootballClient.h"
@interface RKEViewController : UIViewController <RKRequestDelegate, NSFetchedResultsControllerDelegate>
{
    TheStarFootballClient *footballClient_;
    NSFetchedResultsController *footballFetchController_;
    UITableView *footballTableView_;
}
@property (nonatomic, retain) TheStarFootballClient *footballClient;
@property (nonatomic, retain) NSFetchedResultsController *footballFetchController;
@property (nonatomic, retain) IBOutlet UITableView *footballTableView;

- (void)sendRequests;

@end
