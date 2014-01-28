//
//  NSView+APLLView.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import "NSView+APLLView.h"

@implementation NSView (APLLView)

-(void)updateForAlignment:(APLLViewAlignType)alignType withOffset:(NSPoint)alignOffset {
    // Find origin for current alignment mode.
    NSPoint origin =
    (alignType == APLLViewAlignTypeTopLeft) ? NSMakePoint(0, 0) :
    (alignType == APLLViewAlignTypeTopRight) ? NSMakePoint(self.superview.frame.size.width - self.frame.size.width, 0) :
    (alignType == APLLViewAlignTypeCenter) ? NSMakePoint(self.superview.frame.size.width/2 - self.frame.size.width/2, self.superview.frame.size.height/2 - self.frame.size.height/2) :
    (alignType == APLLViewAlignTypeBottomLeft) ? NSMakePoint(0, self.superview.frame.size.height - self.frame.size.height) :
    /* APLLViewAlignTypeBottomRight */ NSMakePoint(self.superview.frame.size.width - self.frame.size.width, self.superview.frame.size.height - self.frame.size.height);
    
    [self setFrame:NSMakeRect(origin.x+alignOffset.x, origin.y+alignOffset.y, self.frame.size.width, self.frame.size.height)];
}

@end
