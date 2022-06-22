//
//  ComposeViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Profile.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetField;
@property (weak, nonatomic) NSString* placeholderText;
@property (weak, nonatomic) NSString* emptyText;
@property (assign, nonatomic) BOOL firstTimeEditing;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initializing constant variables
    self.placeholderText = @"What's happening?";
    self.emptyText = @"";
    
    self.firstTimeEditing = YES;

    self.tweetField.delegate = self;
    
    self.tweetField.text = self.placeholderText;
    self.tweetField.textColor = [UIColor lightGrayColor];
    self.tweetField.returnKeyType = UIReturnKeyDefault;
    [self.tweetField becomeFirstResponder];
    
    [self resetCursor];
    
    [[APIManager shared] getCredentialsWithCompletion:^(Profile* profile, NSError* error) {
         if(error){
              NSLog(@"Error getting credentials: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully got credentials");
             
             NSURL *url = [NSURL URLWithString:profile.profileImgUrl];
             NSData *urlData = [NSData dataWithContentsOfURL:url];
             [self.profileImage setImage:[UIImage imageWithData:urlData ]];
         }
     }];
}

#pragma mark - Compose tweet placeholder text

- (void)resetCursor {
    UITextPosition* pos = [self.tweetField beginningOfDocument];
    UITextRange* range = [self.tweetField textRangeFromPosition:pos toPosition:pos];
    [self.tweetField setSelectedTextRange:range];
}

- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"text view did change");
    
    if (self.firstTimeEditing) {
        self.firstTimeEditing = NO;
        textView.text = self.emptyText;
        textView.textColor = [UIColor blackColor];
    }
    else if ([textView.text isEqualToString:self.emptyText]) {
        textView.text = self.placeholderText;
        textView.textColor = [UIColor lightGrayColor];
        [self resetCursor];
        self.firstTimeEditing = YES;
    }
}

- (IBAction)publishTweet:(id)sender {
    
    NSString* tweetBody = self.tweetField.text;
    
    APIManager* manager = [APIManager new];
    [manager postStatusWithText:(NSString *)tweetBody completion:^(Tweet *tweet, NSError *error) {
        
        if (error != nil) {
            NSString* errorName = [NSString stringWithFormat:@"%@", [error localizedDescription]];
            NSLog(@"%@", errorName);
        }
        else {
            [self.delegate didTweet:tweet];
            
            NSLog(@"tweet successfully published");
            
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (IBAction)closeEditing:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
