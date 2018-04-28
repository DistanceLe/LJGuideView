//
//  ViewController.m
//  DirectShow
//
//  Created by LiJie on 2018/4/9.
//  Copyright © 2018年 LiJie. All rights reserved.
//

#import "ViewController.h"
#import "LJGuideView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)leftUp:(UIButton *)sender {
    [[LJGuideView getGuideView]showGuide:[self getRandomString] onView:sender canTap:NO showOnVC:self];
}
- (IBAction)rightUp:(UIButton *)sender {
    [[LJGuideView getGuideView]showGuide:[self getRandomString] onView:sender canTap:NO showOnVC:self];
}
- (IBAction)leftDown:(UIButton *)sender {
    [[LJGuideView getGuideView]showGuide:[self getRandomString] onView:sender canTap:NO showOnVC:self];
}
- (IBAction)rightDown:(UIButton *)sender {
    [[LJGuideView getGuideView]showGuide:[self getRandomString] onView:sender canTap:NO showOnVC:self];
}


-(NSString*)getRandomString{
    NSInteger count = arc4random()%100;
    NSMutableString* string = [NSMutableString string];
    for (NSInteger i = 0; i < count; i++) {
        [string appendString:@"a"];
        if (i % 6 == 0) {
            [string appendString:@" "];
        }
    }
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
