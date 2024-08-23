//
//  main.m
//  AnzjSagaSlotSpins
//
//  Created by adin on 2024/8/23.
//

#import <UIKit/UIKit.h>
#import "AnzjAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AnzjAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
