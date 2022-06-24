//
//  Tweet.m
//  twitter
//
//  Created by Jocelyn Tseng on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        NSLog(@"DICTIONARY! %@", dictionary);
        
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        
        if([dictionary valueForKey:@"full_text"] != nil) {
           self.text = dictionary[@"full_text"]; // uses full text if Twitter API provided it
       } else {
           self.text = dictionary[@"text"]; // fallback to regular text that Twitter API provided
       }
        
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.repliedTo = dictionary[@"reply_count"] > 0;

        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        self.rawCreatedAt = date;
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
        // Format createdAt date string
        NSString *dateForDetailsOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter2.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date2 = [formatter2 dateFromString:dateForDetailsOriginalString];
        // Configure output format
        formatter2.dateStyle = NSDateFormatterShortStyle;
        formatter2.timeStyle = NSDateFormatterShortStyle;
        // Convert Date to String
        self.dateForDetails = [formatter2 stringFromDate:date2];
        
    }
    return self;
}

- (instancetype)initWithSmallDictionary:(NSDictionary *)dictionary {
    
    self.text = dictionary[@"text"];
    
    // Format createdAt date string
    NSString *createdAtOriginalString = [dictionary[@"created_at"] substringToIndex:19];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"yyyy-MM-dd’T’hh:mm:ss";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    self.rawCreatedAt = date;
    
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    
    return tweets;
}

+ (NSMutableArray *)smallTweetsWithArray:(NSDictionary *)data {
    NSLog(@"%@", data);
    NSArray *dictionaries = data[@"data"];
    
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithSmallDictionary:dictionary];
        
        [tweets addObject:tweet];
    }
    
    return tweets;
}

@end
