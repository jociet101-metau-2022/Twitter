//
//  ComposeViewController.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetField;
@property (weak, nonatomic) NSString* placeholderText;
@property (weak, nonatomic) NSString* emptyText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initializing constant variables
    self.placeholderText = @"Compose tweet";
    self.emptyText = @"";

    self.tweetField.delegate = self;
    
    self.tweetField.text = self.placeholderText;
    self.tweetField.textColor = [UIColor lightGrayColor];
    self.tweetField.returnKeyType = UIReturnKeyDone;

//    [self.tweetField setPlaceholder:@"Compose Tweet"];

}

#pragma mark - Compose tweet placeholder text

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholderText]) {
        textView.text = self.emptyText;
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.emptyText]) {
        textView.text = self.placeholderText;
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return true;
}

- (IBAction)publishTweet:(id)sender {
//    postStatusWithText
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
