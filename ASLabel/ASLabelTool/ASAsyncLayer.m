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
    CGSize size = self.bounds.size;
    BOOL opaque = self.opaque;
    CGFloat scale = [UIScreen mainScreen].scale;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (task.display) {
            task.display(context, size);
        }
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext() ;
        UIGraphicsEndImageContext();
        if (task.didDisplay) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.contents = (__bridge id)(image.CGImage);
                task.didDisplay(self, YES);
            });
        }
    });
   
}


@end

@implementation AsyncLayerDisplayTask

@end
