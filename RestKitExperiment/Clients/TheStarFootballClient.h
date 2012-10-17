//
//  TheStarFootballClient.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Restkit/Restkit.h>

@interface TheStarFootballClient : NSObject <RKObjectLoaderDelegate>
{
    __weak id starFootballResponseDelegate_;
}
@property (readwrite, nonatomic) __weak id starFootballResponseDelegate;

#pragma mark -
-(void)sendRequestWithResponseDelegate:(id)inDelegate;
-(void)cancelPendingRequestsWithDelegate:(id)inDelegate;

@end
