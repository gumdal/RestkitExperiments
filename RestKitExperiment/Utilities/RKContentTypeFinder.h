//
//  SMContentTypeFinder.h
//  SolaroMobile
//
//  Created by Abhilash Perayil on 22/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKContentTypeFinder : NSObject <NSURLConnectionDelegate>
{
    NSString *contentType_;
}

@property (nonatomic, retain) NSString *contentType;

-(NSString *)contentTypeForURL:(NSURL *)inURL;

@end
