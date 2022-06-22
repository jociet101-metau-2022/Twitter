//
//  TweetCell.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@interface TweetCell ()

@property (weak, nonatomic) IBOutlet UIButton *heartButt;
@property (weak, nonatomic) IBOutlet UIButton *retweetButt;

@end

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    NSLog(@"set tweet called");
    
    _tweet = tweet;
    
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetLabel.text = self.tweet.text;
    
    [self refreshUI];

    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImage setImage:[UIImage imageWithData:urlData]];
}

- (void)refreshUI {
    
    UIImage *tImg;
    
    if (self.tweet.favorited == YES) {
        NSLog(@"FAVORITED");
        tImg = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else {
        NSLog(@"NOT FAVORITED");
        tImg = [UIImage imageNamed:@"favor-icon.png"];
    }
    
    self.numHeartLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.heartButt setImage:tImg forState:UIControlStateNormal];
    
    UIImage *rImg;
    
    if (self.tweet.retweeted == YES) {
        NSLog(@"RETWEETED");
        rImg = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else {
        NSLog(@"NOT RETWEETED");
        rImg = [UIImage imageNamed:@"retweet-icon.png"];
    }
    
    self.numRetweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [self.retweetButt setImage:rImg forState:UIControlStateNormal];
}

- (IBAction)didTapFavorite:(id)sender {
    NSLog(@"Tapped favorite");
    
    // Update the local tweet model
    
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
    
    // Update cell UI
    [self refreshUI];
    
    // Send a POST request to the POST favorites/create endpoint
    APIManager* manager = [APIManager shared];
    
    if (self.tweet.favorited == YES) {
        [manager favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    else {
        [manager unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    NSLog(@"Tapped retweet");
    
    // Update the local tweet model
    
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
    }
    
    // Update cell UI
    [self refreshUI];
    
    // Send a POST request to the POST favorites/create endpoint
    APIManager* manager = [APIManager shared];
    
    if (self.tweet.retweeted == YES) {
        [manager retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    else {
        [manager unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

@end
