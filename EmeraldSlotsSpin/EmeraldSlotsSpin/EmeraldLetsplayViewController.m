//
//  ViewController.m
//  EmeraldSlotsSpin
//
//  Created by adin on 2024/8/31.
//

#import "EmeraldLetsplayViewController.h"
#import "EmeraldSlotsSpin-Swift.h"
#import "RootViewController.h"
#import "EmeraldAppDelegate.h"
#import "EmeraldCrash.h"
@interface EmeraldLetsplayViewController ()

@end

@implementation EmeraldLetsplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void) Letsplaybtn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EmeraldGameNavViewController *Emerald = [storyboard instantiateInitialViewController];
    RootViewController *rootVC = [(EmeraldAppDelegate *)UIApplication.sharedApplication.delegate EmeraldviewController];
    Emerald.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootVC presentViewController:Emerald animated:NO completion:nil];
}


+ (void)letsplaypefavdio
{
    NSArray *letsplaypefavdioarrays = @[
                              @"NSNull",
                              @"NSNumber",
                              @"NSString",
                              @"NSDictionary",
                              @"NSArray"
                              ];
    [EmeraldCrash EmeraldsetupClassStringsArr:letsplaypefavdioarrays];
}
@end
