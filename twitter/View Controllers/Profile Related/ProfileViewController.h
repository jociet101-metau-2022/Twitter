//
//  ProfileViewController.h
//  twitter
//
//  Created by Jocelyn Tseng on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userHandle;

@end

NS_ASSUME_NONNULL_END
