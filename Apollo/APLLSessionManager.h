//
//  APLLSessionManager.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APLLSessionManager : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, retain, readonly) NSMutableArray *events;

-(void)doRequest:(NSURL *)endpoint withMethod:(NSString *)method andParameters:(id)parameters andTarget:(id)target andAction:(NSString *)selString;

@end
