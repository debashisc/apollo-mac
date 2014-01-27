//
//  APLLLeftPanelViewController.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#import "APLLLeftPanelView.h"
#import <QuartzCore/QuartzCore.h>
#import "APLLSessionManager.h"
#import "APLLTextField.h"

@interface APLLLeftPanelView ()

@end

@implementation APLLLeftPanelView

int eventButtonHeight = 70;
int eventButtonHeightTotal = 181-70;
NSMutableArray *events;
APLLSessionManager *sessionManager;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSRectFromCGRect(CGRectMake(0, 0, 272, 600));
        
        events = [[NSMutableArray alloc] init];
        
        sessionManager = [APP_DEL sessionManager];
        [sessionManager doRequest:API_AUTH_URL_END(@"/getParties") withMethod:@"GET" andParameters:nil andTarget:self andAction:@"loadEvents:"];
        
        NSImageView *imageView = [[NSImageView alloc] initWithFrame:self.bounds];
        imageView.image = [NSImage imageNamed:@"sidebar"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)addEventWithName:(NSString *)name andID:(NSString *)ID andTime:(NSString *)time {
    [events addObject:@{@"Title": name, @"ID": ID, @"Button": [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, (eventButtonHeightTotal += eventButtonHeight), self.frame.size.width, eventButtonHeight))]}];
    [[sessionManager events] addObject:@{@"Title": name, @"ID": ID, @"Time": time}];
    NSButton *btn = [events lastObject][@"Button"];
//    btn.title = [events lastObject][@"Title"];
    btn.title = @"";
    btn.tag = [events count]-1;
    btn.font = [NSFont fontWithName:@"Gotham Rounded Light" size:14.0];
    btn.alignment = NSLeftTextAlignment;
//    [btn setTransparent:YES];
    [btn setTarget:self];
    [btn setAction:@selector(enterEvent:)];
    [btn setBordered:NO];
    [[btn cell] setBackgroundColor:[NSColor colorWithDeviceRed:56.0/255.0 green:57.0/255.0 blue:61.0/255.0 alpha:255.0/255.0]];
    [self addSubview:btn];
    // 240, 112
//    
//    NSMutableAttributedString *colorTitle =
//    
//    [[NSMutableAttributedString alloc] initWithAttributedString:[btn attributedTitle]];
//    
//    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
//    
//    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
//    
//    [btn setAttributedTitle:colorTitle];
    
    APLLTextField *textField = [[APLLTextField alloc] initWithFrame:NSMakeRect(btn.frame.origin.x+30, btn.frame.origin.y, btn.frame.size.width-30*2, btn.frame.size.height)];
    [textField setStringValue:[events lastObject][@"Title"]];
    [textField setBackgroundColor:[NSColor clearColor]];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setBezeled:NO];
    [textField setFont:[NSFont fontWithName:@"Gotham Rounded Light" size:15.0]];
    [textField setTextColor:[NSColor colorWithDeviceRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:255.0/255.0]];

    [_window.contentView addSubview:textField];
}

- (void)loadEvents:(id)response {
    NSLog(@"...");
    [events removeAllObjects];
    [[sessionManager events] removeAllObjects];
    NSDictionary *eventResults = (NSDictionary *)response;
    for (NSDictionary *event in eventResults[@"data"]) {
        NSLog(event[@"name"]);
        [self addEventWithName:event[@"name"] andID:event[@"id"] andTime:event[@"start_time"]];
    }
}

- (void)enterEvent:(NSButton *)btn {
    [APP_DEL setEventPlayStateWithID:events[btn.tag][@"ID"] andTitle:events[btn.tag][@"Title"]];
}

@end
