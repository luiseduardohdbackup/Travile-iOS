//
//  PHSettingsViewController.m
//  Travian Manager
//
//  Created by Matej Kramny on 28/07/2012.
//
//

#import "PHSettingsViewController.h"

@interface PHSettingsViewController ()

@end

@implementation PHSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tabBarController.navigationItem setRightBarButtonItems:nil];
	[self.tabBarController.navigationItem setLeftBarButtonItems:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:nil];
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	
	[self.tabBarController setTitle:[NSString stringWithFormat:@"Settings"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end