//
//  ASLabel.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NSTextVerticalAlignment) {
    NSTextVerticalAlignmentTop =    0, ///< Top alignment.
    NSTextVerticalAlignmentCenter = 1, ///< Center alignment.defalut value!
    NSTextVerticalAlignmentBottom = 2, ///< Bottom alignment.
};

@interface ASLabel : UIView

@property (nonatomic ,copy)NSString * text ;
@property (nonatomic ,assign)NSTextAlignment textAlignment ;
@property (nonatomic ,assign)NSTextVerticalAlignment verticalAlignment;
@property (nonatomic ,assign)NSInteger numberOfLines ;
@property (nonatomic) UIEdgeInsets textContainerInset;

@end
