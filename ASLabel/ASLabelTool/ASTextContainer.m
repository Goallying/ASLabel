//
//  ASTextContainer.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/8.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASTextContainer.h"

@implementation ASTextContainer

+ (instancetype)containerWithSize:(CGSize)size insets:(UIEdgeInsets)insets{
    
    return [[ASTextContainer alloc]initWithSize:size insets:insets];
}
- (instancetype)initWithSize:(CGSize)size insets:(UIEdgeInsets)insets {
    if (self = [super init]) {
        _size = size ;
        _insets = insets ;
    }
    return self ;
}
@end
