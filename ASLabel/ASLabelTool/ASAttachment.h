//
//  ASAttachment.h
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAttachment : NSObject

@property (nonatomic ,strong)id content ;

+ (instancetype)attachmentWithContent:(id)content ;
@end
