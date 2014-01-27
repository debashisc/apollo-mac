//
//  APLLPlaybackManager.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLPlaybackManager.h"
#import <AppKit/AppKit.h>

@implementation APLLPlaybackManager

NSString *currentPlaybackEvent;
NSSound *sound;
NSTimeInterval pausedInterval = 0;
BOOL paused = YES;

//-(void)startWithEventID:(NSString *)eventID {
//    [self performSelectorInBackground:@selector(watchPlayerPipe) withObject:eventID];
//}
//
//-(void)watchPlayerPipe:(NSString *)eventID {
//    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:[NSString stringWithFormat:@"%@/playlist-signal", [[NSBundle mainBundle] executablePath]]];
//    NSOutputStream *outputStream = [[NSOutputStream alloc] initToFileAtPath:[NSString stringWithFormat:@"%@/playlist", [[NSBundle mainBundle] executablePath]] append:NO];
//    uint8_t read;
//    while (true) {
//        [inputStream read:&read maxLength:1];
//        [[APP_DEL playlists][eventID] removeObjectAtIndex:0];
//        [[NSString stringWithFormat:@"%@/%@", MUSIC_PATH, [APP_DEL playlists][eventID][0][@"ID"]] writeToFile:[NSString stringWithFormat:@"%@/playlist", [[NSBundle mainBundle] executablePath]] atomically:NO encoding:NSUTF8StringEncoding error:nil];
//        [APP_DEL performSelectorOnMainThread:@selector(updateSongsList) withObject:nil waitUntilDone:YES];
//    }
//}

- (void)playTopInEvent:(NSString *)eventID {
    currentPlaybackEvent = eventID;
    NSString *file = [NSString stringWithFormat:@"%@/%@", MUSIC_PATH, [APP_DEL playlists][eventID][0][@"ID"]];
    NSURL *url = [NSURL URLWithString:file];
    NSError *err;
    NSLog(@"Playing %@", file);
    sound = [[NSSound alloc] initWithContentsOfFile:file byReference:NO];
    sound.delegate = self;
    [sound play];
    paused = NO;
    APP_DEL.togglePlay.image = [NSImage imageNamed:@"pause-regular"];
    APP_DEL.togglePlay.alternateImage = [NSImage imageNamed:@"pause-hover"];
}

-(void)sound:(NSSound *)sound didFinishPlaying:(BOOL)aBool {
    [[[APP_DEL playlists] objectForKey:currentPlaybackEvent] removeObjectAtIndex:0];
    [APP_DEL updateSongsList];
    if ([[[APP_DEL playlists] objectForKey:currentPlaybackEvent] count] > 0)
        [self playTopInEvent:currentPlaybackEvent];
}

-(void)pause {
    paused = YES;
    [sound pause];
    APP_DEL.togglePlay.image = [NSImage imageNamed:@"play-regular"];
    APP_DEL.togglePlay.alternateImage = [NSImage imageNamed:@"play-hover"];
}

-(void)play {
    paused = NO;
    [sound resume];
    APP_DEL.togglePlay.image = [NSImage imageNamed:@"pause-regular"];
    APP_DEL.togglePlay.alternateImage = [NSImage imageNamed:@"pause-hover"];
}

-(void)toggle {
    NSLog(@"%@", !paused ? @"Playing" : @"Not Playing");
    if (paused) {
        [sound resume];
        APP_DEL.togglePlay.image = [NSImage imageNamed:@"pause-regular"];
        APP_DEL.togglePlay.alternateImage = [NSImage imageNamed:@"pause-hover"];
    } else {
        [sound pause];
        APP_DEL.togglePlay.image = [NSImage imageNamed:@"play-regular"];
        APP_DEL.togglePlay.alternateImage = [NSImage imageNamed:@"play-hover"];
    }
    paused = !paused;
}

-(BOOL)playing {
    NSLog(@"%@", !paused ? @"Playing" : @"Not Playing");
    return !paused;
}

@end
