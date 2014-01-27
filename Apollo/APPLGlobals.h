//
//  APPLGlobals.h
//  Apollo
//
//  Created by Dev Chakraborty on 1/24/2014.
//  Copyright (c) 2014 Apollo. All rights reserved.
//

#ifndef Apollo_APPLGlobals_h
#define Apollo_APPLGlobals_h

#define API_URL_STRING          @"http://apollo.mantasmatelis.com"
#define API_AUTH_TOKEN          @"CAACEdEose0cBAEYJV1MXWjOFIr6CLaG4l2eFZC33v7PjjAqTrBNe3EZAYa0cFXt4MLT3eF1HcUlQDHw7T23WgIY8e0AB9f09Ds3bCCO8ZAmxB1gfB5u03xUm3cb6ZA1IHBwAEZAze99F3TtIkl6TZB0bDH8GZBkpVYZCrmg5UZASOYeihZALmg1bHl1U8AkhMFRfUZD"

#define API_AUTH_PARTY_URL_END(A, B)          [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@%@", API_URL_STRING, API_AUTH_TOKEN, A, B]]
#define API_AUTH_URL_END(A)          [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@%@", API_URL_STRING, API_AUTH_TOKEN, A]]
#define API_URL_END(A)               [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_URL_STRING, A]]

#import "APLLAppDelegate.h"
#define APP_DEL            ((APLLAppDelegate*)[[NSApplication sharedApplication] delegate])

#define MUSIC_PATH          @"/Users/dev/Music"

#endif
