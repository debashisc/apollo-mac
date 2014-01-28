//
//  APLLLoginViewController.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import <Cocoa/Cocoa.h>
#import "APLLButton.h"

@interface APLLLoginViewController : NSViewController {
    NSImageView *logoView;
    APLLButton *loginButton;
}

- (void)doFacebookLogin:(id)sender;

@end
