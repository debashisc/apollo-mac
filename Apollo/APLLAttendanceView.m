//
//  APLLAttendanceView.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLAttendanceView.h"

@implementation APLLAttendanceView

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect(0, 0, 240.0, 600.0);
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
    [[NSColor colorWithCalibratedRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0] set];
    NSRectFill([self bounds]);
}

@end
