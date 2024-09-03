//
//  NSMutableString+AvoidCrash.m
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableString+AvoidCrash.h"

#import "EmeraldCrash.h"

@implementation NSMutableString (AvoidCrash)

+ (void)Emerald_avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");
        
        //replaceCharactersInRange
        [EmeraldCrash EmeraldexchangeInstanceMethod:stringClass method1Sel:@selector(replaceCharactersInRange:withString:) method2Sel:@selector(avoidCrashReplaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [EmeraldCrash EmeraldexchangeInstanceMethod:stringClass method1Sel:@selector(insertString:atIndex:) method2Sel:@selector(avoidCrashInsertString:atIndex:)];
        
        //deleteCharactersInRange
        [EmeraldCrash EmeraldexchangeInstanceMethod:stringClass method1Sel:@selector(deleteCharactersInRange:) method2Sel:@selector(avoidCrashDeleteCharactersInRange:)];
    });
}

//=================================================================
//                     replaceCharactersInRange
//=================================================================
#pragma mark - replaceCharactersInRange

- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self avoidCrashReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [EmeraldCrash EmeraldnoteErrithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)avoidCrashInsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self avoidCrashInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [EmeraldCrash EmeraldnoteErrithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                   deleteCharactersInRange
//=================================================================
#pragma mark - deleteCharactersInRange

- (void)avoidCrashDeleteCharactersInRange:(NSRange)range {
    
    @try {
        [self avoidCrashDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [EmeraldCrash EmeraldnoteErrithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}








@end
