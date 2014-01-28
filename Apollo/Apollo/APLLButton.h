//
//  APLLButton.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import <Cocoa/Cocoa.h>

@interface APLLButton : NSButton

@property (nonatomic, retain) NSImage *regularImage;
@property (nonatomic, retain) NSImage *hoverImage;
@property (nonatomic, retain) NSImage *pressImage;

- (id)initWithRegularImage:(NSImage *)regularImage andHoverImage:(NSImage *)hoverImage andPressImage:(NSImage *)pressImage andOrigin:(NSPoint)origin;

@end
