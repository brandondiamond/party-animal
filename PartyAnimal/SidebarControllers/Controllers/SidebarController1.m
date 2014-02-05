//
//  SidebarController1.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "User.h"
#import "SidebarController1.h"
#import "SidebarCell1.h"
#import "FlatTheme.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBURLConnection.h"
#import "FBUtility.h"
#import <QuartzCore/QuartzCore.h>

@interface SidebarController1 ()

@property (nonatomic, strong) NSArray* items;
@property (weak, atomic) User* current_user;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation SidebarController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
        
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.current_user = [User currentUser];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor clearColor];
    
    NSString* boldFontName = @"Avenir-Black";
    NSString* fontName = @"Avenir-BlackOblique";
    
    self.profileNameLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.profileNameLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    self.profileNameLabel.text = [[User currentUser] name];
    
    
    self.profileLocationLabel.textColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.profileLocationLabel.font = [UIFont fontWithName:fontName size:12.0f];
    self.profileLocationLabel.text = @"London, UK";
    
    self.logoutLink.font = [UIFont fontWithName:fontName size:12.0f];
  
    
    self.profileImageView.image = [self.current_user profile_picture];
    
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 2.0f;
    self.profileImageView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;
    self.profileImageView.layer.cornerRadius = 10.0f;
    
    [self setRoundedView:self.profileImageView toDiameter:50];
    

    NSDictionary* object1 = [NSDictionary dictionaryWithObjects:@[ @"Feed", @"7", @"arrow"] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object2 = [NSDictionary dictionaryWithObjects:@[ @"Inbox", @"7", @"envelope"] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object3 = [NSDictionary dictionaryWithObjects:@[ @"Updates", @"7", @"check"] forKeys:@[ @"title", @"count", @"icon"]];
    NSDictionary* object4 = [NSDictionary dictionaryWithObjects:@[ @"Account", @"0", @"account"] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object5 = [NSDictionary dictionaryWithObjects:@[ @"Settings", @"0", @"settings"] forKeys:@[ @"title", @"count", @"icon"]];
    
    self.items = @[object1, object2, object3, object4, object5];

}

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.items.count;
}

-(UITapGestureRecognizer*)getGestureRecognizerFor:(NSString *)title{
    UITapGestureRecognizer *tapGesture;

    if([title isEqualToString:@"Feed"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewFeed:)];
    else if([title isEqualToString:@"Inbox"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewProfile:)];
    else if([title isEqualToString:@"Updates"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewProfile:)];
    else if([title isEqualToString:@"Account"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewProfile:)];
    else if([title isEqualToString:@"Settings"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewSettings:)];
    else if([title isEqualToString:@"Logout"])
        tapGesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self action:@selector(viewProfile:)];
    
    
    return tapGesture;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SidebarCell1* cell = [tableView dequeueReusableCellWithIdentifier:@"SidebarCell1"];
    
    NSDictionary* item = self.items[indexPath.row];
    NSString* count = item[@"count"];
    NSString* title = item[@"title"];
    NSString* icon = item[@"icon"];
    
    cell.titleLabel.text = title;
    cell.iconImageView.image = [UIImage imageNamed:icon];

    [cell addGestureRecognizer: [self getGestureRecognizerFor:title]];
    
    if(![count isEqualToString:@"0"])
        cell.countLabel.text = count;
    else
        cell.countLabel.alpha = 0;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

-(void)viewProfile:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"view profile");
    UIStoryboard* profileStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    UIViewController *profileVC = [profileStoryboard instantiateViewControllerWithIdentifier:@"ProfileController"];
    
    profileVC.navigationItem.leftBarButtonItem = self.mainSideViewController.menuItem;
    
    [(UINavigationController*)self.mainSideViewController.contentViewController setViewControllers:[NSArray arrayWithObject:profileVC] animated:YES];
    
    [self.mainSideViewController styleNavigationBarWithFontName:@"Avenir-Black" withNavItem:profileVC.navigationItem];

    [self.mainSideViewController toggleSidebar:!self.mainSideViewController.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

-(void)viewFeed:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"view feed");
    UIStoryboard* feedStoryboard = [UIStoryboard storyboardWithName:@"FeedStoryboard" bundle:nil];
    UIViewController *feedVC = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedController"];


    feedVC.view.backgroundColor = [UIColor blackColor];
    feedVC.navigationItem.leftBarButtonItem = self.mainSideViewController.menuItem;
    
    [(UINavigationController*)self.mainSideViewController.contentViewController setViewControllers:[NSArray arrayWithObject:feedVC] animated:YES];
    
    [self.mainSideViewController styleNavigationBarWithFontName:@"Avenir-Black" withNavItem:feedVC.navigationItem];
    [self.mainSideViewController toggleSidebar:!self.mainSideViewController.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];

}


-(void)viewSettings:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"view settings");
    UIStoryboard* feedStoryboard = [UIStoryboard storyboardWithName:@"SettingsStoryboard" bundle:nil];
    UIViewController *profileVC = [feedStoryboard instantiateViewControllerWithIdentifier:@"SettingsController"];
        
    profileVC.navigationItem.leftBarButtonItem = self.mainSideViewController.menuItem;
    
    
    [(UINavigationController*)self.mainSideViewController.contentViewController setViewControllers:[NSArray arrayWithObject:profileVC] animated:YES];
    [self.mainSideViewController styleNavigationBarWithFontName:@"Avenir-Black" withNavItem:profileVC.navigationItem];
    
    [self.mainSideViewController toggleSidebar:!self.mainSideViewController.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"ProfileSegue"]){
        
        NSLog(@"seguing to profile");
        
        UIStoryboard* feedStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
        UIViewController *profileVC = [feedStoryboard instantiateViewControllerWithIdentifier:@"ProfileController"];
        
        [segue.destinationViewController setContentViewController:profileVC];
    }
    else if ([segue.identifier isEqualToString:@"LogoutSegue"]){
        NSLog(@"Logging out");
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
