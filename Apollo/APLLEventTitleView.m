//
//  APLLEventTitleView.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLEventTitleView.h"

@implementation APLLEventTitleView

NSTextField *titleLabel;
NSImageView *live;

- (id)initWithID:(NSString *)ID andTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect(0, 600-112, 800, 112);
        titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(33, 20, 800-33*2, 50)];
        titleLabel.font = [NSFont fontWithName:@"Gotham" size:24.0];
        titleLabel.textColor = [NSColor whiteColor];
        titleLabel.backgroundColor = [NSColor clearColor];
        titleLabel.drawsBackground = NO;
        [titleLabel setBordered:NO];
        [titleLabel setStringValue:title];
        [titleLabel setEditable:NO];
        [titleLabel setBezeled:NO];
        [self addSubview:titleLabel];
        
//        NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(800-50, <#CGFloat y#>, <#CGFloat w#>, <#CGFloat h#>)]
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
    [[NSColor colorWithCalibratedRed:58.0/255.0 green:59.0/255.0 blue:63.0/255.0 alpha:1.0] set];
    NSRectFill([self bounds]);
}

@end
