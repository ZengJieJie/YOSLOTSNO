//
//  main.m
//  EmeraldSlotsSpin
//
//  Created by adin on 2024/8/31.
//

#import <UIKit/UIKit.h>
#import "EmeraldAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([EmeraldAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
