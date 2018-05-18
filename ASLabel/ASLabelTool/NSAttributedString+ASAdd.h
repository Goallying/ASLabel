//
//  NSMutableString+ASAdd.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASAttachment.h"
#import "ASTextMacro.h"
@interface NSAttributedString (ASAdd)

@property (nullable, nonatomic, strong, readonly)NSDictionary * attributes ;
@property (nullable, nonatomic, strong, readonly) UIFont  *font;
@property (nullable, nonatomic, strong, readonly) UIColor *color;
@property (nullable, nonatomic, strong, readonly) UIColor *backgroundColor;
@property (nonatomic, readonly) NSTextAlignment alignment;
@property (nullable, nonatomic, strong, readonly) NSParagraphStyle *paragraphStyle;
@property (nonatomic, assign, readonly) NSInteger kern;
@property (nonatomic ,assign, readonly) CGFloat lineSpacing ;

+ (NSMutableAttributedString *_Nullable)attachmentWithContent:(id _Nullable )content
                                                size:(CGSize)size
                                       textAlignment:(NSTextVerticalAlignment)alignment ;
@end



@interface NSMutableAttributedString (TextAdd)

@property (nullable, nonatomic, strong, readwrite) UIFont  *font;
@property (nullable, nonatomic, strong, readwrite) UIColor *color;
@property (nullable, nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nullable, nonatomic, strong, readwrite) NSParagraphStyle *paragraphStyle;
@property (nonatomic, readwrite) NSTextAlignment alignment;
@property (nonatomic ,readwrite) NSInteger kern ;
@property (nonatomic ,readwrite) CGFloat lineSpacing ;

- (void)setTextAttachment:(ASAttachment *_Nonnull)textAttachment range:(NSRange)range ;
- (void)removeAttributes:(NSRange)range ;

@end


@interface NSParagraphStyle (ASAdd)
+ (nullable NSParagraphStyle *)styleWithCTStyle:(CTParagraphStyleRef _Nullable )CTStyle;
@end
