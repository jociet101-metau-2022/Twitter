//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetDetailsViewControllerDelegate

- (void)didUpdate;

@end

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, strong) Tweet* incomingData;
@property (nonatomic, weak) id<TweetDetailsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
