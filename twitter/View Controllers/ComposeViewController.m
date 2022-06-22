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
@property (weak, nonatomic) NSString* emptyText;
@property (assign, nonatomic) BOOL firstTimeEditing;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButt;
@property (weak, nonatomic) IBOutlet UILabel *numChars;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initializing constant variables
    self.emptyText = @"";
    
    self.firstTimeEditing = YES;

    self.tweetField.delegate = self;
    
    self.tweetField.textColor = [UIColor blackColor];
    
    self.tweetField.returnKeyType = UIReturnKeyDone;
//    [self.tweetField becomeFirstResponder];
    
    [self resetTweetButton];
    
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

- (void)resetTweetButton {
    self.tweetButt.tintColor = [UIColor lightGrayColor];
}

//- (void)

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (self.firstTimeEditing) {
        self.firstTimeEditing = NO;
        
        self.placeholderLabel.alpha = 0;
        
        self.tweetButt.tintColor = [UIColor systemBlueColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:self.emptyText]) {
        
        self.placeholderLabel.alpha = 1;
        
        [self resetTweetButton];
        self.firstTimeEditing = YES;
    }
    
    [textView endEditing:YES];
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return true;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (self.firstTimeEditing) {
        self.numChars.text = @"0";
    }
    else {
        self.numChars.text = [NSString stringWithFormat:@"%lu", [self.tweetField.text length]];
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
