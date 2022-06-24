//
//  Profile.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Profile : NSObject

// MARK: Properties

@property (nonatomic, strong) NSString *profileImgUrl;
@property (nonatomic, strong) NSString *profileBannerUrl;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descriptText;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *folowersCount;
@property (nonatomic, strong) NSString *followingCount;
@property (nonatomic, strong) NSString *tweetsCount;
@property (nonatomic, strong) NSString *likesCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
