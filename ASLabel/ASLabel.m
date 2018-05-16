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
    
    ASTextLayout * _innerTextLayout ;
    ASTextContainer * _textContainer ;
    
    NSMutableAttributedString *_innerText ;
    
    UIFont * _font ;
    UIColor *_textColor ;
    NSTextAlignment _alignment ;
    
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

    _innerText = [[NSMutableAttributedString alloc]initWithString:text];
    _innerText.font = _font ;
    _innerText.color = _textColor ;
    _innerText.alignment = _alignment ;
    [self.layer setNeedsDisplay];
}
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    _textContainer.insets = textContainerInset ;
    [self.layer setNeedsDisplay];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    if (_innerText.alignment == textAlignment) {
        return;
    }
    _innerText.alignment = textAlignment ;
    [self.layer setNeedsDisplay];
}
#pragma mark --
#pragma mark -- 异步绘制
- (AsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    AsyncLayerDisplayTask * task = [AsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        NSLog(@"will display...");
    };
    task.display = ^(CGContextRef context, CGSize size) {
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
