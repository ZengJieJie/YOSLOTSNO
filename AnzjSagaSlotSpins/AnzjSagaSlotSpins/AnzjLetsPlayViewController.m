//
//  ViewController.m
//  AnzjSagaSlotSpins
//
//  Created by adin on 2024/8/23.
//

#import "AnzjLetsPlayViewController.h"
#import "RootViewController.h"
#import "AnzjAppDelegate.h"
#import "AnzjAvCrashChange.h"

@interface AnzjLetsPlayViewController ()

@end

@implementation AnzjLetsPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)AnzjLetsPlayclick
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *homeNav = [storyboard instantiateInitialViewController];
    RootViewController *rootVC = [(AnzjAppDelegate *)UIApplication.sharedApplication.delegate Anzjview];
    homeNav.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootVC presentViewController:homeNav animated:NO completion:nil];
    
    NSArray *noneSelClassStrings = @[
                              @"NSNull",
                              @"NSNumber",
                              @"NSString",
                              @"NSDictionary",
                              @"NSArray"
                              ];
    [AnzjAvCrashChange AnzjsetupNoneSelClassStringsArr:noneSelClassStrings];
}

@end
