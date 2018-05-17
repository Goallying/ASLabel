//
//  ASTextLayout.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "ASTextContainer.h"
#import "ASTextLine.h"

@interface ASTextLayout : NSObject

@property (nonatomic, strong) NSAttributedString *text;
@property (nonatomic, strong) ASTextContainer *container;
@property (nonatomic ,strong) NSArray<ASTextLine *> *lines ;
@property (nonatomic ,assign)CGRect textBoundingRect ;

+ (ASTextLayout *)layoutWithContainer:(ASTextContainer *)container text:(NSAttributedString *)text ;
- (void)drawInContext:(CGContextRef)ctx size:(CGSize)size point:(CGPoint)point;

@end
