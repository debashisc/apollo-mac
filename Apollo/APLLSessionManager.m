//
//  APLLSessionManager.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLSessionManager.h"

@implementation APLLSessionManager

NSMutableArray *connections;
NSMutableData *receivedData;

-(id)init {
    if (self = [super init]) {
        connections = [[NSMutableArray alloc] init];
        _events = [[NSMutableArray alloc] init];
        receivedData = [[NSMutableData alloc] init];
    }
    return self;
}

-(void)doRequest:(NSURL *)endpoint withMethod:(NSString *)method andParameters:(id)parameters andTarget:(id)target andAction:(NSString *)selString {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:endpoint];
//    NSLog(@"%@", endpoint);
    if (parameters)
        [req setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]];
    [req setHTTPMethod:method];
    if (target)
        [connections addObject:@[@"action", [[NSURLConnection alloc] initWithRequest:req delegate:self], target, selString]];
    else
        [connections addObject:@[@"noaction", [[NSURLConnection alloc] initWithRequest:req delegate:self]]];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%@", [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding]);
    //    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    for (NSArray *connArray in connections) {
        if ([connArray[0] isEqualToString:@"noaction"])
            break;
//        NSLog(@"%@", connArray);
        if ([connArray[0] isEqualToString:@"action"])
            [connArray[2] performSelector:NSSelectorFromString(connArray[3]) withObject:[NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:nil]];
        [connections removeObject:connArray];
    }
    receivedData = [[NSMutableData alloc] init];
}

@end
