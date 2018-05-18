
//
//  ASTextLine.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/8.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASTextLine.h"
#import "ASTextMacro.h"
@implementation ASTextLine {
    CGFloat _firstGlyphPos ;
}

+ (instancetype)lineWithCTLine:(CTLineRef)CTLine position:(CGPoint)position{
    
    if (!CTLine) {
        NSLog(@"CTLine error");
        return nil;
    }
    ASTextLine * line = [ASTextLine new] ;
    line.position = position ;
    [line _initLine:CTLine];
    return line;
}

- (void)_initLine:(CTLineRef)line {
    
    if (_CTLine != line) {
        if (line) CFRetain(line);
        if (_CTLine) CFRelease(_CTLine);
        _CTLine = line;
    }
    
    _lineWidth = CTLineGetTypographicBounds(line, &_ascent, &_descent, &_leading);
    if (CTLineGetGlyphCount(line) > 0) {
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CTRunRef run = CFArrayGetValueAtIndex(runs, 0);
        CGPoint pos;
        CTRunGetPositions(run, CFRangeMake(0, 1), &pos);
        _firstGlyphPos = pos.x;
    }
    _bounds = CGRectMake(_position.x, _position.y - _ascent, _lineWidth, _ascent + _descent);
    _bounds.origin.x += _firstGlyphPos;
    
    //attachment.
    if (!_CTLine) return;
    CFArrayRef runs = CTLineGetGlyphRuns(_CTLine);
    NSUInteger runCount = CFArrayGetCount(runs);
    if (runCount == 0) return;
    
    NSMutableArray *attachments = [NSMutableArray new];
    NSMutableArray *attachmentRanges = [NSMutableArray new];
    NSMutableArray *attachmentRects = [NSMutableArray new];
    for (NSUInteger r = 0; r < runCount; r++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, r);
        CFIndex glyphCount = CTRunGetGlyphCount(run);
        if (glyphCount == 0) continue;
        NSDictionary *attrs = (id)CTRunGetAttributes(run);
        ASAttachment *attachment = attrs[ASTextAttachmentAttributeName];
        if (attachment) {
            CGPoint runPosition = CGPointZero;
            CTRunGetPositions(run, CFRangeMake(0, 1), &runPosition);
            
            CGFloat ascent, descent, leading, runWidth;
            CGRect runTypoBounds;
            runWidth = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
            
            runPosition.x += _position.x;
            runPosition.y = _position.y - runPosition.y;
            runTypoBounds = CGRectMake(runPosition.x, runPosition.y - ascent, runWidth, ascent + descent);
            
            CFRange range = CTRunGetStringRange(run) ;
            NSRange runRange = NSMakeRange(range.location, range.length);
            [attachments addObject:attachment];
            [attachmentRanges addObject:[NSValue valueWithRange:runRange]];
            [attachmentRects addObject:[NSValue valueWithCGRect:runTypoBounds]];
        }
    }
    _attachments = attachments.count ? attachments : nil;
    _attachmentRanges = attachmentRanges.count ? attachmentRanges : nil;
    _attachmentRects = attachmentRects.count ? attachmentRects : nil;
}

@end
