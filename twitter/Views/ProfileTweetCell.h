//
//  ProfileTweetCell.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "DateTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTweetCell : UITableViewCell

@property (strong, nonatomic) Tweet* tweet;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* handle;
@property (strong, nonatomic) NSString* profileImgUrl;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;

- (void)setTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
