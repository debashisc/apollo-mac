//
//  APLLSongItemView.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface APLLSongItemView : NSView

- (id)initWithOrigin:(NSPoint)point andEventID:(NSString *)eventID andID:(NSString *)ID andItemType:(int)itemType;

@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic) int itemType;

@end
