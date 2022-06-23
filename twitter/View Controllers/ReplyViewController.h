//
//  ReplyViewController.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ReplyViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ReplyViewController : UIViewController

@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;
@property (nonatomic, strong) Tweet* incomingTweet;

@end

NS_ASSUME_NONNULL_END
