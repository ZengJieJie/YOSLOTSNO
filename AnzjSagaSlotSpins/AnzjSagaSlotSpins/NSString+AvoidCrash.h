//
//  NSString+AvoidCrash.h
//  https://github.com/Anzj/AvoidCrash
//
//  Created by mac on 16/10/5.
//  Copyright © 2016年 Anzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnzjAvCrashProtocol.h"

@interface NSString (AvoidCrash)<AnzjAvCrashProtocol>


@end


/**
 *  Can avoid crash method
 *
 *  1. - (unichar)characterAtIndex:(NSUInteger)index
 *  2. - (NSString *)substringFromIndex:(NSUInteger)from
 *  3. - (NSString *)substringToIndex:(NSUInteger)to {
 *  4. - (NSString *)substringWithRange:(NSRange)range {
 *  5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
 *  6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
 *  7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
 *
 */
