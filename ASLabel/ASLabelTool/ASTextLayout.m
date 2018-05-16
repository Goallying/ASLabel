//
//  ASTextLayout.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASTextLayout.h"
#import "ASTextLine.h"

#import <CoreText/CoreText.h>

const CGSize ASTextContainerMaxSize = (CGSize){0x100000, 0x100000};
@implementation ASTextLayout

+ (ASTextLayout *)layoutWithContainer:(ASTextContainer *)container text:(NSAttributedString *)text{
    
    ASTextLayout * layout = [ASTextLayout new] ;
    layout.container = container ;

    CGRect boxRect = (CGRect) {CGPointZero, container.size};
    CGRect contentRect = UIEdgeInsetsInsetRect(boxRect,container.insets);
    CGAffineTransform  transform =  CGAffineTransformMakeScale(1, -1) ;
    CGPathRef path = CGPathCreateWithRect(contentRect, &transform) ;
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFTypeRef)text);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, text.length), path, NULL);
    CFArrayRef lines = CTFrameGetLines(frame);
    NSUInteger lineCount = CFArrayGetCount(lines);
    CGPoint *lineOrigins = malloc(lineCount * sizeof(CGPoint)) ;
    CTFrameGetLineOrigins(frame, CFRangeMake(0, lineCount), lineOrigins);
    
    NSMutableArray * textLines = [NSMutableArray array];
    for (int i = 0 ; i < lineCount;  i ++) {
        CTLineRef l = CFArrayGetValueAtIndex(lines, i);
        CGPoint ctLineOrigin = lineOrigins[i];
        //UIKit coordinate.
        CGPoint position;
        position.x = boxRect.origin.x + ctLineOrigin.x;
        position.y = boxRect.size.height + boxRect.origin.y - ctLineOrigin.y;
        
        ASTextLine * textline = [ASTextLine lineWithCTLine:l position:position];
        [textLines addObject:textline];
    }
    layout.lines = textLines ;
    
    CFRelease(path);
    CFRelease(frameSetter);
    CFRelease(frame);
    return layout;
}

- (void)drawInContext:(CGContextRef)ctx size:(CGSize)size {
    CGContextSaveGState(ctx);{
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
        CGContextTranslateCTM(ctx, 0,size.height);
        CGContextScaleCTM(ctx, 1, -1);
        for (int i = 0; i < _lines.count; i ++) {
            ASTextLine * line = _lines[i];
            CGFloat px = line.position.x ;
            CGFloat py = size.height - line.position.y ;
            CFArrayRef runs = CTLineGetGlyphRuns(line.CTLine);
            NSUInteger runc = CFArrayGetCount(runs);
            for (int j = 0; j < runc; j ++) {
                CTRunRef run = CFArrayGetValueAtIndex(runs, j);
                CGContextSetTextPosition(ctx, px, py);
                CTRunDraw(run, ctx, CFRangeMake(0, 0));
            }
        }
    }CGContextRestoreGState(ctx);
}

@end
