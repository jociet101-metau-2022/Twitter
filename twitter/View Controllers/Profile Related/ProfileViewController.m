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

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* arrayOfTweets;
@property (nonatomic, strong) Profile* profileInfo;

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
    
    [[APIManager shared] getPersonProfileWithId:self.userId andHandle:self.userHandle completion:^(Profile *profile, NSError *error) {
         if(error){
              NSLog(@"Error getting person's profile: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully got profile");
             
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

- (void)fetchData {
    
    // Get timeline
    [[APIManager shared] getUserTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = (NSMutableArray*)tweets;
            
            [self.tableView reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.arrayOfTweets[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
