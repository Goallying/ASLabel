//
//  ASRunDelegate.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface ASRunDelegate : NSObject

@property (nonatomic ,assign) CGSize size ;
@property (nonatomic ,assign) CGFloat ascent ;
@property (nonatomic ,assign) CGFloat descent ;

- (CTRunDelegateRef)CTRunDelegate CF_RETURNS_RETAINED;

@end
