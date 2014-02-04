//
//  FeedController3.m
//  ADVFlatUI
//
//  Created by Tope on 03/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "FeedController.h"
#import "FeedCell.h"

@interface FeedController ()

@property (nonatomic, strong) NSArray* profileImages;

@end

@implementation FeedController

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
	   
    self.title = @"Feed";
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;
    
    self.feedTableView.backgroundColor = [UIColor whiteColor];
    self.feedTableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    
    self.profileImages = [NSArray arrayWithObjects:@"profile.jpg", @"profile-1.jpg", @"profile-2.jpg", @"profile-3.jpg", nil];
    self.searchBar.hidden = YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    if (!cell) {
        cell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedCell"];
    }
    
    cell.nameLabel.text = @"Kitty Pryde";
    cell.updateLabel.text = @"Sick foam party down in the east village. First 40 pay no cover.";
    
    cell.dateLabel.text = @"1 hr ago";
    cell.likeCountLabel.text = @"293 likes";
    cell.commentCountLabel.text = @"55 comments";
    
    NSString* profileImageName = self.profileImages[indexPath.row%self.profileImages.count];
    cell.profileImageView.image = [UIImage imageNamed:profileImageName];
    
        return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
