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
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadFeed];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadFeed)forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

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

-(void)loadFeed{
    PFQuery *query = [Post query];
    //[query orderByDescending:@"createdAt"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.uploadedPosts = [[NSMutableArray alloc] initWithArray:posts];
            
            // Reload table view with messages
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    [self.refreshControl endRefreshing];

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
    Post *eachUpload = self.uploadedPosts[indexPath.row];
    //PFUser *user = eachUpload[@"user"];
    PFFileObject *picture = eachUpload.image;
    
    [picture getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        if (!error){
            cell.postedImageView.image = [UIImage imageWithData:imageData];
        }
    }];
    cell.postedCaptionView.text = eachUpload[@"caption"];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uploadedPosts.count;
}


@end
