//
//  NSMutableDictionary+AvoidCrash.h
//  https://github.com/Anzj/AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 Anzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnzjAvCrashProtocol.h"

@interface NSMutableDictionary (AvoidCrash)<AnzjAvCrashProtocol>


@end


/**
 *  Can avoid crash method
 *
 *  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
 *  2. - (void)removeObjectForKey:(id)aKey
 *
 */
