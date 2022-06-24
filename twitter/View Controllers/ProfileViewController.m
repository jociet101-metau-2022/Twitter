//
//  ProfileViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[APIManager shared] getCredentialsWithCompletion:^(Profile* profile, NSError* error) {
         if(error){
              NSLog(@"Error getting credentials: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully got credentials");
             
             NSURL *url = [NSURL URLWithString:profile.profileImgUrl];
             NSData *urlData = [NSData dataWithContentsOfURL:url];
             [self.profileImage setImage:[UIImage imageWithData:urlData]];
         }
     }];
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
