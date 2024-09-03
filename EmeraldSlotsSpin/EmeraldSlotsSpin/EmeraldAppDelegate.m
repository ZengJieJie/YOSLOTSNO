//
//  AppDelegate.m
//  EmeraldSlotsSpin
//
//  Created by adin on 2024/8/31.
//






#import "EmeraldAppDelegate.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "SDKWrapper.h"
#import "platform/ios/CCEAGLView-ios.h"
#import "Adjust.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "EmeraldCrash.h"
#import <UMCommon/UMCommon.h>


using namespace cocos2d;

@implementation EmeraldAppDelegate

Application* app = nullptr;
@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SDKWrapper getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    NSString *yourAppToken = @"rgjnkasvn2m8";
    NSString *environment = ADJEnvironmentProduction;
    ADJConfig* myAdjustConfig = [ADJConfig configWithAppToken:yourAppToken
                                   environment:environment];
    [myAdjustConfig setLogLevel:ADJLogLevelVerbose];
    
    
    [EmeraldCrash EmeraldmakeAllEffective];
    [UMConfigure initWithAppkey:@"dafsfak124dflsal" channel:@"Emerald"];
    
    // Add the view controller's view to the window and display.
    float scale = [[UIScreen mainScreen] scale];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: bounds];
    
    // cocos2d application instance
    app = new AppDelegate(bounds.size.width * scale, bounds.size.height * scale);
    app->setMultitouch(true);
    
    // Use RootViewController to manage CCEAGLView
    _EmeraldviewController = [[RootViewController alloc]init];
#ifdef NSFoundationVersionNumber_iOS_7_0
    _EmeraldviewController.automaticallyAdjustsScrollViewInsets = NO;
    _EmeraldviewController.extendedLayoutIncludesOpaqueBars = NO;
    _EmeraldviewController.edgesForExtendedLayout = UIRectEdgeAll;
#else
    _EmeraldviewController.wantsFullScreenLayout = YES;
#endif

    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {

        [window addSubview: _EmeraldviewController.view];
    }
    else
    {

        [window setRootViewController:_EmeraldviewController];
        
    }
    
    [window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
 
    app->start();

    


    [Adjust appDidLaunch:myAdjustConfig];
    
    

    return YES;
}


- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
   
  }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    app->onPause();
    [[SDKWrapper getInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    app->onResume();
    [[SDKWrapper getInstance] applicationDidBecomeActive:application];
    [Adjust requestTrackingAuthorizationWithCompletionHandler:^(NSUInteger status) {

      
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
    [[SDKWrapper getInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[SDKWrapper getInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SDKWrapper getInstance] applicationWillTerminate:application];
    delete app;
    app = nil;
}





@end
