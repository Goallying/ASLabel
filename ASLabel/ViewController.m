//
//  ViewController.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

#import "ASLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 40)];
    NSString *infoString=@"11111111111111111111";
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
    
    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(1, 1)];
    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@-1 range:NSMakeRange(8, 1)];
    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(12, 1)];
    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(15, 1)];
    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(18, 1)];
    
    lbl.attributedText = attString;
    
    [self.view addSubview:lbl];
    
    ASLabel * l = [ASLabel new];
    l.text = @"2222222";
    [self.view addSubview:l];
}



@end