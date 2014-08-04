//
//  ViewController.m
//  XINGAPISample
//
//  Created by macuser2 on 8/4/14.
//  Copyright (c) 2014 macuser2. All rights reserved.
//

#import "ViewController.h"
#import "XNGAPI.h"
#import "XNGLoginWebViewController.h"

@interface ViewController ()

@property(nonatomic, strong)XNGLoginWebViewController *loginViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    XNGAPIClient *client = [XNGAPIClient sharedClient];
    if ([client isLoggedin] == NO) {
        [self setupLoginButton];
    } else {
        [self setupLogoutButton];
        [self loadContacts];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MISC
-(void)setupLoginButton
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(onLoginClickAction)];
    
    
    self.navigationItem.rightBarButtonItem = barBtn;
}

-(void)setupLogoutButton
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(onLogoutClickAction)];
    
    
    self.navigationItem.rightBarButtonItem = barBtn;
}


-(void)loadContacts
{
    [self getContactsWithSuccess:^(id JSON){
        
        NSLog(@"JSON:%@", JSON);
        
    }Failure:^(NSError *error){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
}
#pragma mark - Button Action
-(void)onLoginClickAction
{
    __weak __typeof(&*self)weakSelf = self;

    [[XNGAPIClient sharedClient] loginOAuthAuthorize:^(NSURL *url){
        weakSelf.loginViewController = [[XNGLoginWebViewController alloc] initWithAuthURL:url];
        
        UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:weakSelf.loginViewController];
        
        [self presentViewController:navCont animated:YES completion:nil];
        
    }loggedIn:^{
        [weakSelf setupLogoutButton];
        [weakSelf loadContacts];
        
        if (![weakSelf.presentedViewController isBeingDismissed]) {
            [weakSelf.loginViewController dismiss];
        }
        
    }failuire:^(NSError *error){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        if (![weakSelf.presentedViewController isBeingDismissed]) {
            [weakSelf.loginViewController dismiss];
        }
    }];
}

-(void)onLogoutClickAction
{
    [[XNGAPIClient sharedClient] logout];
    [self setupLoginButton];
}


#pragma mark - XING API
-(void)getContactsWithSuccess:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *theDict = [NSMutableDictionary dictionary];
    [theDict setValue:@"display_name,id,birth_date" forKey:@"user_fields"];
    
    [[XNGAPIClient sharedClient] getJSONPath:@"/v1/users/me/contacts" parameters:theDict success:success failure:failure];
}
@end
