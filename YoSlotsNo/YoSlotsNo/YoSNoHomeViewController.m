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
    YoSlotsNoMainGameViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}

+ (void) elementPower
{
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YoSlotsNoSecondGameVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondGame"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) findTresure
{
    
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YoSlotsNoSlotGameVCGameVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) jackpotSlots
{
    
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YoSlotsNoSlotGameVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SlotGame"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}
+ (void) settingClick
{
    RootViewController *vcrot = [(AppController *)UIApplication.sharedApplication.delegate viewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YoSlotsNoSettingVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:viewController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    
    
}

@end
