//
//  ASTextContainer.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/8.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTextContainer : NSObject

@property (nonatomic ,assign)CGSize size ;
@property (nonatomic ,assign)UIEdgeInsets insets ;
@property (nonatomic ,assign)NSInteger numberOfLines ;

+ (instancetype)containerWithSize:(CGSize)size insets:(UIEdgeInsets)insets ;

@end
