//
//  ASRunDelegate.m
//  ASLabel
//
//  Created by 朱来飞 on 2018/5/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ASRunDelegate.h"

@implementation ASRunDelegate
static void DeallocCallback(void *ref) {
    ASRunDelegate *self = (__bridge_transfer ASRunDelegate *)(ref);
    self = nil; // release
}

static CGFloat GetAscentCallback(void *ref) {
    ASRunDelegate *self = (__bridge ASRunDelegate *)(ref);
    return self.ascent;
}

static CGFloat GetDecentCallback(void *ref) {
    ASRunDelegate *self = (__bridge ASRunDelegate *)(ref);
    return self.descent;
}

static CGFloat GetWidthCallback(void *ref) {
    ASRunDelegate *self = (__bridge ASRunDelegate *)(ref);
    return self.size.width;
}

- (CTRunDelegateRef)CTRunDelegate CF_RETURNS_RETAINED {
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateCurrentVersion;
    callbacks.dealloc = DeallocCallback;
    callbacks.getAscent = GetAscentCallback;
    callbacks.getDescent = GetDecentCallback;
    callbacks.getWidth = GetWidthCallback;
    return CTRunDelegateCreate(&callbacks, (__bridge_retained void *)self);
}

@end
