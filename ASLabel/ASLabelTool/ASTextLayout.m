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
    layout.text = text ;
    layout.container = container ;
    
   CTFramesetterRef ctSetter = CTFramesetterCreateWithAttributedString((CFTypeRef)text);
    CGMutablePathRef path = CGPathCreateMutable();
//    CTFrameRef ctframe = CTFramesetterCreateFrame(ctSetter, CFRangeMake(0, text.length), path, <#CFDictionaryRef  _Nullable frameAttributes#>)
    return layout ;
}


@end
