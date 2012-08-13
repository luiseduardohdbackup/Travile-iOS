//
//  AppDelegate.m
//  Travian Manager
//
//  Created by Matej Kramny on 10/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Account.h"
#import "Storage.h"
#import "Village.h"
#import "Hero.h"
#import "Resources.h"
#import "Building.h"
#import "TravianPages.h"
#import "HeroQuest.h"
#import "ODRefreshControl/ODRefreshControl.h"

@interface AppDelegate () {
	UIImageView *tableCellSelectedBackground;
	UIImage *detailAccessoryViewImage;
}

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize storage;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self customizeAppearance];
	
	storage = [[Storage alloc] init];
	
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[storage saveData];
	
	//As we are going into the background, I want to start a background task to clean up the disk caches
	if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports multitasking I.E iOS 4
		if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
			[application beginBackgroundTaskWithExpirationHandler:^ {
				NSLog(@"Went to background");
			}];
		}
	}
}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end

@implementation AppDelegate (Appearance)

- (void)customizeAppearance {
	// Tiled background image
	UIImage *background = [[UIImage imageNamed:@"UINavigationBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 31.5, 0)];
	// Landscape
	UIImage *backgroundLandscape = [UIImage imageNamed:@"UINavigationBarLandscape.png"];
	
	// Set background
	[[UINavigationBar appearance] setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setBackgroundImage:backgroundLandscape forBarMetrics:UIBarMetricsLandscapePhone];
	
	// Set Navigation Bar text
	[[UINavigationBar appearance] setTitleTextAttributes:@{
							   UITextAttributeTextColor : [UIColor colorWithRed:60.0/255.0 green:70.0/255.0 blue:81.0/255.0 alpha:1.0],
						 UITextAttributeTextShadowColor : [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:0.5],
						UITextAttributeTextShadowOffset : [NSValue valueWithCGSize:CGSizeMake(0, -1)],
									UITextAttributeFont : [UIFont fontWithName:@"Arial Rounded MT Bold" size:20.0] }];
	
	// Back Button
	UIImage *backButton = [[UIImage imageNamed:@"BackButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 8)];
	// Landscape
	UIImage *backButtonLandscape = [[UIImage imageNamed:@"BackButtonLandscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 8)];
	
	// Button (normal state)
	UIImage *button = [[UIImage imageNamed:@"ButtonStateNormal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
	// Lanscape
	UIImage *buttonLandscape = [[UIImage imageNamed:@"ButtonStyleNormalLandscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
	
	// Set Button
	[[UIBarButtonItem appearance] setBackgroundImage:button forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[[UIBarButtonItem appearance] setBackgroundImage:buttonLandscape forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	// Set Back Button
	[[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonLandscape forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	
	[[UITableView appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"TMBackground.png"]]];
}

- (void)setCellAppearance:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
	UIView *bg = [[UIView alloc] init];
	
	if (indexPath.row % 2)
		[bg setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:0.8]];
	else
		[bg setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
	
	cell.backgroundView = bg;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
	if (!tableCellSelectedBackground)
		tableCellSelectedBackground = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"SelectedCell.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
	
	cell.selectedBackgroundView = tableCellSelectedBackground;
	cell.textLabel.highlightedTextColor = [UIColor whiteColor];
	cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
}

- (UIView *)setDetailAccessoryViewForTarget:(id)target action:(SEL)selector {
	// Detail view
	if (!detailAccessoryViewImage)
		detailAccessoryViewImage = [UIImage imageNamed:@"ArrowIcon.png"];
	
	CGRect frame = CGRectMake(0, 0, detailAccessoryViewImage.size.width, detailAccessoryViewImage.size.height);
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[button setFrame:frame];
	[button setBackgroundImage:detailAccessoryViewImage forState:UIControlStateNormal];
	[button setBackgroundColor:[UIColor clearColor]];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

+ (ODRefreshControl *)addRefreshControlTo:(UIScrollView *)scrollView target:(id)target action:(SEL)selector {
	ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:scrollView];
	[refreshControl setTintColor:[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:0.75]];
	[refreshControl addTarget:target action:selector forControlEvents:UIControlEventValueChanged];
	
	return refreshControl;
}

@end
