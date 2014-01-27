//
//  APLLAppDelegate.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <Quartz/Quartz.h>
#import "APLLLeftPanelView.h"
#import "APLLSessionManager.h"
#import "APLLMusicManager.h"
#import "APLLEventTitleView.h"
#import "APLLAttendanceView.h"
#import "APLLSongItemView.h"
#import "APLLPlaybackManager.h"
#import "APLLTextField.h"

@implementation APLLAppDelegate

APLLLeftPanelView *leftPanel;
NSImageView *loginLogo;
NSButton *loginButton;
NSButton *createEventButton;
NSButton *goBackButton;
NSString *currentEventID = @"";
NSImageView *eventsBody;
NSMutableArray *songItems;

int songItemHeight = 64;
int songItemHeightCumul = 0;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_window setContentSize:NSSizeFromCGSize(CGSizeMake(800, 600))];
    [_window setStyleMask:[_window styleMask] & ~NSResizableWindowMask];
    
    _playlists = [[NSMutableDictionary alloc] init];
    _libraries = [[NSMutableDictionary alloc] init];
    songItems = [[NSMutableArray alloc] init];
    
    [self setSessionManager:[[APLLSessionManager alloc] init]];
    _playbackManager = [[APLLPlaybackManager alloc] init];
    
//    loginLogo = [[NSImageView alloc] initWithFrame:NSRect]
    
    [self setLoginState];
}

- (void)setLoginState {
    
    // Begin login state
    
    [_window setBackgroundColor:[NSColor colorWithCalibratedRed:54.0/255.0 green:55.0/255.0 blue:58.0/255.0 alpha:255.0/255.0]];
    
    /// Logo
    
    loginLogo = [[NSImageView alloc] initWithFrame:NSMakeRect(_window.frame.size.width/2-224/2, 320, 224, 65)];
    loginLogo.image = [NSImage imageNamed:@"logo"];
    [_window.contentView addSubview:loginLogo];
    
    /// Login button
    
    int loginButtonWidth = 304;
    int loginButtonHeight = 80;
    loginButton = [[NSButton alloc] initWithFrame:CGRectMake(_window.frame.size.width/2-loginButtonWidth/2, _window.frame.size.height/2-loginButtonHeight/2-60, loginButtonWidth, loginButtonHeight)];
//    [loginButton setTitle:@"Login"];
    [loginButton setImage:[NSImage imageNamed:@"regular"]];
    [loginButton setAlternateImage:[NSImage imageNamed:@"hover"]];
    [loginButton setImagePosition:NSImageOnly];
    [loginButton setBordered:NO];
    [loginButton setTarget:self];
    [loginButton setButtonType:NSMomentaryChangeButton];
    [loginButton setAction:@selector(doLogin)];
    
    [_window.contentView addSubview:loginButton];
    
    
}

- (void)setEventListState {
    // Reset other states
    
    [loginButton removeFromSuperview];
    [loginLogo removeFromSuperview];
    
    // Begin event list state
    
    
    [_window setBackgroundColor:[NSColor colorWithCalibratedRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:255.0/255.0]];
    
    /// Body
    
    eventsBody = [[NSImageView alloc] initWithFrame:NSMakeRect(800-528, 0, 528, 488)];
    eventsBody.image = [NSImage imageNamed:@"body"];
    [_window.contentView addSubview:eventsBody];
    
    /// Create Button
    
    createEventButton = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(580, (600-60)-26, 194, 60))];
//    createEventButton.title = @"Create Event +";
    createEventButton.image = [NSImage imageNamed:@"create-regular"];
    createEventButton.alternateImage = [NSImage imageNamed:@"create-hover"];
    [createEventButton setButtonType:NSMomentaryChangeButton];
    [createEventButton setImagePosition:NSImageOnly];
    [createEventButton setBordered:NO];
    [_window.contentView addSubview:createEventButton];
    
    /// Left Panel
    
    leftPanel  = [[APLLLeftPanelView alloc] init];
    [_window.contentView addSubview:leftPanel];
}

