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

@interface ASLabel ()<AsyncLayerDelegate>

@end

@implementation ASLabel {
    
    @private
    ASTextLayout * _innerTextLayout ;
    ASTextContainer * _textContainer ;
    
    NSMutableAttributedString *_innerText ;
    
    UIFont * _font ;
    UIColor *_textColor ;
    NSTextAlignment _alignment ;
    NSTextVerticalAlignment _verticalAlignment ;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _initLabel];
        self.frame = frame;
    }
    return  self ;
}

- (void)_initLabel{
    
    ((ASAsyncLayer *)self.layer).displaysAsynchronously = YES;
    _innerTextLayout = [ASTextLayout new];
    _textContainer = [ASTextContainer new];
    
    _font = [UIFont systemFontOfSize:17];
    _textColor = [UIColor blackColor];
    _alignment = NSTextAlignmentLeft ;
    _verticalAlignment = NSTextVerticalAlignmentCenter ;
    
    _innerText = [NSMutableAttributedString new];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _textContainer.size = self.bounds.size ;
}

+ (Class)layerClass{
    return [ASAsyncLayer class];
}
#pragma mark --
#pragma mark -- setter
//properties
- (void)setText:(NSString *)text {
    if ([_text isEqualToString:text])  return ;
    _text = text ;
    //反复赋值text ，不需要重新更新文字颜色字体，排版方式。
    BOOL needResetAttributes = (_innerText.length == 0 && text.length > 0) ;
    [_innerText replaceCharactersInRange:NSMakeRange(0, _innerText.length) withString:text ? text : @""];
    if (needResetAttributes) {
        _innerText.font = _font ;
        _innerText.color = _textColor ;
        _innerText.alignment = _alignment ;
    }
    [self.layer setNeedsDisplay];
}
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    _textContainer.insets = textContainerInset ;
    [self.layer setNeedsDisplay];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    if (_alignment == textAlignment) return;
    _alignment = textAlignment ;
    _innerText.alignment = textAlignment ;
    [self.layer setNeedsDisplay];
}
- (void)setVerticalAlignment:(NSTextVerticalAlignment)verticalAlignment{
    _verticalAlignment = verticalAlignment ;
}
#pragma mark --
#pragma mark -- 异步绘制
- (AsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    AsyncLayerDisplayTask * task = [AsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        NSLog(@"will display...");
    };
    task.display = ^(CGContextRef context, CGSize size) {
        CGPoint verticalp = CGPointZero ; //if verticalAlignment == top
        //需要计算文本内容总高度。
        if (_verticalAlignment == NSTextVerticalAlignmentCenter) {
        }else if (_verticalAlignment == NSTextVerticalAlignmentBottom){
            
        }
        ASTextLayout * layout = [ASTextLayout layoutWithContainer:_textContainer text:_innerText];
        [layout drawInContext:context size:size];
        NSLog(@"display...");
    };
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
        NSLog(@"didDisplay...");
    };
    return task;
}
- (void)_clearInnerLayout{
    _innerTextLayout = nil ;
}

@end
