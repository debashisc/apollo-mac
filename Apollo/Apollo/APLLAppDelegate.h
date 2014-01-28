//
//  APLLAppDelegate.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#ifndef Apollo_APLLAppDelegate_h
#define Apollo_APLLAppDelegate_h

#import <Cocoa/Cocoa.h>
#import "APLLLoginViewController.h"

@interface APLLAppDelegate : NSObject <NSApplicationDelegate> {
    APLLLoginViewController *loginVC;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSString *fbAuthToken;

@end

#endif