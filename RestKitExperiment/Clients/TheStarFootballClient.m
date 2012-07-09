//
//  TheStarFootballClient.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheStarFootballClient.h"
#import <Restkit/Restkit.h>
#import "RKFootball.h"
#import "RKFootballItem.h"

@interface TheStarFootballClient()
- (void)loadStories;
@end

@implementation TheStarFootballClient
@synthesize starFootballResponseDelegate = starFootballResponseDelegate_;

- (void)dealloc
{
    [self setStarFootballResponseDelegate:nil];
}

#pragma mark -
#if 0
-(void)sendRequestWithResponseDelegate:(id)inDelegate
{
    [self setStarFootballResponseDelegate:inDelegate];
    
    // Perform a simple HTTP GET and call me back with the results  
    [[RKClient sharedClient] get:@"http://football.thestar.com.my/category/news/feed" delegate:self];  
    
    //    // Send a POST to a remote resource. The dictionary will be transparently  
    //    // converted into a URL encoded representation and sent along as the request body  
    //    NSDictionary* params = [NSDictionary dictionaryWithObject:@"RestKit" forKey:@"Sender"];  
    //    [[RKClient sharedClient] post:@"/other.json" params:params delegate:self];  
    //    
    //    // DELETE a remote resource from the server  
    //    [[RKClient sharedClient] delete:@"/missing_resource.txt" delegate:self];  
}

-(void)cancelPendingRequestsWithDelegate:(id)inDelegate
{
    
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{  
    if ([request isGET])
    {  
        // Handling GET /foo.xml  
        
        if ([response isOK]) {  
            // Success! Let's take a look at the data  
            NSLog(@"Retrieved XML: %@", [response bodyAsString]);  
        }  
        
    }/* else if ([request isPOST]) {  
      
      // Handling POST /other.json  
      if ([response isJSON]) {  
      NSLog(@"Got a JSON response back from our POST!");  
      }  
      
      } else if ([request isDELETE]) {  
      
      // Handling DELETE /missing_resource.txt  
      if ([response isNotFound]) {  
      NSLog(@"The resource path '%@' was not found.", [request resourcePath]);  
      }  
      }  */
}

#else

#define USE_LIVE_URL 1

-(void)sendRequestWithResponseDelegate:(id)inDelegate
{
#if USE_LIVE_URL
    RKObjectManager *newManager = [RKObjectManager managerWithBaseURLString:@"http://football.thestar.com.my/category/news/"];
    // Setting up coredata for Restkit:
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"Football.sqlite"];
    newManager.objectStore = objectStore;
    [RKObjectManager setSharedManager:newManager];
    
    // The root "rss" node mapping
//    RKManagedObjectMapping *rootMapping = [RKManagedObjectMapping mappingForClass:[NSManagedObject class]
//                                                              inManagedObjectStore:[[RKObjectManager sharedManager] objectStore]];
    RKManagedObjectMapping *rootMapping = [RKManagedObjectMapping mappingForEntityWithName:@"Root"
                                                                      inManagedObjectStore:[[RKObjectManager sharedManager] objectStore]];
    
    [[RKObjectManager sharedManager].mappingProvider setMapping:rootMapping forKeyPath:@"rss"];     // This sets the root node for mapping
    
    RKManagedObjectMapping *footballMapping = [RKFootball objectMapForObjectStore:[[RKObjectManager sharedManager] objectStore]];
    [rootMapping mapKeyPath:@"channel"
             toRelationship:@"channelKeyPath"
                withMapping:footballMapping];
    
    RKManagedObjectMapping *storyMapping = [RKFootballItem objectMapForObjectStore:[[RKObjectManager sharedManager] objectStore]];
    [footballMapping mapKeyPath:@"item"
                toRelationship:@"itemArray"
                   withMapping:storyMapping];
#else
    RKObjectManager *newManager = [RKObjectManager managerWithBaseURLString:@"http://172.18.0.100/~Abhilash/"];
    [RKObjectManager setSharedManager:newManager];
    RKObjectMapping *storyMapping = [RKObjectMapping mappingForClass:[RKFootball class]];
    [storyMapping mapKeyPath:@"title" toAttribute:@"title"];
    
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[RKFootballItem class]];
    [itemMapping mapKeyPath:@"title" toAttribute:@"title"];
    [itemMapping mapKeyPath:@"link" toAttribute:@"link"];
    
    [storyMapping mapKeyPath:@"item" toRelationship:@"itemArray" withMapping:itemMapping];
    
    [[RKObjectManager sharedManager].mappingProvider setMapping:storyMapping forKeyPath:@"channel"];
#endif
    
    // Now lets load the stories
    [self loadStories];
}

- (void)loadStories
{
#if USE_LIVE_URL
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/feed" delegate:self];
#else
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/footballresponse.xml" delegate:self];
#endif
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    RKLogInfo(@"Load collection of Articles: %@", objects);
    for (NSManagedObject *dict in objects)
    {
        RKFootball *ob = [dict valueForKey:@"channelKeyPath"];
        NSLog(@"The title = %@", [ob title]);
        for (RKFootballItem *footballItem in [ob itemArray])
        {
            NSLog(@"%@",footballItem.description);
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error = %@", error);
}

// -(void)cancelPendingRequestsWithDelegate:(id)inDelegate
//{
//    
//}
// 
// - (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
//{
//    
//}
     
#endif
@end
