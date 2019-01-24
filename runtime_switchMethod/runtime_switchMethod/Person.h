//
//  Person.h
//  runtime_switchMethod
//
//  Created by cmcc on 2019/1/23.
//  Copyright © 2019年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *address;
}
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
+(void)test;
@end
