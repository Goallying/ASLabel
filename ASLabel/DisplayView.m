//
//  DisplayView.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "DisplayView.h"
#import "ASTextLine.h"
#import <CoreText/CoreText.h>

@implementation DisplayView

- (void)drawRect:(CGRect)rect {
    
    //一下代码是最最最最基本的文字绘画过程。
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    
//    CGAffineTransformTranslate/Rotate/Scale    //平移，旋转， 缩放
//    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//    CGContextTranslateCTM(ctx, 0, self.bounds.size.height); // 移动到坐标左上角
//    CGContextScaleCTM(ctx, 1.0, -1.0); // 翻转。
    

//    CGMutablePathRef path = CGPathCreateMutable() ;
//    CGPathAddRect(path, NULL, self.bounds);
    
    NSMutableAttributedString * s = [[NSMutableAttributedString alloc]initWithString:@"Hello world 1234567890习近平在讲话中强调，党的十八大以来，在党中央坚强领导下，我们积极推进外交理论和实践创新，完善和深化全方位外交布局，倡导和推进“一带一路”建设，深入参与全球治理体系改革和建设，坚定捍卫国家主权、安全、发展利益，加强党对外事工作的集中统一领导，走出了一条中国特色大国外交新路，取得了历史性成就"];
    
    NSMutableDictionary *  frameAttrs = [NSMutableDictionary dictionary];
    // font。
    frameAttrs[(id)kCTFontAttributeName] = [UIFont systemFontOfSize:15] ;
    // 文字间距
    frameAttrs[(id)kCTKernAttributeName] = @10 ;
    [s addAttributes:frameAttrs range:NSMakeRange(0, s.length)];
    
    CGRect boxRect = (CGRect) {CGPointZero, self.bounds.size};
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(1, -1));
    CGPathRef path = CGPathCreateWithRect(rect, NULL);

    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)s);
    CTFrameRef frame = CTFramesetterCreateFrame(setter, CFRangeMake(0, s.length), path, (CFTypeRef)frameAttrs);
    
//    CTFrameDraw(frame, ctx);

//    CFRelease(setter);
//    CFRelease(frame);
//    CFRelease(path);
    
    
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CFArrayRef lines = CTFrameGetLines(frame);
    NSUInteger lineCount = CFArrayGetCount(lines);
    CGPoint *lineOrigins = malloc(lineCount * sizeof(CGPoint)) ;
    CTFrameGetLineOrigins(frame, CFRangeMake(0, lineCount), lineOrigins);
    
    //CGRectStandardize 用法
//     CGRectStandardize(testRect)
//     standardizeRect.size.width = fabsf(testRect.size.width)//testRect.size.width 的绝对值
//     standardizeRect.size.height = fabsf(testRect.size.height)//testRect.size.height 的绝对值
    

    for (int i = 0 ; i < lineCount;  i ++) {
        CTLineRef l = CFArrayGetValueAtIndex(lines, i);
        CFArrayRef runs = CTLineGetGlyphRuns(l);
//        CTLineDraw(l, ctx);
        
        CGPoint ctLineOrigin = lineOrigins[i];
        //UIKit coordinate.
        CGPoint position;
        position.x = boxRect.origin.x + ctLineOrigin.x;
        position.y = boxRect.size.height + boxRect.origin.y - ctLineOrigin.y;
        
        ASTextLine * textline = [ASTextLine lineWithCTLine:l position:position];
        
        CFIndex runCount = CFArrayGetCount(runs);
        for (int j = 0 ; j < runCount; j ++) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            
            
            CGFloat posX = textline.position.x;
            CGFloat posY = self.bounds.size.height - textline.position.y;
            //quarz coordinate.
            CGContextSetTextPosition(ctx, posX , posY);
            CTRunDraw(run, ctx, CFRangeMake(0, 0));
            
           //CTRun height! CTLine.size.
        }
    }
    
    
}

@end
