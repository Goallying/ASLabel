
//
//  ASTextLine.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/8.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASTextLine.h"

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
}

@end
