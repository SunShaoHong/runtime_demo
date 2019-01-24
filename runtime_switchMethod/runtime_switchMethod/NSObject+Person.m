//
//  NSObject+Person.m
//  runtime_switchMethod
//
//  Created by cmcc on 2019/1/23.
//  Copyright © 2019年 cmcc. All rights reserved.
//

#import "NSObject+Person.h"
#import <objc/runtime.h> //引入文件

static NSString *nameKey = @"nameKey"; //name的key
@implementation NSObject (Person)
//setter方法
-(void)setName:(NSString *)name{
    //1.源对象(self)
    //2.关联时的用来标记是哪一个属性的key（因为你可能要添加很多属性，这里咱们填写的是&nameKey）
    //3.关联的对象（name）
    //4.一个关联策略（OBJC_ASSOCIATION_COPY）。
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY);
}
//getter方法
-(NSString*)name{
    return objc_getAssociatedObject(self, &nameKey);
}
@end
