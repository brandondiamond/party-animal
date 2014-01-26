//
//  MainViewController.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "FeedController.h"
#import "MainSideViewController.h"
#import "SidebarController1.h"
#import "FlatTheme.h"
#import "Utils.h"

@interface MainSideViewController ()

@end

@implementation MainSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.controllerId = @"SidebarController1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    SidebarController1 *rearVC = [sidebarStoryboard instantiateViewControllerWithIdentifier:@"SidebarController"];

    UIStoryboard* feedStoryboard = [UIStoryboard storyboardWithName:@"FeedStoryboard" bundle:nil];
    UIViewController *frontVC = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedController"];
    
    frontVC.view.backgroundColor = [UIColor blackColor];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:frontVC];
    
    
    [FlatTheme styleNavigationBarWithFontName:@"Avenir" andColor:[UIColor colorWithWhite:0.4f alpha:1.0f]];
    
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];


    frontVC.navigationItem.leftBarButtonItem = self.menuItem;
    rearVC.mainSideViewController = self;
    
    self.contentViewController = nav;
    self.sidebarViewController = rearVC;
}



- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.title = self.contentViewController.title;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)revealToggle:(id)sender {
    //SidebarController1 *rearVC = (SidebarController1 *)self.sidebarViewController;
    
    [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer {
    //SidebarController1 *rearVC = (SidebarController1 *)self.sidebarViewController;
    //[rearVC.searchBar resignFirstResponder];
    
    [super dragContentView:recognizer];
}

@end

