//
//  ViewController.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/4/6.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import "DisplayView.h"
#import <CoreText/CoreText.h>
#import "ASLabel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 40)];
//    NSString *infoString=@"11111111111111111111";
//    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(1, 1)];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@-1 range:NSMakeRange(8, 1)];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(12, 1)];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(15, 1)];
//    [attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(18, 1)];
//    lbl.attributedText = attString;
//    [self.view addSubview:lbl];
    
    ASLabel * l = [[ASLabel alloc]initWithFrame:self.view.bounds];
    l.text = @"Hello world 1234567890习近平在讲话中强调，党的十八大以来，在党中央坚强领导下，我们积极推进外交理论和实践创新，完善和深化全方位外交布局，倡导和推进“一带一路”建设，深入参与全球治理体系改革和建设，坚定捍卫国家主权、安全、发展利益，加强党对外事工作的集中统一领导，走出了一条中国特色大国外交新路，取得了历史性成就";
    l.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:l];
    
    
//    UILabel * label = [[UILabel alloc]initWithFrame:self.view.bounds];
//    label.text = @"Hello world 1234567890习近平在讲话中强调，党的十八大以来，在党中央坚强领导下，我们积极推进外交理论和实践创新，完善和深化全方位外交布局，倡导和推进“一带一路”建设，深入参与全球治理体系改革和建设，坚定捍卫国家主权、安全、发展利益，加强党对外事工作的集中统一领导，走出了一条中国特色大国外交新路，取得了历史性成就";
//    label.backgroundColor = [UIColor yellowColor];
//    label.numberOfLines = 0 ;
//    [self.view addSubview:label];
    
}



@end
