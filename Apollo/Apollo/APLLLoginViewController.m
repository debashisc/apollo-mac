//
//  APLLLoginViewController.m
//  Apollo
//
//  Created by Dev Chakraborty on 1/27/2014.
//
//

#import "APLLLoginViewController.h"
#import "NSView+APLLView.h"
#import <Accounts/Accounts.h>

@interface APLLLoginViewController ()

@end

@implementation APLLLoginViewController

- (id)init
{
    if (self = [super init]) {
        self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, APLL_DEFAULT_WIDTH, APLL_DEFAULT_HEIGHT)];

        logoView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 224, 65)];
        logoView.image = [NSImage imageNamed:@"apollo-logo"];
        [self.view addSubview:logoView];
        [logoView updateForAlignment:APLLViewAlignTypeCenter withOffset:NSMakePoint(0, 66)];
        logoView.alphaValue = 0.0;
        
        loginButton = [[APLLButton alloc] initWithRegularImage:[NSImage imageNamed:@"login-regular"] andHoverImage:[NSImage imageNamed:@"login-hover"] andPressImage:[NSImage imageNamed:@"login-press"] andOrigin:NSMakePoint(0, 0)];
        [self.view addSubview:loginButton];
        [loginButton updateForAlignment:APLLViewAlignTypeCenter withOffset:NSMakePoint(0, -59)];
        loginButton.alphaValue = 0.0;
        [loginButton setTarget:self];
        [loginButton setAction:@selector(doFacebookLogin:)];
        
        // Initial animation
        
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:2.0];
        [[logoView animator] setAlphaValue:1.0];
        [[loginButton animator] setAlphaValue:1.0];
        [NSAnimationContext endGrouping];
    }
    return self;
}

- (void)doFacebookLogin:(id)sender {
    ACAccountStore *store = [[ACAccountStore alloc] init];
    [store requestAccessToAccountsWithType:[store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] options:@{ACFacebookAppIdKey: @"394268597375808", ACFacebookPermissionsKey: @[@"user_about_me", @"user_events"]} completion:^(BOOL granted, NSError *error) {
        if (error)
            NSLog(@"%@", [error localizedDescription]);
        else {
            NSLog(@"Facebook access granted.");
            ACAccount *account = [[store accountsWithAccountType:[store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook]] objectAtIndex:0];
            ACAccountCredential *credential = [account credential];
            APLL_DEL.fbAuthToken = [credential oauthToken];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"APLL_FB_LOGIN" object:nil];
        }
    }];
}

@end
