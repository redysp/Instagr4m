//
//  FeedViewController.m
//  Instragr4m
//
//  Created by powercarlos25 on 7/9/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "FeedCell.h"
#import "Post.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    PFQuery *query = [Post query];
    //[query orderByDescending:@"createdAt"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.uploadedPosts = [[NSMutableArray alloc] initWithArray:posts];
            
            // Reload table view with messages
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (IBAction)logoutUser:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    PFObject *eachUpload = self.uploadedPosts[indexPath.row];
    PFUser *user = eachUpload[@"user"];
    
    cell.postedImageView.image = eachUpload[@"image"];
    cell.postedCaptionView.text = eachUpload[@"caption"];
    //cell.
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uploadedPosts.count;
}


@end
