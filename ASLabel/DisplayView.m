//
//  DisplayView.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>

@implementation DisplayView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    
//    CGAffineTransformTranslate/Rotate/Scale    //平移，旋转， 缩放
//    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//    CGContextTranslateCTM(ctx, 0, self.bounds.size.height); // 移动到坐标左上角
//    CGContextScaleCTM(ctx, 1.0, -1.0); // 翻转。
    

    CGMutablePathRef path = CGPathCreateMutable() ;
    CGPathAddRect(path, NULL, self.bounds);
    
    NSAttributedString * s = [[NSAttributedString alloc]initWithString:@"Helloworld1234567890"];
    
    CFMutableDictionaryRef  dic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks) ;
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", 12, NULL);
    CFDictionarySetValue(dic,kCTFontAttributeName ,fontRef) ;

    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)s);
    CTFrameRef frame = CTFramesetterCreateFrame(setter, CFRangeMake(0, s.length), path, dic);
    
//    CTFrameDraw(frame, ctx);

//    CFRelease(setter);
//    CFRelease(frame);
//    CFRelease(path);
    
    
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
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

        CFIndex runCount = CFArrayGetCount(runs);
        for (int j = 0 ; j < runCount; j ++) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            CGContextSetTextPosition(ctx, 0, 90);
            CTRunDraw(run, ctx, CFRangeMake(0, 0));
            
           //CTRun height! CTLine.size.
        }
    }
    
    
}

@end
