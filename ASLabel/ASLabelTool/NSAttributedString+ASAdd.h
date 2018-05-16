//
//  NSMutableString+ASAdd.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (ASAdd)

@property (nullable, nonatomic, strong, readonly) UIFont  *font;
@property (nullable, nonatomic, strong, readonly) UIColor *color;
@property (nullable, nonatomic, strong, readonly) UIColor *backgroundColor;
@property (nonatomic, readwrite) NSTextAlignment alignment;
@property (nullable, nonatomic, strong, readonly) NSParagraphStyle *paragraphStyle;

@end



@interface NSMutableAttributedString (TextAdd)

@property (nullable, nonatomic, strong, readwrite) UIFont  *font;
@property (nullable, nonatomic, strong, readwrite) UIColor *color;
@property (nullable, nonatomic, strong, readwrite) UIColor *backgroundColor;

@property (nullable, nonatomic, strong, readwrite) NSParagraphStyle *paragraphStyle;
@property (nonatomic, readwrite) NSTextAlignment alignment;

- (void)removeAttributes:(NSRange)range ;

@end


@interface NSParagraphStyle (ASAdd)
+ (nullable NSParagraphStyle *)styleWithCTStyle:(CTParagraphStyleRef _Nullable )CTStyle;
@end
