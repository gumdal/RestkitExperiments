//
//  RKFootballItem.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RKBaseObject.h"


@interface RKFootballItem : RKBaseObject

@property (nonatomic, retain) NSString * commentsURL;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate *publicationDate;
@property (nonatomic, retain) NSString *storyDescription;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * itemContent;

@end
