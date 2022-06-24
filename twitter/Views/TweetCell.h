//
//  TweetCell.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "DateTools.h"
#import "TweetCell.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) Tweet* tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *numHeartLabel;

- (void)setTweet:(Tweet *)tweet;

@property (nonatomic, weak) id<TweetCellDelegate> delegate;

@end

@protocol TweetCellDelegate

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user;

@end

NS_ASSUME_NONNULL_END
