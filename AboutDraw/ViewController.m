//
//  ViewController.m
//  AboutDraw
//
//  Created by ZhangWei-SpaceHome on 2017/3/16.
//  Copyright © 2017年 zhangwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *demoView1;
@property (nonatomic, strong) CAShapeLayer *indicateLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpView6];
    
    //bbbbbbb
    
    //create particle emitter layer'
    
    
}


-(void)setUpView6
{
    CGFloat gap = 4;
    CGFloat alpha = 0.5;
    CGFloat scale = 0.5;
    _demoView1 = [[UIView alloc] init];
    _demoView1.frame = CGRectMake((WIDTH - 150)/2, 100, 150, 150);
    _demoView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_demoView1];
    
    CAReplicatorLayer *layer =[CAReplicatorLayer layer];
    layer.frame = _demoView1.bounds;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"123"].CGImage);
    [_demoView1.layer addSublayer:layer];
    layer.shouldRasterize = YES;
    layer.rasterizationScale = [UIScreen mainScreen].scale;
    layer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, layer.bounds.size.height + gap, 0.0f);
    transform = CATransform3DScale(transform, 1.0f, -1.0f, 0.0f);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = alpha - 1.0f;
    
    //create gradient layer
    if (!_gradientLayer)
    {
        _gradientLayer = [[CAGradientLayer alloc] init];
        _demoView1.layer.mask = _gradientLayer;
        _gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                                  (__bridge id)[UIColor blackColor].CGColor,
                                  (__bridge id)[UIColor clearColor].CGColor];
    }
    
    //update mask
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // don't animate
    CGFloat total = layer.bounds.size.height * 2.0f + gap;
    CGFloat halfWay = (layer.bounds.size.height + gap) / total - 0.01f;
    _gradientLayer.frame = CGRectMake(0.0f, 0.0f, _demoView1.bounds.size.width, total);
    _gradientLayer.locations = @[@0.0f, @(halfWay), @(halfWay + (1.0f - halfWay) * scale)];
    [CATransaction commit];
    
//    CAReplicatorLayer *layer = (CAReplicatorLayer *)_demoView1.layer;
//    layer.instanceCount = 2;
//    layer.shouldRasterize = YES;
//    layer.rasterizationScale = [UIScreen mainScreen].scale;
//    layer.frame = CGRectMake((WIDTH - 150)/2, 100, 150, 150);
//    UIImage *image = [UIImage imageNamed:@"123"];
//    layer.contents = (__bridge id _Nullable)(image.CGImage);
//    [self.view.layer addSublayer:layer];
//    
//    CATransform3D transform = CATransform3DIdentity;
//    CGFloat verticalOffset = layer.bounds.size.height + 2;
//    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
//    transform = CATransform3DScale(transform, 1, -1, 0);
//    layer.instanceTransform = transform;
//    
//    layer.instanceAlphaOffset = -0.6;
//    [CATransaction begin];
//    [CATransaction commit];
}

-(void)setUpView5
{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerUnordered;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"123"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
}


-(void)setUpView4
{
    _demoView1 = [[UIView alloc] init];
    _demoView1.frame = CGRectMake((WIDTH - 150)/2, 100, 150, 150);
    _demoView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_demoView1];
    
    CGPoint centerPoint = CGPointMake(_demoView1.width/2, _demoView1.height/2);
    CGFloat redius = _demoView1.height/2;
    
    self.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:redius startAngle:M_PI endAngle:-M_PI clockwise:NO];
    
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = self.path.CGPath;
    _indicateLayer.strokeColor = [UIColor redColor].CGColor;
    _indicateLayer.fillColor = [UIColor clearColor].CGColor;
    _indicateLayer.lineWidth = 4;
    [_demoView1.layer addSublayer:_indicateLayer];
    
}

-(void)setUpView3
{
    _demoView1 = [[UIView alloc] init];
    _demoView1.frame = CGRectMake((WIDTH - 150)/2, 100, 150, 150);
    _demoView1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_demoView1];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _demoView1.bounds;
    
    _path = [UIBezierPath bezierPathWithOvalInRect:_demoView1.bounds];
    shapeLayer.path = _path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_demoView1.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount = HUGE;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

-(void)setUpView2
{
    _demoView1 = [[UIView alloc] init];
    _demoView1.frame = CGRectMake((WIDTH - 50)/2, 100, 50, 90);
    _demoView1.backgroundColor = [UIColor whiteColor];
    _demoView1.layer.cornerRadius = 25;
    _demoView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _demoView1.clipsToBounds = YES;
    _demoView1.layer.borderWidth = 0.5;
    [self.view addSubview:_demoView1];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = CGRectMake((WIDTH - 200)/2, _demoView1.bottom + 30, 200, 40);
    [self.view addSubview:slider];
    
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderChange:(UISlider *)slider
{
    [_indicateLayer removeFromSuperlayer];
    _indicateLayer = nil;
    _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, _demoView1.height*(1-slider.value), _demoView1.width, _demoView1.height*(slider.value)) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = _path.CGPath;
    _indicateLayer.fillColor = [UIColor orangeColor].CGColor;
    [_demoView1.layer addSublayer:_indicateLayer];
}

-(void)setUpView1
{
    UIView *demoView = [[UIView alloc] init];
    demoView.backgroundColor = [UIColor orangeColor];
    demoView.frame = CGRectMake((WIDTH - 200)/2, UI_NAV_HEIGHT+(WIDTH - 200)/2, 50, 75);
    [self.view addSubview:demoView];
    
    CGFloat viewWidth = demoView.width;
    CGFloat viewHeight = demoView.height;
    CGFloat rightSpace = 15;
    CGFloat top = 20;
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, 0)];
    [_path addLineToPoint:CGPointMake(viewWidth - rightSpace, 0)];
    [_path addLineToPoint:CGPointMake(viewWidth - rightSpace, top)];
    [_path addLineToPoint:CGPointMake(viewWidth, top)];
    [_path addLineToPoint:CGPointMake(viewWidth - rightSpace, top*2)];
    [_path addLineToPoint:CGPointMake(viewWidth - rightSpace, viewHeight)];
    [_path addLineToPoint:CGPointMake(0, viewHeight)];
    [_path closePath];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = _path.CGPath;
    demoView.layer.mask = layer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
