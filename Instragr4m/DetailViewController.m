//
//  DetailViewController.m
//  Instragr4m
//
//  Created by powercarlos25 on 7/11/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsUserView;
@property (weak, nonatomic) IBOutlet UILabel *detailsCaptionView;
@property (weak, nonatomic) IBOutlet UILabel *detailsTimeView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Get image by converting it as PFObject
    
    PFFileObject *picture = self.post.image;
    
    [picture getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        if (!error){
            self.detailsImageView.image = [UIImage imageWithData:imageData];
        }
    }];
    
    self.detailsCaptionView.text = self.post.caption;
    
    
    NSDate *createdDate = self.post.createdAt;
    
    // Format NSDate and view as string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
    NSString *dateString = [dateFormatter stringFromDate:createdDate];
    
    self.detailsTimeView.text = dateString;
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
