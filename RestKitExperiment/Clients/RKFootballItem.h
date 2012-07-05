//
//  RKFootballItem.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKBaseObject.h"

@interface RKFootballItem : RKBaseObject
{
    NSString *title_;
    NSString *link_;
    NSString *commentsURL_;
    NSString *storyDescription_;
    NSDate *publicationDate_;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *commentsURL;
@property (nonatomic, copy) NSString *storyDescription;
@property (nonatomic, retain) NSDate *publicationDate;


@end
