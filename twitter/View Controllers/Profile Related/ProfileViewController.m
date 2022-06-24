//
//  ProfileViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "ProfileTweetCell.h"
#import "Tweet.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* arrayOfTweets;
@property (nonatomic, strong) Profile* profileInfo;

@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self clearPage];
    
    [[APIManager shared] getPersonProfileWithId:self.userId andHandle:self.userHandle completion:^(Profile *profile, NSError *error) {
         if(error){
              NSLog(@"Error getting person's profile: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully got profile");
             
             self.profileInfo = profile;
             
             [self revealPage];
             
             NSURL *url = [NSURL URLWithString:profile.profileImgUrl];
             NSData *urlData = [NSData dataWithContentsOfURL:url];
             [self.profileImage setImage:[UIImage imageWithData:urlData]];
             
             NSURL *url2 = [NSURL URLWithString:profile.profileBannerUrl];
             NSData *urlData2 = [NSData dataWithContentsOfURL:url2];
             [self.bannerImage setImage:[UIImage imageWithData:urlData2]];
             
             self.nameLabel.text = profile.name;
             self.handleLabel.text = [@"@" stringByAppendingString:profile.screenName];
             self.numFollowingLabel.text = [profile.followingCount stringByAppendingString:@" Following"];
             self.numFollowersLabel.text = [profile.folowersCount stringByAppendingString:@" Followers"];
             self.descriptionLabel.text = profile.descriptText;
             
         }
     }];
    
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchData];
}

- (void)clearPage {
    self.nameLabel.alpha = 0;
    self.handleLabel.alpha = 0;
    self.descriptionLabel.alpha = 0;
    self.numFollowersLabel.alpha = 0;
    self.numFollowingLabel.alpha = 0;
    self.profileView.alpha = 0;
}

- (void)revealPage {
    self.nameLabel.alpha = 1;
    self.handleLabel.alpha = 1;
    self.descriptionLabel.alpha = 1;
    self.numFollowersLabel.alpha = 1;
    self.numFollowingLabel.alpha = 1;
    self.profileView.alpha = 1;
}


- (void)fetchData {
    
    // Get timeline
    
    [[APIManager shared] getPersonTimelineWithId:self.userId completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded person timeline");
            self.arrayOfTweets = (NSMutableArray*)tweets;
            
            [self.tableView reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting person timeline: %@", error.localizedDescription);
        }
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTweetCell"];
    
    cell.name = self.nameLabel.text;
    cell.handle = self.handleLabel.text;
    cell.profileImgUrl = self.profileInfo.profileImgUrl;
    cell.tweet = self.arrayOfTweets[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
