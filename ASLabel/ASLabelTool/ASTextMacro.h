//
//  ASTextMacro.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ASTextAttachmentToken ;
UIKIT_EXTERN NSString *const ASTextAttachmentAttributeName ;

typedef NS_ENUM(NSInteger, NSTextVerticalAlignment) {
    NSTextVerticalAlignmentTop =    0, ///< Top alignment.
    NSTextVerticalAlignmentCenter = 1, ///< Center alignment.defalut value!
    NSTextVerticalAlignmentBottom = 2, ///< Bottom alignment.
};

@interface ASTextMacro : NSObject

@end
