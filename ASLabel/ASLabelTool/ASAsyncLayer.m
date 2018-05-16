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
//    CGColorRef backgroundColor = (opaque && self.backgroundColor) ? CGColorRetain(self.backgroundColor) : NULL;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
//        if (opaque && context) {
//            CGContextSaveGState(context); {
//                if (!backgroundColor || CGColorGetAlpha(backgroundColor) < 1) {
//                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//                    CGContextAddRect(context, CGRectMake(0, 0, size.width * scale, size.height * scale));
//                    CGContextFillPath(context);
//                }
//                if (backgroundColor) {
//                    CGContextSetFillColorWithColor(context, backgroundColor);
//                    CGContextAddRect(context, CGRectMake(0, 0, size.width * scale, size.height * scale));
//                    CGContextFillPath(context);
//                }
//            } CGContextRestoreGState(context);
//            CGColorRelease(backgroundColor);
//        }
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
