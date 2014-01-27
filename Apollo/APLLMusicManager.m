//
//  APLLMusicManager.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLMusicManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation APLLMusicManager

+(NSArray *)getAllMusic {
    NSLog(@"All items:");
    // If your folder is a document.
    NSString *docsDir = MUSIC_PATH;
    // else you can give your folder path as well, if you know
    // for example like this NSString *; = @"user/desktop/testFolder"
    
    NSFileManager *localFileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
    NSString *file = nil;
    NSData *fileContents = [NSData data];
    
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    int i = 0;
    
    while ((file = [dirEnum nextObject]))
    {
        NSString *path = [docsDir stringByAppendingPathComponent:file];
        
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        
        NSArray *metadata = [asset commonMetadata];
        NSMutableDictionary *song = [[NSMutableDictionary alloc] init];
        for ( AVMetadataItem* item in metadata ) {
            NSString *key = [item commonKey];
            NSString *value = [item stringValue];
            if ([key isEqualToString:@"title"] || [key isEqualToString:@"artist"] || [key isEqualToString:@"albumName"])
                [song setValue:value forKey:key];
        }
        [song setValue:[path lastPathComponent] forKey:@"ID"];
        if (song[@"title"] && song[@"artist"])
            [ret addObject:song];
        i++;
    }
    return ret;
}

+(NSDictionary *)metadataForID:(NSString *)ID inEvent:(NSString *)eventID {
    ID = [[ID
      stringByReplacingOccurrencesOfString:@"+" withString:@" "]
     stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    for (NSDictionary *song in APP_DEL.libraries[eventID])
        if ([song[@"ID"] isEqualToString:ID])
            return song;
    return nil;
}

+(NSDictionary *)playlistDataForID:(NSString *)ID inEvent:(NSString *)eventID {
    for (NSDictionary *song in APP_DEL.playlists[eventID])
        if ([song[@"ID"] isEqualToString:ID])
            return song;
    return nil;
}

@end
