//
//  Profile.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Profile.h"

@implementation Profile

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.profileImgUrl = dictionary[@"profile_image_url_https"];
        
        /*
         profile_banner_url
         screen_name
         name
         description
         location
         followers_count
         friends_count  //following
         statuses_count //number of tweets+retweets
         favourites_count
         */
        
    }
    
    return self;
}

@end
