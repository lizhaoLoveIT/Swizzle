//
//  ViewController.m
//  MethodSwizzle
//
//  Created by 李朝 on 14/11/12.
//  Copyright © 2014年 ammar. All rights reserved.
//

#import <objc/runtime.h>

@implementation NSObject(AMExtension)
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}
@end

@implementation NSArray(Extension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(AM_objectAtIndex:)];
}

- (id)AM_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self AM_objectAtIndex:index];
    } else {
        return nil;
    }
}

@end

@implementation NSMutableArray(Extension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(AM_addObject:)];
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(AM_objectAtIndex:)];
}

- (void)AM_addObject:(id)object
{
    if (object != nil) {
        [self AM_addObject:object];
    }
}

- (id)AM_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self AM_objectAtIndex:index];
    } else {
        return nil;
    }
}
@end