//
//  UIButton+DoubleClick.m
//  Runtime_ButtonClick
//
//  Created by 陈舒澳 on 16/4/12.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "UIButton+DoubleClick.h"
#import "NSObject+swizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>
static const char * ButtonTimeInterval = "ButtonTimeInterval";
static const char * ButtonRespondState = "ButtonRespondState";
@interface UIButton ()
@property (nonatomic,assign) BOOL  pass;
@end
@implementation UIButton (DoubleClick)
#pragma mark --- 动态添加属性
- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, ButtonTimeInterval) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, ButtonTimeInterval, @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)pass{
    return [objc_getAssociatedObject(self, ButtonRespondState) boolValue];
}
- (void)setPass:(BOOL)pass{
    objc_setAssociatedObject(self, ButtonRespondState, @(pass), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark --- load方法内进行方法互换
+ (void)load{

    [self swizzleSelector:@selector(sendAction:to:forEvent:) withSwizzledSelector:@selector(custom_sendAction:to:forEvent:)];
  
}
#pragma mark --- 自定义方法的实现
- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.pass)return;
    if (self.timeInterval > 0) {
        self.pass = YES;
        [self performSelector:@selector(resetPassValue) withObject:nil afterDelay:self.timeInterval];
    }
    [self custom_sendAction:action to:target forEvent:event];
}
- (void)resetPassValue{
    [self setPass:NO];
}
@end
