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
        self.profileBannerUrl = dictionary[@"profile_banner_url"];
        self.screenName = dictionary[@"screen_name"];
        self.name = dictionary[@"name"];
        self.descriptText = dictionary[@"description"];
        self.location = dictionary[@"location"];
        self.folowersCount = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.followingCount = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        self.tweetsCount = [NSString stringWithFormat:@"%@", dictionary[@"statuses_count"]];
        self.likesCount = [NSString stringWithFormat:@"%@", dictionary[@"favourites_count"]];
    }
    
    return self;
}

@end
