//
//  ASAsyncLayer.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/7.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASAsyncLayer.h"

@implementation ASAsyncLayer

+ (id)defaultValueForKey:(NSString *)key{
    
    if ([key isEqualToString:@"displaysAsynchronously"]) {
        return @(YES);
    } else {
        return [super defaultValueForKey:key];
    }
}

- (void)display{
    super.contents = super.contents;
    [self _displaysAsynchronously];
}

- (void)_displaysAsynchronously {
    
    __strong id<AsyncLayerDelegate>delegate = (id)self.delegate ;
    AsyncLayerDisplayTask *task = [delegate newAsyncDisplayTask];

    if (task.willDisplay) {
        task.willDisplay(self);
    }
    CGSize size = self.bounds.size ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (task.display) {
            task.display(context, size);
        }
        if (task.didDisplay) {
            task.didDisplay(self, YES);
        }
    });
   
}


@end

@implementation AsyncLayerDisplayTask

@end
