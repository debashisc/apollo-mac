//
//  APLLSongItemView.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLSongItemView.h"
#import "APLLMusicManager.h"
#import "APLLPlaybackManager.h"

@implementation APLLSongItemView

NSButton *toggle;

BOOL play = true;

- (id)initWithOrigin:(NSPoint)point andEventID:(NSString *)eventID andID:(NSString *)ID andItemType:(int)itemType;
{
    self = [super initWithFrame:CGRectMake(point.x, 600-112-point.y, 800-32*2, 64)];
    if (self) {
        NSDictionary *meta = [APLLMusicManager metadataForID:ID inEvent:eventID];
        NSTextField *titleLabel;
        titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(100, -20, self.frame.size.width-100*2, self.frame.size.height)];
        titleLabel.font = [NSFont fontWithName:@"Gotham" size:20.0];
        titleLabel.textColor = itemType == 1 ? [NSColor whiteColor] : [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        titleLabel.backgroundColor = [NSColor clearColor];
        titleLabel.drawsBackground = NO;
        [titleLabel setStringValue:[NSString stringWithFormat:@"%@ – %@", meta[@"title"], meta[@"artist"]]];
        [titleLabel setEditable:NO];
        [titleLabel setBezeled:NO];
        [self addSubview:titleLabel];
        
        if (itemType == 1) {
            toggle = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, 66, 64)];
            if ([[APP_DEL playbackManager] playing]) {
                toggle.image = [NSImage imageNamed:@"pause-regular"];
                toggle.alternateImage = [NSImage imageNamed:@"pause-hover"];
            } else {
                toggle.image = [NSImage imageNamed:@"play-regular"];
                toggle.alternateImage = [NSImage imageNamed:@"play-hover"];
            }
            [toggle setBordered:NO];
            [toggle setImagePosition:NSImageOnly];
            [toggle setButtonType:NSMomentaryChangeButton];
            [toggle setTarget:APP_DEL.playbackManager];
            [toggle setAction:@selector(toggle)];
            [self addSubview:toggle];
            
            APP_DEL.togglePlay = toggle;
        } else {
            
            NSDictionary *moreInfo = [APLLMusicManager playlistDataForID:meta[@"ID"] inEvent:eventID];
            
            NSTextField *pointsLabel;
            pointsLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(self.frame.size.width-100, -20, 100, self.frame.size.height)];
            pointsLabel.font = [NSFont fontWithName:@"Gotham" size:20.0];
            pointsLabel.textColor = itemType == 1 ? [NSColor whiteColor] : [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.4];
            pointsLabel.backgroundColor = [NSColor clearColor];
            pointsLabel.drawsBackground = NO;
            [pointsLabel setStringValue:[NSString stringWithFormat:@"%@ pts", moreInfo[@"Type"]]];
            [pointsLabel setEditable:NO];
            [pointsLabel setBezeled:NO];
            [self addSubview:pointsLabel];
            
        }
        _itemType = itemType;
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
    if (_itemType == 1)
        [[NSColor colorWithCalibratedRed:54.0/255.0 green:93.0/255.0 blue:152.0/255.0 alpha:1.0] set];
    else if (_itemType == 2)
        [[NSColor colorWithCalibratedRed:194.0/255.0 green:195.0/255.0 blue:197.0/255.0 alpha:1.0] set];
    else if (_itemType == 3)
        [[NSColor colorWithCalibratedRed:203.0/255.0 green:204.0/255.0 blue:206.0/255.0 alpha:1.0] set];
    NSRectFill([self bounds]);
}

@end
