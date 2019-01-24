
//
//  UIView+changeBGView.m
//  runtime_switchMethod
//
//  Created by cmcc on 2019/1/23.
//  Copyright © 2019年 cmcc. All rights reserved.
//

#import "UIView+changeBGView.h"
#import <objc/runtime.h> //引入文件

@implementation UIView (changeBGView)

+(void)load{
    /** 获取原始setBackgroundColor方法 */
    Method originMethod = class_getInstanceMethod([self class], @selector(setBackgroundColor:));
    
    /** 获取自定义的new_setBackgroundColor方法 */
    Method newMethod = class_getInstanceMethod([self class], @selector(new_setBackgroundColor:));
    
    /** 交换方法 */
    method_exchangeImplementations(originMethod, newMethod);
}

/***
获取自定义的new_setBackgroundColor方法
注意：交换方法的时候newMethod里就不能再调用originMethod方法了，
因为调用originMethod方法实质上相当于调用newMethod方法，会循环引用造成死循环。
 ***/
-(void)new_setBackgroundColor:(UIColor*)color{
    /**
     1.更改颜色
     2.所有继承自UIView的控件,设置背景色都会设置成自定义的'redColor'
     3. 此时调用的方法 'new_setBackgroundColor' 相当于调用系统的 'setBackgroundColor' 方法,原因是在load方法中进行了方法交换.
     4. 注意:此处并没有递归操作.
     */
    [self new_setBackgroundColor:[UIColor redColor]];
    self.layer.borderWidth = 2;
    NSLog(@"方法替换");
}
@end
