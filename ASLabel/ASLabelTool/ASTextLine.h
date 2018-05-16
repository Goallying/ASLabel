//
//  ASTextLine.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/8.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface ASTextLine : NSObject

@property (nonatomic)   CGPoint position;
@property (nonatomic, readonly) CGFloat ascent;
@property (nonatomic, readonly) CGFloat descent;
@property (nonatomic, readonly) CGFloat leading;
@property (nonatomic, readonly) CGFloat lineWidth;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readonly) CTLineRef CTLine;

+ (instancetype)lineWithCTLine:(CTLineRef)CTLine position:(CGPoint)position ;

@end
