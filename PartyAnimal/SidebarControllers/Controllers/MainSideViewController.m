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
@property (nonatomic, weak) UIViewController *mainController;
@property (nonatomic, readwrite) BOOL *searchShowing;
@end

@implementation MainSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.controllerId = @"FeedController";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    SidebarController1 *rearVC = [sidebarStoryboard instantiateViewControllerWithIdentifier:@"SidebarController"];

    UIStoryboard* feedStoryboard = [UIStoryboard storyboardWithName:@"FeedStoryboard" bundle:nil];
    FeedController *frontVC = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedController"];
    

    frontVC.view.backgroundColor = [UIColor blackColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:frontVC];

    NSString* boldFontName = @"Avenir-Black";
    
    [self styleNavigationBarWithFontName:boldFontName withNavItem:frontVC.navigationItem];
    
//    [FlatTheme styleNavigationBarWithFontName:@"Avenir" andColor:[UIColor colorWithWhite:0.4f alpha:1.0f]];
    
    self.mainController = frontVC;

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


-(void)toggleSearchTapped:(UIGestureRecognizer*)gestureRecognizer {
    if([self.mainController isKindOfClass:[FeedController class]]) {
        FeedController *controller =(FeedController *)self.mainController;
        if(self.searchShowing) {
            controller.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
            [controller.view addSubview:controller.searchBar];
        } else{
            [controller.searchBar removeFromSuperview];
        }
        self.searchShowing = !self.searchShowing;
    }
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

