//
//  SMContentTypeFinder.m
//  SolaroMobile
//
//  Created by Abhilash Perayil on 22/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKContentTypeFinder.h"
#import "RKHTMLContentSegregator.h"

@implementation RKContentTypeFinder
@synthesize contentType = contentType_;

-(NSArray *)getWhiteListedHosts
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Whitelisted-video-hosts" ofType:@"plist"];
    NSDictionary *WLDict = (NSDictionary *)[NSDictionary dictionaryWithContentsOfFile:file];
    
    return [WLDict objectForKey:@"Host Names"];
}

- (id)init {
    self = [super init];
    if (self) 
    {
        self.contentType = nil;
    }
    return self;
}

-(BOOL)isWhiteListedHostForVideo:(NSString *)inDominName
{
    BOOL isWhiteListed = NO;
    NSArray *whiteListedHosts = [self getWhiteListedHosts];
    for(NSString *indHost in whiteListedHosts)
    {
        if ([indHost isEqualToString:inDominName])
        {
            isWhiteListed = YES;
            break;
        }
    }
    return isWhiteListed;
}

-(NSString *)categoryStringForMIMETyp:(NSString *)inMIMEType
{
    NSString *categoryString = kAssetCategoryMixed;
    NSArray *compArray = [inMIMEType componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    if ([[compArray objectAtIndex:0] isEqualToString:@"image"]) 
        categoryString = kAssetCategoryPicture;
    else if ([[compArray objectAtIndex:0] isEqualToString:@"video"]) 
        categoryString = kAssetCategoryVideo;
    else if ([[compArray objectAtIndex:0] isEqualToString:@"text"])
        categoryString = kAssetCategoryLink;
    
    return categoryString;
}

-(NSString *)contentTypeForURL:(NSURL *)inURL
{
    if (nil == inURL) {
        self.contentType = kAssetCategoryMixed;
        return self.contentType;
    }
    
    NSString *domineName = [inURL host]; 
    if ([self isWhiteListedHostForVideo:domineName])
        self.contentType = kAssetCategoryVideo;
    else
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:inURL];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: request
                                                                      delegate: self
                                                              startImmediately: NO];
        [connection start];
        NSDate *theLimitDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
        while (nil == self.contentType && 
			   [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:theLimitDate] && 
			   [theLimitDate timeIntervalSinceNow] > 0)
		{}
        if (nil == self.contentType)
            self.contentType = kAssetCategoryMixed;
    }
    NSLog(@"Content Type is :%@",self.contentType);    
    return self.contentType;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"connection:didReceiveResponse called");
    self.contentType = [self categoryStringForMIMETyp:[response MIMEType]];    
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError called");
    self.contentType = kAssetCategoryMixed;    
    [connection cancel];    
}

- (void)dealloc {
    self.contentType = nil;
}

@end
