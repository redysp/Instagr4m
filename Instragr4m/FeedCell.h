//
//  FeedCell.h
//  Instragr4m
//
//  Created by powercarlos25 on 7/9/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
//@import ParseUI;

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postedImageView;
@property (weak, nonatomic) IBOutlet UILabel *postedCaptionView;
@property (weak, nonatomic) IBOutlet UILabel *timeStampView;
@property (weak, nonatomic) IBOutlet UILabel *userView;


@property (strong, nonatomic) Post *post; 

@end

NS_ASSUME_NONNULL_END
