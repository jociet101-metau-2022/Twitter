//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, TweetCellDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    [self fetchData];
}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchData];
}

- (void)fetchData {
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = (NSMutableArray*)tweets;

            [self.tableView reloadData];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }

        [self.refreshControl endRefreshing];
    }];
}

- (void)didTweet:(Tweet *)tweet {
    [self fetchData];
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // Perform segue to profile view controller
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.arrayOfTweets[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString* senderType = [NSString stringWithFormat:@"%@", [sender class]];
    
    if ([senderType isEqualToString:@"UIButton"]) {
        
        UIButton* button = sender;
        UINavigationController *navigationController = [segue destinationViewController];
        
        if (button.titleLabel.text != nil) {
            ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
            composeController.delegate = self;
        }
    }
    else if ([senderType isEqualToString:@"TweetCell"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Tweet* data = self.arrayOfTweets[indexPath.row];
        TweetDetailsViewController *detailVC = [segue destinationViewController];
        detailVC.incomingData = data;
    }
    else if ([segue.identifier isEqualToString:@"profileSegue"]) {
        // Need to pass ID of tweet through here
        ProfileViewController *profileVC = [segue destinationViewController];
        User *user = sender;
        profileVC.userId = user.myId;
        profileVC.userHandle = user.screenName;
    }
}

@end