- (void)setEventPlayStateWithID:(NSString *)ID andTitle:(NSString*)title {
    NSLog(@"%@", ID);
    NSLog(@"%@", title);
    // Reset other states
    [leftPanel removeFromSuperview];
    [createEventButton removeFromSuperview];
    [eventsBody removeFromSuperview];
    NSMutableArray *removals = [[NSMutableArray alloc] init];
    for (NSView *view in [_window.contentView subviews])
        if ([view class] == [APLLTextField class])
            [removals addObject:view];
    
    for (NSView *view in removals)
        [view removeFromSuperview];
    
    // Begin event play state
    
    currentEventID = ID;
    
    [_window setBackgroundColor:[NSColor colorWithCalibratedRed:210.0/255.0 green:211.0/255.0 blue:213.0/255.0 alpha:255.0/255.0]];
    
//    /// Attendance view
//    APLLAttendanceView *attendanceView = [[APLLAttendanceView alloc] init];
//    [_window.contentView addSubview:attendanceView];
    
    /// Title view
    APLLEventTitleView *titleView = [[APLLEventTitleView alloc] initWithID:ID andTitle:title];
    [_window.contentView addSubview:titleView];
    
    /// Back button
    
    goBackButton = [[NSButton alloc] initWithFrame:NSMakeRect(800-32-144, 600-32-60, 144, 60)];
//    goBackButton.title = @"Return";
    goBackButton.image = [NSImage imageNamed:@"return-regular"];
    goBackButton.alternateImage = [NSImage imageNamed:@"return-hover"];
    [goBackButton setButtonType:NSMomentaryChangeButton];
    [goBackButton setImagePosition:NSImageOnly];
    [goBackButton setBordered:NO];
    [_window.contentView addSubview:goBackButton];
    
    
    /// Register party and upload library
    
    NSArray *songs = [APLLMusicManager getAllMusic];
    NSLog(@"%@", songs);
    [_sessionManager doRequest:API_AUTH_PARTY_URL_END(ID, @"/registerParty") withMethod:@"POST" andParameters:@{@"data": _libraries[currentEventID] = songs} andTarget:self andAction:@"updateSongs:"];
    
    /// Initialize playlist
    
    _playlists[ID] = [[NSMutableArray alloc] init];
}

- (void)updateSongs:(id)response {
    if (response) {
        NSUInteger oldCount = [_playlists[currentEventID] count];
        NSArray *updates = (NSArray *)response;
        if ([updates count] > 0) {
            BOOL contains = NO;
            for (NSDictionary *update in updates) {
                int i = 0;
                for (NSMutableDictionary *existing in _playlists[currentEventID]) {
                    if ([existing[@"SongId"] isEqualToString:update[@"SongId"]]) {
                        contains = YES;
                        long existingCount = [existing[@"Type"] integerValue];
                        long changeCount = [update[@"Type"] integerValue];
                        existingCount += changeCount;
                        if (i > 0) {
                            if (existingCount == 0) {
                                [_playlists[currentEventID] removeObject:existing];
                            }
                            else
                                existing[@"Type"] = [NSString stringWithFormat:@"%ld", existingCount];
                        }
                    }
                    i++;
                }
                if (!contains) {
                    NSMutableDictionary *addition = [update mutableCopy];
                    NSDictionary *moreInfo = [APLLMusicManager metadataForID:addition[@"SongId"] inEvent:currentEventID];
                    if (moreInfo)
                        for (NSString *key in moreInfo)
                            [addition setValue:moreInfo[key] forKey:key];
                    addition[@"Time"] = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
                    [_playlists[currentEventID] addObject:addition];
                }
            }
            
            if ([_playlists[currentEventID] count] > 1) {
                NSMutableArray *temp = [_playlists[currentEventID] mutableCopy];
                NSDictionary *firstItem = [temp objectAtIndex:0];
                [temp removeObjectAtIndex:0];
                temp = [[temp sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                    if ([obj1[@"Type"] integerValue] > [obj2[@"Type"] integerValue])
                        return NSOrderedAscending;
                    else if ([obj1[@"Type"] integerValue] == [obj2[@"Type"] integerValue]) {
                        if ([obj1[@"Time"] floatValue] > [obj2[@"Time"] floatValue])
                            return NSOrderedDescending;
                        else
                            return NSOrderedAscending;
                    } else
                        return NSOrderedDescending;
                }] mutableCopy];
                
                [temp insertObject:firstItem atIndex:0];
                
                _playlists[currentEventID] = temp;
            }
            
            [self updateSongsList];
        }
        NSUInteger newCount = [_playlists[currentEventID] count];
        if (oldCount == 0 && newCount == 1)
            [_playbackManager playTopInEvent:currentEventID];
    }
    [_sessionManager doRequest:API_AUTH_PARTY_URL_END(currentEventID, @"/update") withMethod:@"POST" andParameters:@{@"data": _playlists[currentEventID]} andTarget:self andAction:@"updateSongs:"];
//    NSLog(@"%@", _playlists);
}

- (void)updateSongsList {
    for (NSView *view in songItems) {
        [view removeFromSuperview];
    }
    
    songItemHeightCumul = 0;
    
    int i = 0;
    for (NSDictionary *song in _playlists[currentEventID]) {
        APLLSongItemView *songView = [[APLLSongItemView alloc] initWithOrigin:NSMakePoint(32, songItemHeightCumul += songItemHeight) andEventID:currentEventID andID:song[@"ID"] andItemType:i==0?1:i%2==1?2:3];
        [_window.contentView addSubview:songView];
        [songItems addObject:songView];
        i++;
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithDeviceRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:255.0/255.0] set];
    NSRectFill(dirtyRect);
}

#pragma mark Event Handlers

-(void)doLogin {
    [self setEventListState];
}

@end
