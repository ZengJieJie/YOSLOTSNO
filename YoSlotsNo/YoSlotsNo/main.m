//
//  main.m
//  YoSlotsNo
//
//  Created by adin on 2024/8/15.
//

#import <UIKit/UIKit.h>
#import "AppController.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppController class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
