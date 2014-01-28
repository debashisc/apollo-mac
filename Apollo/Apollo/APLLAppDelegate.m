//
//  APLLAppDelegate.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import "APLLAppDelegate.h"
#import "APLLLoginViewController.h"

@implementation APLLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // Main window options
    
    NSRect e = [[NSScreen mainScreen] frame];
    [_window setFrame:NSMakeRect(e.size.width/2-APLL_DEFAULT_WIDTH/2, e.size.height/2-APLL_DEFAULT_HEIGHT/2, APLL_DEFAULT_WIDTH, APLL_DEFAULT_HEIGHT) display:NO];
    
    [_window setCollectionBehavior:
     NSWindowCollectionBehaviorFullScreenPrimary];
    [_window setMinSize:NSMakeSize(APLL_DEFAULT_WIDTH, APLL_DEFAULT_HEIGHT)];
    
    [_window setBackgroundColor:[NSColor colorWithCalibratedRed:54.0/255.0 green:55.0/255.0 blue:58.0/255.0 alpha:255.0/255.0]];
    
//    NSViewController *vc = [[NSViewController alloc] init];

    loginVC = [[APLLLoginViewController alloc] init];
    [_window.contentView addSubview:loginVC.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin) name:@"APLL_FB_LOGIN" object:nil];
}

-(void)didLogin {
    NSLog(@"Logged in.");
}

@end
