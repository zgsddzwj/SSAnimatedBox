//
//  SSBoxView.m
//  OPenGLESDemo
//
//  Created by wangjian on 2021/6/30.
//

#import "SSBoxView.h"
#import "SSBoxModel.h"
#import "SSBoxImgModel.h"

@interface SSBoxView()

@property (nonatomic, assign)CGContextRef context;

@property (nonatomic, strong) SSBoxModel *boxBig;

@property (nonatomic, strong) SSBoxImgModel *imgBig;


@property (nonatomic, assign) CGFloat length;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@implementation SSBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.boxBig = [[SSBoxModel alloc] init];
        __weak typeof(self) weakSelf = self;
        self.boxBig.ratioBlock = ^(CGFloat ratio) {
            __strong typeof(self) strongSelf = weakSelf;
            //缩放立方体
            [strongSelf.boxBig updateNewL:strongSelf.length /ratio
                                        w:strongSelf.width /ratio
                                        h:strongSelf.height /ratio
                                   canvas:strongSelf.bounds];
            
            //缩放图片
            strongSelf.imgBig.imgWidth = strongSelf.imgBig.image.size.width / ratio;
            strongSelf.imgBig.imgHeight = strongSelf.imgBig.image.size.height / ratio;
            strongSelf.imgBig.imgPosition = CGPointMake(strongSelf.boxBig.z3.x, strongSelf.boxBig.z3.y-strongSelf.imgBig.imgHeight);

        };
        
        self.imgBig = [[SSBoxImgModel alloc] initWithImage:[UIImage imageNamed:@"ss_box_blue_small"]];
        
    }
    return self;
}

-(void)initBoxModelLength:(CGFloat)l width:(CGFloat)w height:(CGFloat)h{
    self.length = l;
    self.width  = w;
    self.height = h;
    [self.boxBig updateL:l w:w h:h canvas:self.bounds];
    //初始化image
    self.imgBig.imgPosition = CGPointMake(self.boxBig.z3.x, self.boxBig.z3.y-self.imgBig.imgHeight);

}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.context = UIGraphicsGetCurrentContext();
    
    [self drawImage:self.imgBig];
    
    [self drawBox:self.boxBig
          context:self.context
            color:[UIColor colorWithRed:245/255. green:108/255. blue:108/255. alpha:0.2]
        lineColor:[UIColor colorWithRed:252/255. green:134/255. blue:137/255. alpha:1]];
    
}

//重置图片
- (void)resetImage {
    
    self.imgBig.imgWidth = self.imgBig.image.size.width;
    self.imgBig.imgHeight = self.imgBig.image.size.height;
    self.imgBig.imgPosition = CGPointMake(self.boxBig.z3.x, self.boxBig.z3.y-self.imgBig.imgHeight);
}

- (void)updateL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h{
    self.length = L;
    self.width  = w;
    self.height = h;
    [self.boxBig updateL:L w:w h:h canvas:self.bounds];
    
    [self update];
}

- (void)update{
    [self setNeedsDisplay];
}


- (void)drawImage:(SSBoxImgModel *)box{
    UIImage *image  = box.image;
    CGFloat imgX    = box.imgPosition.x;
    CGFloat imgY    = box.imgPosition.y;
    [image drawInRect:CGRectMake(imgX, imgY, box.imgWidth, box.imgHeight)];
}

-(void)drawBox:(SSBoxModel *)box context:(CGContextRef )context color:(UIColor*)color lineColor:(UIColor *)lineColor {
    
    [color set];
    //画前面
    CGPoint sPoints0[4];
    sPoints0[0] = box.y3;
    sPoints0[1] = box.y2;
    sPoints0[2] = box.z2;
    sPoints0[3] = box.z3;
    CGContextAddLines(context, sPoints0, 4);//添加线
 
    [[UIColor clearColor] setStroke];//避免影响方格线
    
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    //画右边
    CGPoint sPoints[4];//坐标点
    sPoints[0] =box.y1;//坐标1
    sPoints[1] =box.z1;
    sPoints[2] = box.z2;
    sPoints[3] = box.y2;
    CGContextAddLines(context, sPoints, 4);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    //画上边
    CGPoint sPoints2[4];//坐标点
    sPoints2[0] = box.y0;
    sPoints2[1] = box.y1;
    sPoints2[2] = box.y2;
    sPoints2[3] = box.y3;
    CGContextAddLines(context, sPoints2, 4);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    
    //画虚线
    CGFloat dashArray[] = {2, 4}; // 表示先绘制2个点，再跳过4个点
    CGContextSetLineDash(context, 0, dashArray, 2); // 画虚线

    //指定直线样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 1);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);

    //开始绘制
    CGContextBeginPath(context);
    //上边
    CGContextMoveToPoint(context, box.y0.x, box.y0.y);
    CGContextAddLineToPoint(context, box.y1.x, box.y1.y);
    CGContextAddLineToPoint(context, box.y2.x, box.y2.y);
    CGContextAddLineToPoint(context, box.y3.x, box.y3.y);
    CGContextAddLineToPoint(context, box.y0.x, box.y0.y);
    //左边
    CGContextAddLineToPoint(context, box.z0.x, box.z0.y);
    CGContextAddLineToPoint(context, box.z3.x, box.z3.y);
    CGContextAddLineToPoint(context, box.y3.x, box.y3.y);
    //下边
    CGContextMoveToPoint(context, box.z0.x, box.z0.y);
    CGContextAddLineToPoint(context, box.z1.x, box.z1.y);
    CGContextAddLineToPoint(context, box.z2.x, box.z2.y);
    CGContextAddLineToPoint(context, box.z3.x, box.z3.y);

    //剩余的两根
    CGContextMoveToPoint(context, box.y2.x, box.y2.y);
    CGContextAddLineToPoint(context, box.z2.x, box.z2.y);

    CGContextMoveToPoint(context, box.y1.x, box.y1.y);
    CGContextAddLineToPoint(context, box.z1.x, box.z1.y);

    //绘制完成
    CGContextStrokePath(context);
}

@end
