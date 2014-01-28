//
//  NSView+APLLView.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import <Cocoa/Cocoa.h>

typedef enum {
    APLLViewAlignTypeCenter,
    APLLViewAlignTypeTopLeft,
    APLLViewAlignTypeTopRight,
    APLLViewAlignTypeBottomLeft,
    APLLViewAlignTypeBottomRight
} APLLViewAlignType;

@interface NSView (APLLView)

-(void)updateForAlignment:(APLLViewAlignType)alignType withOffset:(NSPoint)alignOffset;

@end
