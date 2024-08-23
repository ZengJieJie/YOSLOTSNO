//
//  NSAttributedString+AvoidCrash.h
//  https://github.com/Anzj/AvoidCrash
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 Anzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnzjAvCrashProtocol.h"

@interface NSAttributedString (AvoidCrash)<AnzjAvCrashProtocol>


@end

/**
 *  Can avoid crash method
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
 *  3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *
 *
 */
