//
//  ViewController.m
//  SSAnimatedBox
//
//  Created by wangjian on 2021/7/1.
//

#import "ViewController.h"
#import "SSBoxView.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCALE_WIDTH SCREEN_WIDTH / 375
#define SCALE_HEIGHT SCREEN_HEIGHT / 667

#define BoxL  98
#define BoxH  72
#define BoxW   (37/.707)


@interface ViewController ()

@property (nonatomic, strong) UIView *animateCube;

@property (nonatomic, strong) SSBoxView *boxView;


@property (nonatomic, assign) CGFloat width;

@property (weak, nonatomic) IBOutlet UISlider *sliderL;
@property (weak, nonatomic) IBOutlet UISlider *sliderH;
@property (weak, nonatomic) IBOutlet UISlider *sliderW;

@property (nonatomic, assign) CGFloat maxL;
@property (nonatomic, assign) CGFloat maxH;
@property (nonatomic, assign) CGFloat maxW;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGFloat canvasW = SCREEN_WIDTH - 38*2;
    CGFloat canvasH = canvasW * 2/3;
    
    //最大边界值
    self.maxL = BoxL / 52. * 200;
    self.maxW = BoxW / 39. * 100;
    self.maxH = BoxH / 38. * 150;
    
    //设置slider初始值
    self.sliderL.value =  BoxL / self.maxL;
    self.sliderW.value =  BoxW / self.maxW;
    self.sliderH.value =  BoxH / self.maxH;

    
    self.boxView = [[SSBoxView alloc]initWithFrame:CGRectMake(38,100, canvasW ,canvasH)];
    self.boxView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.05];
    
    [self.boxView initBoxModelLength:BoxL width:BoxW height:BoxH];
    [self.view addSubview:self.boxView];
    

}


- (IBAction)slider:(UISlider *)sender {
    
    CGFloat l = self.maxL * self.sliderL.value;
    CGFloat w = self.maxW * self.sliderW.value;
    CGFloat h = self.maxH * self.sliderH.value;
    
//    NSLog(@"l = %@ w = %@ h = %@",@(l),@(w),@(h));
    
    [self.boxView updateL:l  w:w h: h];
    
}

- (IBAction)reset:(id)sender {
    
    //设置slider初始值
    self.sliderL.value =  BoxL / self.maxL;
    self.sliderW.value =  BoxW / self.maxW;
    self.sliderH.value =  BoxH / self.maxH;
    
    //恢复image
    [self.boxView resetImage];
    //恢复boxView
    [self.boxView updateL:BoxL  w:BoxW h: BoxH];
    
}

@end
