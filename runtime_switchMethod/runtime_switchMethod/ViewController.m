//
//  ViewController.m
//  runtime_switchMethod
//
//  Created by cmcc on 2019/1/23.
//  Copyright © 2019年 cmcc. All rights reserved.
//

#import "ViewController.h"
#import "UIView+changeBGView.h"
#import "NSObject+Person.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* btn = [UIButton new];
    //（一、方法替换）调用替换方法-(void)new_setBackgroundColor:(UIColor*)color
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(100, 100, 80, 50);
    [btn setTitle:@"button" forState:UIControlStateNormal];
    //（五、）动态添加方法
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIView* view = [UIView new];
    view.frame = CGRectMake(100, 300, 80, 50);
    //调用替换方法-(void)new_setBackgroundColor:(UIColor*)color
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    //(二、获取类对象成员变量及方法)
    [Person test];
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"sunshaohong";
    NSLog(@"name: %@", objc.name);
    
}


#pragma mark 动态添加方法
- (IBAction)clickBtn:(id)sender {
    [self performSelector:@selector(play)];
}
void play(id self, SEL _cmd) {
    NSLog(@"动态添加成功");
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:vc animated:YES completion:nil];
}
+ (BOOL)resolveInstanceMethod:(SEL)aSEL{
    if (aSEL ==  NSSelectorFromString(@"play")) {
        class_addMethod(self, aSEL, (IMP) play, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}


@end







