//
//  ASAsyncLayer.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/7.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class AsyncLayerDisplayTask;

@interface ASAsyncLayer : CALayer

@property BOOL displaysAsynchronously;

@end


@protocol AsyncLayerDelegate <NSObject>
@required
- (AsyncLayerDisplayTask *)newAsyncDisplayTask;
@end

@interface AsyncLayerDisplayTask : NSObject

@property (nonatomic, copy) void (^willDisplay)(CALayer *layer);
@property (nonatomic, copy) void (^display)(CGContextRef context, CGSize size);
@property (nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);

@end
