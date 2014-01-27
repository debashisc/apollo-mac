//
//  APLLTextField.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/25/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLTextField.h"

@implementation APLLTextField

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (NSArray *)trackingAreas
{
    return [NSArray array];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (NSView*)hitTest:(NSPoint)aPoint
{
    return NO;
}

@end
