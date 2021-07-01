# SSAnimatedBox

### 一个可以拖动调整长宽高的立方体盒子

最近接到需求，要做一个可以用slider控制长宽高，并且支持自适应画布大小的立方体盒子。

先上效果图

![截屏2021-07-01 上午11.07.08.png](https://upload-images.jianshu.io/upload_images/4822184-36e27874c1c67b1e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/240)



需要自己建立一个立方体，然后给八个顶点命名。

![37D5E690-FF15-4BBF-A509-B15DDE3A401B.png](https://upload-images.jianshu.io/upload_images/4822184-70f365ea1aacdf8d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/240)

我们分析一下，需要画出来的一共有8个顶点，3个面（里面的面如因为被挡住了，所以不需要画），12根边。

##### 为此，建立一个立方体对应的Model，在Model中把传入的长宽高转化为立方体的八个顶点的坐标值。
**侧边的边长是w的话，那么y0的值就是w/√2，y1就是长L+ w/√2，然后依次算出y2、y3、z0-z3。**

```
-(void)updateL:(CGFloat )L w:(CGFloat)w h:(CGFloat)h canvas:(CGRect)canvas {
    CGFloat geng = 0.707;// 根号2分之一
    
    self.y0 = CGPointMake(w*geng, 0); //newy0;
    self.y1 = CGPointMake(L + w *geng, 0);// newy1;
    self.y2 = CGPointMake(L, w * geng);// newy2;
    self.y3 = CGPointMake(0, w * geng);// newy3;
    self.z0 = CGPointMake( w * geng, h);// newz0;
    self.z1 = CGPointMake(L + w * geng, h) ;//newz1;
    self.z2 = CGPointMake(L, h + w * geng);// newz2;
    self.z3 = CGPointMake(0, h + w * geng);// newz3;
}
```


给画笔设置颜色

```
    [color set];
```
然后先画前面一个面:

```
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
```

然后同理依次画右边，上边的面:

```
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
```

然后再画12条边：

首先设置虚线的样式

```
 //画虚线
    CGFloat dashArray[] = {2, 4}; // 表示先绘制2个点，再跳过4个点
    CGContextSetLineDash(context, 0, dashArray, 2); // 画虚线

    //指定直线样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 1);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
```

然后依次绘制12条边:

```
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
```

以上，就是一个立方体的绘制过程。

滑动slider时，只需要把对应的slider的value乘以长宽高的最大值，就得到每条边的实际值。

```
    CGFloat l = self.maxL * self.sliderL.value;
    CGFloat w = self.maxW * self.sliderW.value;
    CGFloat h = self.maxH * self.sliderH.value;
```

然后更新立方体

```
    [self.boxView updateL:l  w:w h: h];

```

##### 我们还有一个要求就是，如果立方体的任意一边超出画布后，需要把画布进行缩放以适应整个立方体全部显示在画布内。
因为我们的立方体始终在画布的左下角，所以只需要判断右上角有没有超出画布范围就好了。（如果你们没有要求在左下角，那只需要判断右下角即可，总之需要把所有顶点都显示出来）

```
if (self.y1.x > canvas.size.width || self.y1.y < 0) {
        //超出画布区域，实行缩放画布
        
        CGFloat ratioX = self.y1.x / canvas.size.width;
        CGFloat ratioY = (canvas.size.height - self.y1.y) / canvas.size.height;
        
        CGFloat ratio = MAX(ratioX, ratioY);
        //画布缩小到 ratio
        if (self.ratioBlock) {
            self.ratioBlock(ratio);
        }
    }
```

以上，基本就是全部内容。
