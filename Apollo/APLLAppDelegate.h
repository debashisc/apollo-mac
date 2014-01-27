//
//  APLLAppDelegate.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#ifndef Apollo_APPLAppDelegate_h
#define Apollo_APPLAppDelegate_h

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
@class APLLSessionManager;
@class APLLPlaybackManager;

@interface APLLAppDelegate : NSObject <NSApplicationDelegate, AVAudioPlayerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) APLLSessionManager *sessionManager;
@property (nonatomic, retain) APLLPlaybackManager *playbackManager;
@property (nonatomic, retain, readonly) NSMutableDictionary *playlists;
@property (nonatomic, retain) NSMutableDictionary *libraries;
@property (nonatomic, retain) NSButton *togglePlay;

- (void)setEventPlayStateWithID:(NSString *)ID andTitle:(NSString*)title;
- (void)updateSongsList;

@end

#endif