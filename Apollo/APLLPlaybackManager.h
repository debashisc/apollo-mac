//
//  APLLPlaybackManager.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface APLLPlaybackManager : NSObject <NSSoundDelegate>

- (void)playTopInEvent:(NSString *)eventID;
- (void)pause;
- (void)play;
- (void)toggle;
- (BOOL)playing;

@end
