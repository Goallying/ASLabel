//
//  NSMutableString+ASAdd.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NSAttributedString+ASAdd.h"
#import <CoreText/CoreText.h>


@implementation NSAttributedString (ASAdd)

- (NSDictionary *)attributes{
   return [self attributesAtIndex:0 effectiveRange:NULL];
}
- (UIFont *)font{
    return [self attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
}
- (UIColor *)color {
    return [self attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:NULL];
}
- (UIColor *)backgroundColor{
    return [self attribute:NSBackgroundColorAttributeName atIndex:0 effectiveRange:NULL];
}
- (NSTextAlignment)alignment{
    NSParagraphStyle *style = self.paragraphStyle;
    if (!style) style = [NSParagraphStyle defaultParagraphStyle];
    return style.alignment;
}
- (NSParagraphStyle *)paragraphStyle{
    
    return [self paragraphStyleAtIndex:0];
}
- (NSParagraphStyle *)paragraphStyleAtIndex:(NSUInteger)index {
    /*
     NSParagraphStyle is NOT toll-free bridged to CTParagraphStyleRef.
     
     CoreText can use both NSParagraphStyle and CTParagraphStyleRef,
     but UILabel/UITextView can only use NSParagraphStyle.
     
     We use NSParagraphStyle in both CoreText and UIKit.
     */
    NSParagraphStyle *style = [self attribute:NSParagraphStyleAttributeName atIndex:index];
    if (style) {
        if (CFGetTypeID((__bridge CFTypeRef)(style)) == CTParagraphStyleGetTypeID()) {
            style = [NSParagraphStyle styleWithCTStyle:(__bridge CTParagraphStyleRef)(style)];
        }
    }
    return style;
}
- (NSInteger)kern{
    return [[self attribute:NSKernAttributeName atIndex:0] integerValue];
}
- (id)attribute:(NSString *)attributeName atIndex:(NSUInteger)index {
    if (!attributeName) return nil;
    if (index > self.length || self.length == 0) return nil;
    if (self.length > 0 && index == self.length) index--;
    return [self attribute:attributeName atIndex:index effectiveRange:NULL];
}
@end

@implementation NSMutableAttributedString (TextAdd)

- (void)setFont:(UIFont *)font{
    [self addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
}
- (void)setColor:(UIColor *)color{
    [self addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:NSMakeRange(0, self.length)];
}

-(void)setParagraphStyle:(NSParagraphStyle *)paragraphStyle{
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)setAlignment:(NSTextAlignment)alignment{
    
    [self enumerateAttribute:NSParagraphStyleAttributeName inRange:NSMakeRange(0, self.length) options:kNilOptions usingBlock:^(NSParagraphStyle * value, NSRange range, BOOL * _Nonnull stop) {
        NSMutableParagraphStyle *style = nil;
        if (value) {
            if (CFGetTypeID((__bridge CFTypeRef)(value)) == CTParagraphStyleGetTypeID()) {
                value = [NSParagraphStyle styleWithCTStyle:(__bridge CTParagraphStyleRef)(value)];
            }
            if (value.alignment== alignment) return;
            if ([value isKindOfClass:[NSMutableParagraphStyle class]]) {
                style = (id)value;
            } else {
                style = value.mutableCopy;
            }
        } else {
            if ([NSParagraphStyle defaultParagraphStyle].alignment == alignment) return;
            style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
        }
        style.alignment = alignment;
        [self addAttribute:NSParagraphStyleAttributeName value:style range:range];
    }];
}
- (void)setKern:(NSInteger)kern {
    [self addAttribute:NSKernAttributeName value:@(kern) range:NSMakeRange(0, self.length)];
}
- (void)removeAttributes:(NSRange)range{
    
    NSArray *keys = [NSMutableAttributedString allDiscontinuousAttributeKeys];
    for (NSString *key in keys) {
        [self removeAttribute:key range:range];
    }
    
}

+ (NSArray *)allDiscontinuousAttributeKeys {
    static NSArray *keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keys = @[(id)kCTSuperscriptAttributeName,
                 (id)kCTRunDelegateAttributeName,(id)kCTRubyAnnotationAttributeName];
        
    });
    return keys;
}


@end

@implementation NSParagraphStyle (ASAdd)
+ (NSParagraphStyle *)styleWithCTStyle:(CTParagraphStyleRef)CTStyle {
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat lineSpacing;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing)) {
        style.lineSpacing = lineSpacing;
    }
#pragma clang diagnostic pop
    
    CGFloat paragraphSpacing;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing)) {
        style.paragraphSpacing = paragraphSpacing;
    }
    
    CTTextAlignment alignment;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment)) {
        style.alignment = NSTextAlignmentFromCTTextAlignment(alignment);
    }
    
    CGFloat firstLineHeadIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &firstLineHeadIndent)) {
        style.firstLineHeadIndent = firstLineHeadIndent;
    }
    
    CGFloat headIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierHeadIndent, sizeof(CGFloat), &headIndent)) {
        style.headIndent = headIndent;
    }
    
    CGFloat tailIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierTailIndent, sizeof(CGFloat), &tailIndent)) {
        style.tailIndent = tailIndent;
    }
    
    CTLineBreakMode lineBreakMode;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &lineBreakMode)) {
        style.lineBreakMode = (NSLineBreakMode)lineBreakMode;
    }
    
    CGFloat minimumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &minimumLineHeight)) {
        style.minimumLineHeight = minimumLineHeight;
    }
    
    CGFloat maximumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &maximumLineHeight)) {
        style.maximumLineHeight = maximumLineHeight;
    }
    
    CTWritingDirection baseWritingDirection;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(CTWritingDirection), &baseWritingDirection)) {
        style.baseWritingDirection = (NSWritingDirection)baseWritingDirection;
    }
    
    CGFloat lineHeightMultiple;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(CGFloat), &lineHeightMultiple)) {
        style.lineHeightMultiple = lineHeightMultiple;
    }
    
    CGFloat paragraphSpacingBefore;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &paragraphSpacingBefore)) {
        style.paragraphSpacingBefore = paragraphSpacingBefore;
    }
    
    if ([style respondsToSelector:@selector(tabStops)]) {
        CFArrayRef tabStops;
        if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierTabStops, sizeof(CFArrayRef), &tabStops)) {
            if ([style respondsToSelector:@selector(setTabStops:)]) {
                NSMutableArray *tabs = [NSMutableArray new];
                [((__bridge NSArray *)(tabStops))enumerateObjectsUsingBlock : ^(id obj, NSUInteger idx, BOOL *stop) {
                    CTTextTabRef ctTab = (__bridge CFTypeRef)obj;
                    
                    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentFromCTTextAlignment(CTTextTabGetAlignment(ctTab)) location:CTTextTabGetLocation(ctTab) options:(__bridge id)CTTextTabGetOptions(ctTab)];
                    [tabs addObject:tab];
                }];
                if (tabs.count) {
                    style.tabStops = tabs;
                }
            }
        }
        
        CGFloat defaultTabInterval;
        if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierDefaultTabInterval, sizeof(CGFloat), &defaultTabInterval)) {
            if ([style respondsToSelector:@selector(setDefaultTabInterval:)]) {
                style.defaultTabInterval = defaultTabInterval;
            }
        }
    }
    
    return style;
}
@end
