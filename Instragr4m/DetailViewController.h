//
//  DetailViewController.h
//  Instragr4m
//
//  Created by powercarlos25 on 7/11/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
