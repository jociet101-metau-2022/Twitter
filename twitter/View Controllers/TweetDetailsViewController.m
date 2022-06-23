//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statisticsLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButt;
@property (weak, nonatomic) IBOutlet UIButton *heartButt;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.incomingData.user.name;
    self.handleLabel.text = [@"@" stringByAppendingString:self.incomingData.user.screenName];
    self.dateLabel.text = self.incomingData.dateForDetails;
    self.tweetText.text = self.incomingData.text;
    
    self.statisticsLabel.text = [NSString stringWithFormat:@"%d Retweets  %d Likes", self.incomingData.retweetCount, self.incomingData.favoriteCount];
    self.statisticsLabel.textColor = [UIColor darkGrayColor];
    
    [self refreshUI];

    NSString *URLString = self.incomingData.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImage setImage:[UIImage imageWithData:urlData]];
    
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.incomingData.favorited == NO) {
        self.incomingData.favorited = YES;
        self.incomingData.favoriteCount += 1;
    }
    else {
        self.incomingData.favorited = NO;
        self.incomingData.favoriteCount -= 1;
    }
    
    // Update cell UI
    [self refreshUI];
    
    // Send a POST request to the POST favorites endpoint
    APIManager* manager = [APIManager shared];
    
    if (self.incomingData.favorited == YES) {
        [manager favorite:self.incomingData completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    else {
        [manager unFavorite:self.incomingData completion:^(Tweet *tweet, NSError *error) {
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
    if (self.incomingData.retweeted == NO) {
        self.incomingData.retweeted = YES;
        self.incomingData.retweetCount += 1;
    }
    else {
        self.incomingData.retweeted = NO;
        self.incomingData.retweetCount -= 1;
    }
    
    // Update cell UI
    [self refreshUI];
    
    // Send a POST request to the POST retweet endpoint
    APIManager* manager = [APIManager shared];
    
    if (self.incomingData.retweeted == YES) {
        [manager retweet:self.incomingData completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    else {
        [manager unRetweet:self.incomingData completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void)refreshUI {
    
    self.statisticsLabel.text = [NSString stringWithFormat:@"%d Retweets  %d Likes", self.incomingData.retweetCount, self.incomingData.favoriteCount];
    
    UIImage *tImg;
    
    if (self.incomingData.favorited == YES) {
        tImg = [UIImage imageNamed:@"heart-icon-1-red.png"];
    }
    else {
        tImg = [UIImage imageNamed:@"heart-icon-1.png"];
    }
    
    [self.heartButt setImage:tImg forState:UIControlStateNormal];
    
    UIImage *rImg;
    
    if (self.incomingData.retweeted == YES) {
        rImg = [UIImage imageNamed:@"retweet-icon-1-green.png"];
    }
    else {
        rImg = [UIImage imageNamed:@"retweet-icon-1.png"];
    }
    
    [self.retweetButt setImage:rImg forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
