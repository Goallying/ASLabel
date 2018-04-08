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
    
    ASTextLayout * txtLayout = [[ASTextLayout alloc]init];
    txtLayout.text = text ;
    txtLayout.container = container ;
    
    CGRect rect = (CGRect){CGPointZero ,container.size};
    rect = UIEdgeInsetsInsetRect(rect, container.insets);
    rect = CGRectStandardize(rect);
    
    CGRect pathBoxRct = rect ;
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(1, -1));
    CGPathRef pathRef = CGPathCreateWithRect(rect, NULL);
    if (!pathRef) {
        NSLog(@"pathRef error");
        return nil ;
    }
    // 未添加任何属性。
    NSMutableDictionary * frameAttrs = [NSMutableDictionary dictionary];
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFTypeRef)text);
    if (!frameSetterRef) {
        NSLog(@"framsetterRef error");
        return nil;
    }
    //CTFrame的大小就是container - insets 的大小
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, text.length), pathRef, (CFTypeRef)frameAttrs);
    if (!frameRef) {
        NSLog(@"frameRef error");
        return nil ;
    }
    CFArrayRef linesRef = CTFrameGetLines(frameRef);
    CFIndex  linesCount = CFArrayGetCount(linesRef);
    
    CGPoint *lineOrigins = NULL;
    if (linesCount > 0) {
        lineOrigins = malloc(linesCount * sizeof(CGPoint));
        if (lineOrigins == NULL) {
            NSLog(@"lineOringins Error");
            return nil ;
        }
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, linesCount), lineOrigins);
    }
    // calculate line frame
    for (NSUInteger i = 0; i < linesCount; i ++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(linesRef, i);
        CFArrayRef runsRef = CTLineGetGlyphRuns(lineRef);
        if (!runsRef || CFArrayGetCount(runsRef) == 0) {
            continue ;
        }
        CGPoint lineOringin = lineOrigins[i];
        CGPoint position;
        position.x = pathBoxRct.origin.x + lineOringin.x;
        position.y = pathBoxRct.size.height + pathBoxRct.origin.y - lineOringin.y;
        
        ASTextLine * aLine = [ASTextLine lineWithCTLine:lineRef position:position];
        
    }
    
    
    
//fail:
//    if (pathRef) CFRelease(pathRef);
////    if (ctSetter) CFRelease(ctSetter);
////    if (ctFrame) CFRelease(ctFrame);
////    if (lineOrigins) free(lineOrigins);
////    if (lineRowsEdge) free(lineRowsEdge);
////    if (lineRowsIndex) free(lineRowsIndex);
//    return nil;
    
    return nil ;
}


@end
