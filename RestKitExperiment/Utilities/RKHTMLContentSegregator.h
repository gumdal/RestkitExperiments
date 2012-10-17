//
//  SMPlaylistContentSegregator.h
//  SolaroMobile
//
//  Created by Raj Pawan Gumdal on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//Asset category type
#define kAssetCategoryText @"text"
#define kAssetCategoryLink @"link"
#define kAssetCategoryPicture @"picture"
#define kAssetCategoryVideo @"video"
#define kAssetCategoryMixed @"mixed"

#define kAssetCategoryTag @"category"
#define kAssetSourceDescTag @"desc"
#define kAssetSourceWebURLTag @"webURL"

@interface RKHTMLContentSegregator : NSObject

/* Returns an array of dictionary with 2 keys:
 1. Key: kAssetCategoryTag -> This will tell that the content is one of the following which is the value it holds:
    Values:
                         kAssetCategoryText
                         kAssetCategoryLink
                         kAssetCategoryPicture
                         kAssetCategoryVideo
                         kAssetCategoryMixed
                         kAssetCategoryUnknown
 2. Key: kAssetSourceWebURLTag or kAssetSourceDescTag depending on the value of kAssetCategoryTag
    If kAssetCategoryText is the value for kAssetCategoryTag then the key will be - kAssetSourceDescTag
    If one among kAssetCategoryLink, kAssetCategoryPicture, kAssetCategoryVideo, kAssetCategoryMixed, kAssetCategoryUnknown are the values for kAssetCategoryTag then the key will be - kAssetSourceWebURLTag
    Values:
            A. (for kAssetSourceDescTag)
                NSString value which is should be treated as plain text
            B. (for kAssetSourceWebURLTag)
                NSString value which should be treated as URL for appropriate kAssetCategoryTag kind
 */
-(NSArray*)seggregateContentForData:(NSString*)inData;

@end
