//
//  ASAttachment.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASAttachment.h"

@implementation ASAttachment

+ (instancetype)attachmentWithContent:(id)content {
    return [[self alloc]initWithContent:content];
}
- (instancetype)initWithContent:(id)content {
    if (self = [super init]) {
        _content = content ;
    }
    return self ;
}
@end
