//
//  SMPlaylistContentSegregator.m
//  SolaroMobile
//
//  Created by Raj Pawan Gumdal on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKHTMLContentSegregator.h"
#import "RKContentTypeFinder.h"

@implementation RKHTMLContentSegregator

-(NSArray*)seggregateContentForData:(NSString*)inData
{
    NSString *dataText = inData;
    
    NSMutableArray *allElements = [NSMutableArray array];
    NSArray *allMatches = nil;
    
#if 0
    NSError *error = nil;
    // create the NSRegularExpression object and initialize it with a pattern
    // the pattern will match any http or https url, with option case insensitive
    // http://remarkablepixels.com/blog/2011/1/13/regular-expressions-on-ios-nsregularexpression.html
    // http://www.geekzilla.co.uk/view2D3B0109-C1B2-4B4E-BFFD-E8088CBC85FD.htm
    //	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_?\+-=\\\.&]*)" options:NSRegularExpressionCaseInsensitive error:&error];
    //	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((https?|ftp|gopher|telnet|file|notes|ms-help)(://)([-\\w\\.]+))?" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(((https?|ftp|gopher|telnet|file|notes|ms-help)(://)([-\\w\\.]+)))+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive error:&error];
    if (nil==error)
    {
#if 0
        NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:dataText options:0 range:NSMakeRange(0, [dataText length])];
        // check that our NSRange object is not equal to range of NSNotFound
        if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
        {
            // Since we know that we found a match, get the substring from the parent string by using our NSRange object
            NSString *substringForFirstMatch = [dataText substringWithRange:rangeOfFirstMatch];
            NSLog(@"Extracted URL: %@",substringForFirstMatch);
        }
#else
        allMatches = [regex matchesInString:dataText
                                    options:NSRegularExpressionCaseInsensitive
                                      range:NSMakeRange(0, [dataText length])];
#endif
    }    
#else
    // http://stackoverflow.com/questions/4590440/how-can-i-extract-a-url-from-a-sentence-that-is-in-a-nsstring/4590734#4590734
    NSString *string = dataText;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    allMatches = [linkDetector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
#endif
    
    NSRange textRange = NSMakeRange(0, 0);
    for (int i=0; i<[allMatches count]; i++)
    {
        NSTextCheckingResult *aMatch = [allMatches objectAtIndex:i];
        NSRange urlMatchRange = [aMatch range];
        
        // Now first see if textRange has any pending text to be picked!
        if (textRange.location<urlMatchRange.location)
        {
            NSUInteger textLength = urlMatchRange.location-textRange.location;
            textRange.length = textLength;
            NSString *textString = [dataText substringWithRange:textRange];
            textString = [textString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSDictionary *textDict = [NSDictionary dictionaryWithObjectsAndKeys:textString, kAssetSourceDescTag, kAssetCategoryText, kAssetCategoryTag, nil];
            [allElements addObject:textDict];
        }
        
        // Now fetch the URL
        NSString *urlText = [dataText substringWithRange:urlMatchRange];
        urlText = [urlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (urlText)
        {
            RKContentTypeFinder *contentTypeFinder = [[RKContentTypeFinder alloc] init];
            NSString *urlType = [contentTypeFinder contentTypeForURL:[NSURL URLWithString:urlText]];
            NSDictionary *urlDictionary = [NSDictionary dictionaryWithObjectsAndKeys:urlText, kAssetSourceWebURLTag, urlType, kAssetCategoryTag, nil];
            [allElements addObject:urlDictionary];
        }
        
        // Update the textRange's location so that it points to the next character after the current URL and set its length to 0
        textRange.location = urlMatchRange.location + urlMatchRange.length;
        textRange.length = 0;
    }
    
    // Now add any remaining text after the last URL:
    if (textRange.location+textRange.length < [dataText length])
    {
        textRange.length = [dataText length] - textRange.location;
        NSString *remainingText = [dataText substringWithRange:textRange];
        remainingText = [remainingText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDictionary *textDict = [NSDictionary dictionaryWithObjectsAndKeys:remainingText, kAssetSourceDescTag, kAssetCategoryText, kAssetCategoryTag, nil];
        [allElements addObject:textDict];
    }
    
    // If there is only 1 URL in the elements and if it is of type "mixed", change it to weblink type.
    if (1==[allElements count])
    {
        NSDictionary *elementDict = [allElements objectAtIndex:0];
        if ([kAssetCategoryMixed isEqualToString:[elementDict objectForKey:kAssetCategoryTag]])
        {
            // Change its type to Web-Link
            NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:elementDict];
            [newDict setValue:kAssetCategoryLink
                       forKey:kAssetCategoryTag];
            [allElements removeObject:elementDict];
            [allElements addObject:newDict];
        }
    }
    
    return allElements;
}

@end
