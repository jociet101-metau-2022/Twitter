//
//  ReplyViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"

@interface ReplyViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetField;
@property (weak, nonatomic) NSString* emptyText;
@property (strong, nonatomic) NSString* tweetId;
@property (strong, nonatomic) NSString* replyingToName;
@property (assign, nonatomic) BOOL firstTimeEditing;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButt;
@property (weak, nonatomic) IBOutlet UILabel *numChars;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initializing constant variables
    self.emptyText = @"";
    
    self.firstTimeEditing = YES;

    self.tweetField.delegate = self;
    self.tweetField.textColor = [UIColor whiteColor];
    self.tweetField.returnKeyType = UIReturnKeyDone;
    
    self.tweetId = self.incomingTweet.idStr;
    self.replyingToName = [@"@" stringByAppendingString:self.incomingTweet.user.screenName];
    self.handleLabel.text = self.replyingToName;
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (self.firstTimeEditing) {
        self.firstTimeEditing = NO;
        
        self.tweetButt.tintColor = [UIColor systemBlueColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:self.emptyText]) {
        
        [self resetTweetButton];
        self.firstTimeEditing = YES;
    }
    
    [textView endEditing:YES];
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return true;
    }
    
    return true;
}

- (void)textViewDidChange:(UITextView *)textView {

    int characterLimit = 280;

    // Construct what the new text would be if we allowed the user's latest edit
    long numCharsInt = [self.tweetField.text length];
    
    // Update character count label
    self.numChars.text = [NSString stringWithFormat:@"%lu", numCharsInt];

    // Should the new text should be allowed? True/False
    BOOL textAllowed = numCharsInt <= characterLimit;
    
    if (textAllowed == NO) {
        self.numChars.textColor = [UIColor redColor];
        [self resetTweetButton];
    }
    else {
        self.numChars.textColor = [UIColor whiteColor];
        self.tweetButt.tintColor = [UIColor systemBlueColor];
    }
}

- (IBAction)publishTweet:(id)sender {
    
    NSString* tweetBody = [self.replyingToName stringByAppendingString:[@" " stringByAppendingString:self.tweetField.text]];
    
    APIManager* manager = [APIManager new];
    [manager postReplyWithText:(NSString *)tweetBody andId:(NSString *)self.tweetId completion:^(Tweet *tweet, NSError *error) {

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
