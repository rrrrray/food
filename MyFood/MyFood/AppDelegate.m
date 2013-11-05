//
//  AppDelegate.m
//  MyFood
//
//  Created by Admin on 13-10-28.
//  Copyright (c) 2013 MVE. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"   

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[MainViewController alloc] initWithNibName:@"IPhoneMainView" bundle:nil];
    } else {
        self.viewController = [[MainViewController alloc] initWithNibName:@"IPadMainView" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end



@implementation UIView(MyFoods)
-(void)addBorder:(CGFloat)width colour:(UIColor *)colour {
    self.layer.borderColor = colour.CGColor;
    self.layer.borderWidth = width;
}
-(void)roundCorners:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}
-(void)setX:(CGFloat)x {
    CGRect f = self.frame;
    f.origin.x = x;
    self.frame = f;
}
-(void)setY:(CGFloat)y {
    CGRect f = self.frame;
    f.origin.y = y;
    self.frame = f;
}
-(void)centerInView:(UIView *)view {
    CGRect f = self.frame;
    f.origin.x = [view width]/2 - [self width]/2;
    f.origin.y = [view height]/2 - [self height]/2;
    self.frame = f;
}
-(CGFloat)width {
    return self.frame.size.width;
}
-(CGFloat)height {
    return self.frame.size.height;
}
-(void)add:(UIView*)view {
    [self addSubview:view];
}
-(void)highlight {
    
}
-(void)unhighlight {
    
}
@end


@implementation MenuIcon
-(void)awakeFromNib {
    [self roundCorners:4.0];
}
@end


@implementation Util

+(UIColor*)defaultBorderColour {
    return [UIColor colorWithWhite:252.0/255.0 alpha:1.0];
}

+(UIView*)viewFromNib:(NSString*)nibName {
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    UIView *nibView = [nibObjects objectAtIndex:0];
    return nibView;
}
@end
