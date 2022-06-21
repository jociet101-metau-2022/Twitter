//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;

//- (void)getUserTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
//- (void)favoriteTweet:(void(^)(NSArray *tweets, NSError *error))completion;
//- (void)retweet:(void(^)(NSArray *tweets, NSError *error))completion;

@end
