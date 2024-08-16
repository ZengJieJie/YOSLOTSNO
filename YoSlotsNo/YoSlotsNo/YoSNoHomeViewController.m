//
//  YoSNoHomeViewController.m
//  YoSlotsNo
//
//  Created by adin on 2024/8/15.
//

#import "YoSNoHomeViewController.h"
#import "RootViewController.h"
#import "AppController.h""
#import "YoSlotsNo-Swift.h"
@implementation YoSNoHomeViewController
+ (void) jackpotSpin
{
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}

+ (void) elementPower
{
    
    
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondGame *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondGame"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) findTresure
{
    
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) jackpotSlots
{
    
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SlotGame *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SlotGame"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) settingClick
{
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
- (void)viewDidLoad {
    
    
}
@end
