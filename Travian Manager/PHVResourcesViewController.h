//
//  PHVResourcesViewController.h
//  Travian Manager
//
//  Created by Matej Kramny on 29/07/2012.
//
//

#import <UIKit/UIKit.h>
#import "ODRefreshControl/ODRefreshControl.h"

@interface PHVResourcesViewController : UITableViewController <ODRefreshControlDelegate>

@property (weak, nonatomic) IBOutlet UILabel *wood;
@property (weak, nonatomic) IBOutlet UILabel *clay;
@property (weak, nonatomic) IBOutlet UILabel *iron;
@property (weak, nonatomic) IBOutlet UILabel *wheat;
@property (weak, nonatomic) IBOutlet UILabel *warehouse;
@property (weak, nonatomic) IBOutlet UILabel *granary;
@property (weak, nonatomic) IBOutlet UILabel *consuming;
@property (weak, nonatomic) IBOutlet UILabel *producing;

@property (strong, nonatomic) ODRefreshControl *refreshControl;

- (void)refreshResources;

@end
