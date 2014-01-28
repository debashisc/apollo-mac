//
//  APLLButton.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import "APLLButton.h"

@implementation APLLButton

- (id)initWithRegularImage:(NSImage *)regularImage andHoverImage:(NSImage *)hoverImage andPressImage:(NSImage *)pressImage andOrigin:(NSPoint)origin
{
    self = [super initWithFrame:NSMakeRect(origin.x, origin.y, regularImage.size.width, regularImage.size.height)];
    if (self) {
        self.image = _regularImage = regularImage;
        self.alternateImage = _pressImage = pressImage;
        _hoverImage = hoverImage;
        [self addTrackingRect:self.bounds owner:self userData:NULL assumeInside:YES];
        [self setBordered:NO];
        [self setButtonType:NSMomentaryChangeButton];
    }
    return self;
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [super mouseEntered:theEvent];
    
    self.image = _hoverImage;
}

- (void)mouseExited:(NSEvent *)theEvent {
    [super mouseExited:theEvent];
    
    self.image = _regularImage;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
