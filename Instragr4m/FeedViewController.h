//
//  FeedViewController.h
//  Instragr4m
//
//  Created by powercarlos25 on 7/9/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *uploadedPosts;

-(void)loadFeed;

@end

NS_ASSUME_NONNULL_END
