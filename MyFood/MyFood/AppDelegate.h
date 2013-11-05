//
//  AppDelegate.h
//  MyFood
//
//  Created by Admin on 13-10-28.
//  Copyright (c) 2013 MVE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView(MyFoods)
-(void)addBorder:(CGFloat)width colour:(UIColor*)colour;
-(void)roundCorners:(CGFloat)cornerRadius;
-(void)setX:(CGFloat)x;
-(void)setY:(CGFloat)y;
-(void)centerInView:(UIView*)view;
-(CGFloat)width;
-(CGFloat)height;
-(void)add:(UIView*)view;
-(void)highlight;
-(void)unhighlight;
@end


@interface MenuIcon : UIView
@end


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;


@end


@interface Util : NSObject
+(UIView*)viewFromNib:(NSString*)nibName;
+(UIColor*)defaultBorderColour;
@end