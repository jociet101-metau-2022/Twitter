//
//  ProfileTweetCell.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileTweetCell.h"
#import "DateTools.h"

@implementation ProfileTweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    
    self.nameLabel.text = self.name;
    self.handleLabel.text = self.handle;
    self.tweetLabel.text = self.tweet.text;
    
    // Use DateTools to get time ago of a tweet
    self.dateLabel.text = [self.tweet.rawCreatedAt shortTimeAgoSinceNow];
    
    NSString *URLString = self.profileImgUrl;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImage setImage:[UIImage imageWithData:urlData]];
    
}

@end
