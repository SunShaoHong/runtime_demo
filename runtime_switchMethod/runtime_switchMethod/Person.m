//
//  Person.m
//  runtime_switchMethod
//
//  Created by cmcc on 2019/1/23.
//  Copyright © 2019年 cmcc. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+(void)test{
    Person *person = [[Person alloc]init];
    [person getAllProperty];    // 获取所有属性
    [person getAllIvar];        // 获取所有成员变量
    [person getAllMethodList];  // 获取所有成员方法
}

// 获取所有属性
- (void)getAllProperty {unsigned int outCount =0;
    //属性列表
    objc_property_t *propertys = class_copyPropertyList(self.class, &outCount);
    for(unsigned int i =0; i < outCount; ++i) {
        objc_property_t property = propertys[i];
        //属性名
        const char * propertyName =property_getName(property);
        //属性类型@encode编码
        const char *propertyAttName =property_getAttributes(property);
        NSLog(@"属性名：%s %s", propertyName,propertyAttName);
        unsigned int outCount2 =0;
        //语义特性列表
        objc_property_attribute_t  * propertyAtts =property_copyAttributeList(property,&outCount2);
        for(unsigned int i=0;i < outCount; ++i) {
            objc_property_attribute_t properAtt = propertyAtts[i];
            //语义特性名
            const char *name = properAtt.name;
            //语义特性值
            const char *value = properAtt.value;
            NSLog(@"attName :% sattValue: %s",name,value);
        }
        free(propertyAtts);
        //需要手动释放
    }
    free(propertys);
}

// 获取所有成员变量
- (void)getAllIvar {
    unsigned int outCount =0;
    Ivar*ivars =class_copyIvarList(self.class, &outCount);
    for(unsigned int i =0; i < outCount; ++i) {
        Ivar ivar = ivars[i];
        const char *ivarName =ivar_getName(ivar);
        const char* ivarEncoder =ivar_getTypeEncoding(ivar);
        NSLog(@"变量名：:%s 变量名类型: %s",ivarName,ivarEncoder);
        }
    free(ivars);
}

// 获取所有成员方法
- (void)getAllMethodList {
    unsigned int outCount =0;Method*methods =class_copyMethodList(self.class, &outCount);
    for(unsigned int i =0; i < outCount; ++i) {Method method = methods[i];
    SEL methodName =method_getName(method);
    NSLog(@"方法名：%@",NSStringFromSelector(methodName));
    unsigned int argCount =method_getNumberOfArguments(method);
    char dst[1024];
    // C语言数组
    for(unsigned int i =0; i < argCount; ++i) {
    //获取所有参数的类型Type
    method_getArgumentType(method, i, dst,1024);
    NSLog(@"第%d个参数的类型为:%s",i,dst);
    }
    char dst2[1024];
    method_getReturnType(method, dst2,1024);
    NSLog(@"返回值类型:%s",dst2);
    }
}
@end



