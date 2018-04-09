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
    }
    return  self ;
}

- (void)_initLabel{
    
    ((ASAsyncLayer *)self.layer).displaysAsynchronously = NO;
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
    
//    NSLog(@"w==== %f ,h == %f",_textContainer.size.width ,_textContainer.size.height);
}

+ (Class)layerClass{
    return [ASAsyncLayer class];
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
    [self _clearInnerLayout];
    [self.layer setNeedsDisplay];
    
}

- (AsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    AsyncLayerDisplayTask * task = [AsyncLayerDisplayTask new];
//    task.willDisplay = ^(CALayer * layer){
//        [layer removeAnimationForKey:@"contents"];
//    };
    
    task.display = ^(CGContextRef context, CGSize size) {
        
     
        
        ASTextLayout * txtLayout = [ASTextLayout layoutWithContainer:_textContainer text:_innerText];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGContextRef ctx = UIGraphicsGetCurrentContext();
//            CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//            CGContextTranslateCTM(ctx, 0, 100);
//            CGContextScaleCTM(ctx, 1, -1);
            CTFrameDraw(txtLayout.frameRef, ctx);
        });
    };
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
//        __strong ASLabel *view = (ASLabel *)layer.delegate;
//        view->_innerTextLayout = _innerTextLayout;

    };
    return task;
}




- (void)_clearInnerLayout{
    _innerTextLayout = nil ;
}

@end
