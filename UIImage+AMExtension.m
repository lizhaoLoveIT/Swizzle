//
//  UIImage+AMExtension.m
//  MethodSwizzle
//
//  Created by 李朝 on 14/11/12.
//  Copyright © 2014年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UIImage (AMExtension)

// method swizzle 只需要有一次，在分类载进内存时只需要调用一次
+ (void)load
{
    Method originalMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method ourMethod = class_getClassMethod(self, @selector(AM_imageNamed:));
    method_exchangeImplementations(originalMethod, ourMethod);
}

// 写一个 AM_imageNamed:方法
+ (UIImage *)AM_imageNamed:(NSString *)name
{
    // 判断设备是否是 iOS7 以上
    BOOL isIOS7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    UIImage *image = nil;
    
    // 如果是，则换成支持 iOS7 的图片
    if (isIOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        
        // 此处需要注意，因为方法实现已经交换所以如果我们想调用系统的方法需要使用我们的方法名
        image = [UIImage AM_imageNamed:newName];
        
    } else {
        image = [UIImage AM_imageNamed:name];
    }
    
    return image;
}

@end
