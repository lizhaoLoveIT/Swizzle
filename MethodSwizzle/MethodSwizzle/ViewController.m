//
//  ViewController.m
//  MethodSwizzle
//
//  Created by 李朝 on 14/11/12.
//  Copyright © 2014年 ammar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.faceImageView.image = [UIImage imageNamed:@"face"];
    self.vipImageView.image = [UIImage imageNamed:@"vip"];
    
    
}


@end
