//
//  APLLEventTitleView.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface APLLEventTitleView : NSView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *ID;

- (id)initWithID:(NSString *)ID andTitle:(NSString *)title;

@end
