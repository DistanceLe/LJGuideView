//
//  LJGuideView.h
//  DirectShow
//
//  Created by LiJie on 2018/4/9.
//  Copyright © 2018年 LiJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJGuideView : UIView


+(instancetype)getGuideView;

/**  在tapView上点击，并显示提示信息  tap默认NO，再次点击消失*/
-(void)showGuide:(NSString*)guideString onView:(UIView*)tapView canTap:(BOOL)canTap showOnVC:(UIViewController*)viewController;


/**  如果Tap为YES，则需要 在需要消失的时候，手动调用 */
-(void)hideGuide;

@end
