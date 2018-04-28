//
//  LJGuideView.m
//  DirectShow
//
//  Created by LiJie on 2018/4/9.
//  Copyright © 2018年 LiJie. All rights reserved.
//

#import "LJGuideView.h"

#ifndef IPHONE_HEIGHT
#define IPHONE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define IPHONE_WIDTH [[UIScreen mainScreen] bounds].size.width
#endif

#define kDirectImageName    @"direct"
#define kInterval           18
#define kLabelInterval      10
#define kGuideBackColor          [UIColor redColor]

typedef NS_ENUM(NSUInteger, LJGuideDirect) {
    LJGuideDirectLeftUp = 1,
    LJGuideDirectRightUp,
    LJGuideDirectLeftDown,
    LJGuideDirectRightDown
};

@interface LJGuideView()

@property (nonatomic, assign)LJGuideDirect direct;

@property (weak, nonatomic) IBOutlet UIImageView *directImageView;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (weak, nonatomic) IBOutlet UIView *upShadowView;
@property (weak, nonatomic) IBOutlet UIView *downShadowView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upTrail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downTrail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;

@property (nonatomic, assign)BOOL isShow;

@end


@implementation LJGuideView

//+(instancetype)shareGuideView{
//    static LJGuideView* guideView;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        guideView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LJGuideView class]) owner:nil options:nil].lastObject;
//        guideView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:guideView action:@selector(tapClick:)];
//        [guideView addGestureRecognizer:tap];
//        guideView.hidden = YES;
//
//        guideView.directImageView.tintColor = kGuideBackColor;
//        guideView.upImageView.tintColor = kGuideBackColor;
//        guideView.downImageView.tintColor = kGuideBackColor;
//
//        guideView.upImageView.image = [[UIImage imageNamed:@"backColor"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        guideView.downImageView.image = [[UIImage imageNamed:@"backColor"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//
//        guideView.upImageView.layer.cornerRadius = 6;
//        guideView.downImageView.layer.cornerRadius = 6;
//        guideView.upImageView.layer.masksToBounds = YES;
//        guideView.downImageView.layer.masksToBounds = YES;
//
//        guideView.downShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
//        guideView.downShadowView.layer.shadowOffset = CGSizeMake(0, 3);
//        guideView.downShadowView.layer.shadowRadius = 3;
//        guideView.downShadowView.layer.shadowOpacity = 0.5;
//
//
//        guideView.upShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
//        guideView.upShadowView.layer.shadowOffset = CGSizeMake(0, 2);
//        guideView.upShadowView.layer.shadowRadius = 2;
//        guideView.upShadowView.layer.shadowOpacity = 0.5;
//
//        guideView.backgroundColor = [UIColor clearColor];
//        guideView.userInteractionEnabled = YES;
//        //[[UIApplication sharedApplication].delegate.window addSubview:guideView];
//    });
//    return guideView;
//}


