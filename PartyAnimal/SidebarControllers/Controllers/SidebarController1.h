//
//  SidebarController1.h
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSideViewController.h"

@interface SidebarController1 : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView* tableView;

@property (nonatomic, weak) IBOutlet UILabel* profileNameLabel;

@property (nonatomic, weak) IBOutlet UILabel* profileLocationLabel;

@property (nonatomic, weak) IBOutlet UIImageView* profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *logoutLink;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *logoutGestureRecognizer;

@property (nonatomic, weak) MainSideViewController* mainSideViewController;

@end
