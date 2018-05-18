//
//  ASLabel.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTextMacro.h"
#import "NSAttributedString+ASAdd.h"
@interface ASLabel : UIView

@property (nonatomic ,copy)NSString * text ;
@property (nonatomic ,copy)NSAttributedString * attributedText ;
@property (nonatomic ,assign)NSTextAlignment textAlignment ;
@property (nonatomic ,assign)NSTextVerticalAlignment verticalAlignment;
@property (nonatomic ,assign)NSInteger numberOfLines ;
@property (nonatomic ,assign)UIEdgeInsets textContainerInset;
@property (nonatomic ,assign)NSInteger characterSpacing ; // not reasonable here,this property belongs to 'NSAttributedString', but it's convenient;
@property (nonatomic ,assign)CGFloat lineSpacing ; //above
@property (nonatomic ,strong)UIFont * font ;

@end
