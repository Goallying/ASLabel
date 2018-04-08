//
//  ASTextLayout.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTextContainer.h"

@interface ASTextLayout : NSObject

@property (nonatomic, readwrite) NSAttributedString *text;
@property (nonatomic, readwrite) ASTextContainer *container;

+ (ASTextLayout *)layoutWithContainer:(ASTextContainer *)container text:(NSAttributedString *)text ;
@end