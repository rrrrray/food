//
//  ViewController.m
//  MyFood
//
//  Created by Admin on 13-10-28.
//  Copyright (c) 2013 MVE. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface Friend : NSObject
@property (nonatomic, copy) NSString *name;
+(Friend*)createWithName:(NSString*)name;
@end


@implementation Friend
+(Friend*)createWithName:(NSString*)name {
    Friend *f = [[Friend alloc] init];
    f.name = name;
    return f;
}
@end


@interface FriendCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *friendName;
@property (nonatomic, strong) IBOutlet UIImageView *friendImage;
@property (nonatomic, strong) IBOutlet UIView *highlightView;
@end

@implementation FriendCell
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, [self height] - 1.0, [self width], 1.0)];
        border.backgroundColor = [Util defaultBorderColour];
        [self add:border];
        self.highlightView.alpha = 0.7;
        [self unhighlight];
    }
    return self;
}

-(void)highlight {
    self.highlightView.hidden = NO;
}

-(void)unhighlight {
    self.highlightView.hidden = YES;
}

@end



#define FRIEND_CELL     @"FriendCell"


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *friendsTableView;
@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) UIView *tabButtonHighlight;

@property (nonatomic, strong) IBOutlet UIButton *friendsTabButton;
@property (nonatomic, strong) IBOutlet UIButton *profileTabButton;


-(IBAction)onProfileTab:(id)sender;
-(IBAction)onFriendsTab:(id)sender;
-(IBAction)onMenuButton:(id)sender;

@end

@implementation MainViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.friends = [[NSMutableArray alloc] init];
    [self.friends addObject:[Friend createWithName:@"Bob"]];
    [self.friends addObject:[Friend createWithName:@"Mary"]];
    [self.friends addObject:[Friend createWithName:@"Sue"]];
    [self.friends addObject:[Friend createWithName:@"Ned"]];
    [self.friends addObject:[Friend createWithName:@"Matt"]];

    [self.menuButton addBorder:1.0 colour:[Util defaultBorderColour]];
    [self.menuButton roundCorners:4.0];
    
    self.friendsTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    self.friendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    [self.friendsTableView registerNib:[UINib nibWithNibName:FRIEND_CELL bundle:nil] forCellReuseIdentifier:FRIEND_CELL];
    [self.mainView addSubview:self.friendsTableView];
    
    // make like the user hit the friends button by default
    [self onFriendsTab:self.friendsTabButton];
}


-(IBAction)onProfileTab:(id)sender {
    [self highlightTabButton:(UIButton*)sender];
}

-(IBAction)onFriendsTab:(id)sender {
    [self highlightTabButton:(UIButton*)sender];
}

-(IBAction)onMenuButton:(id)sender {
    
}

-(void)highlightTabButton:(UIButton*)btn {
  
    if (self.tabButtonHighlight == nil) {
        self.tabButtonHighlight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [btn width]/2, 4.0)];
        self.tabButtonHighlight.backgroundColor = [UIColor redColor];
    } else {
        [self.tabButtonHighlight removeFromSuperview];
    }
    
    [btn add:self.tabButtonHighlight];
    [self.tabButtonHighlight setX:[btn width]/2 - [self.tabButtonHighlight width]/2];
    [self.tabButtonHighlight setY:[btn height] - 2*[self.tabButtonHighlight height]];

}


-(Friend*)friendAtIndex:(int)index {
    return ((Friend*)[self.friends objectAtIndex:index]);
}

//
// table view
//
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:FRIEND_CELL];
    [cell unhighlight];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.friendName.text = [self friendAtIndex:indexPath.row].name;

    return cell;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friends count];
}

static FriendCell *SampleFriendCell;


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (SampleFriendCell == nil) {
        SampleFriendCell = (FriendCell*)[Util viewFromNib:FRIEND_CELL];
    }
    return [SampleFriendCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self unhighlightAllCells:tableView];
    
    FriendCell *cell = (FriendCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell highlight];
}

-(void)unhighlightAllCells:(UITableView*)tableView {
    for (int i = 0; i < [tableView numberOfRowsInSection:0]; ++i) {
        FriendCell *cell = (FriendCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [cell unhighlight];
    }
}


@end
