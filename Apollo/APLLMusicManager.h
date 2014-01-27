//
//  APLLMusicManager.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APLLMusicManager : NSObject

+(NSArray *)getAllMusic;
+(NSDictionary *)metadataForID:(NSString *)ID inEvent:(NSString *)eventID;
+(NSDictionary *)playlistDataForID:(NSString *)ID inEvent:(NSString *)eventID;

@end
