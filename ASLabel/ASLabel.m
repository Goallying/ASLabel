//
//  ASLabel.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASLabel.h"
#import "ASTextLayout.h"
#import "ASAsyncLayer.h"

#import "NSAttributedString+ASAdd.h"


@implementation ASLabel{
    
    ASTextLayout * _innerTextLayout ;
    NSMutableAttributedString *_innerText ;
    
    UIFont * _font ;
    UIColor *_textColor ;
    NSTextAlignment  _alignment ;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _initLabel];
    }
    return  self ;
}

- (void)_initLabel{
    
    ((ASAsyncLayer *)self.layer).displaysAsynchronously = NO;
    _font = [UIFont systemFontOfSize:17];
    _textColor = [UIColor blackColor];
    _alignment = NSTextAlignmentLeft ;
}



//properties
- (void)setText:(NSString *)text {
    if([_text isEqualToString:text]) return;
    _text = text ;
    //label 是否是初次赋值。初次赋值需要添加额外属性font,color等默认值。
    BOOL needAddAttributes = _innerText.length == 0 && text.length > 0;
    [_innerText replaceCharactersInRange:NSMakeRange(0, _innerText.length) withString:text ? text : @""];
    [_innerText removeAttributes:NSMakeRange(0, _innerText.length)];
    if (needAddAttributes) {
        _innerText.font = _font ;
        _innerText.color = _textColor ;
        _innerText.alignment = _alignment ;
    }

    
    
}

@end
