//
//  AvoidCrashStubProxy.h
//  https://github.com/Anzj/AvoidCrash
//
//  Created by Anzj on 2017/7/25.
//  Copyright © 2017年 Anzj. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)


//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"AvoidCrash default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"AvoidCrash default is to ignore this operation to avoid crash."

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="


#ifdef DEBUG

#define  AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define AvoidCrashLog(...)
#endif

@interface AnzjAvCrashStubProxy : NSObject

- (void)proxyMethod;

@end
