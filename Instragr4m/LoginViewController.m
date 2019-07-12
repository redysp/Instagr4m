//
//  ViewController.m
//  Instragr4m
//
//  Created by powercarlos25 on 7/8/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerUser:(id)sender {
    // Goes to the sign-up view controller
    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"successLoginSegue" sender:nil];
        }
    }];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:(YES)];
}

@end
