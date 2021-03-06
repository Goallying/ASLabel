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
    
    NSMutableAttributedString * s  = [[NSMutableAttributedString alloc]initWithString:@"灭霸被捕照片走红，模仿漫威搞笑漫画场景。《复仇者联盟3：无限战争》（Avengers： Infinity War）打破“超级英雄不能死”的印象，大反派灭霸成为众矢之的，因此一张“灭霸在多伦多遭到逮补”的照片令人振奋，瞬间在网络疯传多日，未料照片背后真相藏了超大的泪点。"];
    
    UIImage * image = [UIImage imageNamed:@"baskatball"];
    NSMutableAttributedString * attach = [NSMutableAttributedString attachmentWithContent:image font:[UIFont systemFontOfSize:20] size:image.size textAlignment:NSTextVerticalAlignmentCenter];
    [s appendAttributedString:attach];
    [s appendAttributedString:s.mutableCopy];
    
    //font问题，排版问题。
    ASLabel * l = [[ASLabel alloc]initWithFrame:self.view.bounds];
    l.backgroundColor = [UIColor yellowColor];
    l.numberOfLines = 0 ;
    l.verticalAlignment = NSTextVerticalAlignmentCenter ;
    l.font = [UIFont systemFontOfSize:20] ;
    l.attributedText = s ;
    [self.view addSubview:l];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          l.text = @"Hello World";
//        l.font = [UIFont systemFontOfSize:12];
//        l.textAlignment = NSTextAlignmentRight ;
    });
    
//minimumInteritemSpacing
//    UILabel * label = [[UILabel alloc]initWithFrame:self.view.bounds];
//    label.text = @"Hello world 1234567890习近平在讲话中强调，党的十八大以来，在党中央坚强领导下，我们积极推进外交理论和实践创新，完善和深化全方位外交布局，倡导和推进“一带一路”建设，深入参与全球治理体系改革和建设，坚定捍卫国家主权、安全、发展利益，加强党对外事工作的集中统一领导，走出了一条中国特色大国外交新路，取得了历史性成就";
//    label.backgroundColor = [UIColor yellowColor];
//    label.numberOfLines = 0 ;
//    [self.view addSubview:label];
    
//    NSString * aNSString = @"NSString";
//    CFStringRef cfString = (__bridge CFStringRef)aNSString;
//
//    //__bridge 简单互换,不涉及所有权转化,内存释放参照被转化对象释放方式。
//    //__bridge_transfer 只能用于 CF->OC， 内存由ARC 控制，不需要release
//    //__bridge_retained 只能用于 OC->CF， 内存不受ARC控制，需要release
//    NSString * aNSString2 = (__bridge_transfer NSString *)cfString ;
//    CFStringRef cfstring2 = (__bridge_retained CFStringRef)aNSString2;
    
//    NSString * aNSString3 = (__bridge NSString *)cfstring2 ;
}



@end
