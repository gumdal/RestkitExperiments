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
@interface RKEViewController : UIViewController <RKRequestDelegate>
{
    TheStarFootballClient *footballClient_;
}
@property (nonatomic, retain) TheStarFootballClient *footballClient;

- (void)sendRequests;

@end