+(instancetype)getGuideView{
    
    LJGuideView* guideView;
    guideView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LJGuideView class]) owner:nil options:nil].lastObject;
    guideView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:guideView action:@selector(tapClick:)];
    [guideView addGestureRecognizer:tap];
    guideView.hidden = YES;
    
    guideView.directImageView.tintColor = kGuideBackColor;
    guideView.upImageView.tintColor = kGuideBackColor;
    guideView.downImageView.tintColor = kGuideBackColor;
    
    guideView.upImageView.image = [[UIImage imageNamed:@"backColor"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    guideView.downImageView.image = [[UIImage imageNamed:@"backColor"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    guideView.upImageView.layer.cornerRadius = 6;
    guideView.downImageView.layer.cornerRadius = 6;
    guideView.upImageView.layer.masksToBounds = YES;
    guideView.downImageView.layer.masksToBounds = YES;
    
    guideView.downShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    guideView.downShadowView.layer.shadowOffset = CGSizeMake(0, 3);
    guideView.downShadowView.layer.shadowRadius = 3;
    guideView.downShadowView.layer.shadowOpacity = 0.5;
    
    
    guideView.upShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    guideView.upShadowView.layer.shadowOffset = CGSizeMake(0, 2);
    guideView.upShadowView.layer.shadowRadius = 2;
    guideView.upShadowView.layer.shadowOpacity = 0.5;
    
    guideView.backgroundColor = [UIColor clearColor];
    guideView.userInteractionEnabled = YES;
    return guideView;
}


/**  在tapView上点击，并显示提示信息 */
-(void)showGuide:(NSString*)guideString onView:(UIView*)tapView canTap:(BOOL)canTap showOnVC:(UIViewController *)viewController{
    if (self.superview != viewController.view) {
        [viewController.view addSubview:self];
    }
    [self showGuide:guideString onView:tapView];
    self.userInteractionEnabled = !canTap;
}

-(void)showGuide:(NSString*)guideString onView:(UIView*)tapView{
    
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    CGRect tapRect = [tapView convertRect:tapView.bounds toView:window];
    
    CGSize stringSize = [self calculateSize:guideString fontSize:14];
    
    CGFloat imageLead = 0;
    CGFloat imageTop = 0;
    CGSize imageSize = self.directImageView.bounds.size;
    CGFloat offset = imageSize.width/2.0;
    imageLead = tapRect.origin.x + tapRect.size.width/2.0 - imageSize.width/2.0;
    
    
    if (tapRect.origin.y + tapRect.size.height/2.0 >= IPHONE_HEIGHT/2.0) {
        //上边的情况
        if (tapRect.origin.x + tapRect.size.width/2.0 <= IPHONE_WIDTH/2.0) {
            //左边的情况
            self.direct = LJGuideDirectLeftUp;
            self.upLead.constant = kInterval;
            self.upTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-kInterval;
            imageLead -= offset;
        }else{
            //右边的情况
            self.direct = LJGuideDirectRightUp;
            self.upTrail.constant = kInterval;
            self.upLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-kInterval;
            imageLead += offset;
        }
        self.upLabel.hidden = NO;
        self.upImageView.hidden = NO;
        self.upShadowView.hidden = NO;
        self.downLabel.hidden = YES;
        self.downImageView.hidden = YES;
        self.downShadowView.hidden = YES;
        
        imageTop = tapRect.origin.y - imageSize.height;
        self.upLabel.text = guideString;
        self.upWidth.constant = stringSize.width + kLabelInterval*2;
        self.upHeight.constant = stringSize.height + kLabelInterval*2;
        
    }else{
        //下边的情况
        if (tapRect.origin.x + tapRect.size.width/2.0 <= IPHONE_WIDTH/2.0) {
            //左边的情况
            self.direct = LJGuideDirectLeftDown;
            self.downLead.constant = kInterval;
            self.downTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-kInterval;
            imageLead -= offset;
        }else{
            //右边的情况
            self.direct = LJGuideDirectRightDown;
            self.downTrail.constant = kInterval;
            self.downLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-kInterval;
            imageLead += offset;
        }
        self.upLabel.hidden = YES;
        self.upImageView.hidden = YES;
        self.upShadowView.hidden = YES;
        self.downLabel.hidden = NO;
        self.downImageView.hidden = NO;
        self.downShadowView.hidden = NO;
        imageTop = tapRect.origin.y + tapRect.size.height;
        self.downLabel.text = guideString;
        self.downWidth.constant = stringSize.width + kLabelInterval*2;
        self.downHeight.constant = stringSize.height + kLabelInterval*2;
    }
    
    //点击的视图 太靠屏幕边缘的两种情况
    CGFloat offsetLead = 0;
    if (imageLead < kInterval+5) {
        //太靠左边了
        if (imageLead < 6) {
            imageLead  = 6;
        }
        offsetLead = imageLead - 5;
        self.upLead.constant = offsetLead;
        self.upTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-offsetLead;
        self.downLead.constant = offsetLead;
        self.downTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-offsetLead;
    }else if (imageLead+offset*2 > IPHONE_WIDTH-kInterval-5){
        //太靠右边了
        if (imageLead+offset*2 > IPHONE_WIDTH - 6) {
            imageLead = IPHONE_WIDTH - 6 - offset*2;
        }
        offsetLead = IPHONE_WIDTH - imageLead - offset*2 - 5;
        self.upTrail.constant = offsetLead;
        self.upLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width+offsetLead;
        self.downTrail.constant = offsetLead;
        self.downLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width+offsetLead;
    }
    
    //字数太少的 四种情况
    if (imageLead < self.upLead.constant) {
        self.upLead.constant = imageLead;
        self.upTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-imageLead;
    }
    if (imageLead < self.downLead.constant) {
        self.downLead.constant = imageLead;
        self.downTrail.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-imageLead;
    }
    CGFloat imageTrial = IPHONE_WIDTH - imageLead -imageSize.width;
    if (imageTrial < self.upTrail.constant) {
        self.upTrail.constant = imageTrial;
        self.upLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-imageTrial;
    }
    if (imageTrial < self.downTrail.constant) {
        self.downTrail.constant = imageTrial;
        self.downLead.constant = IPHONE_WIDTH-kLabelInterval*2-stringSize.width-imageTrial;
    }
    
    
    self.imageTop.constant = imageTop;
    self.imageLead.constant = imageLead;
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%lu", kDirectImageName, (unsigned long)self.direct]];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.directImageView.image = image;
    
    if (!self.isShow) {
        self.hidden = NO;
        self.layer.opacity = 0.3;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        [UIView animateWithDuration:0.35 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.layer.opacity = 1;
        }];
    }
    self.isShow = YES;
}

-(void)hideGuide{
    [self dismissGuide];
}

-(void)tapClick:(UITapGestureRecognizer*)tap{
    [self dismissGuide];
}

-(void)dismissGuide{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        self.layer.opacity = 0.0;
    }completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
            [self removeFromSuperview];
        }
    }];
    
}

- (CGSize)calculateSize:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(IPHONE_WIDTH *0.8, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                    attributes:dic
                                       context:nil];
    return rect.size;
}









@end
