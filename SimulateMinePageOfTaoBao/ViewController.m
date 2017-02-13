//
//  ViewController.m
//  SimulateMinePageOfTaoBao
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 RuiZhang. All rights reserved.
//

#import "ViewController.h"

#import "MineInfoViewController.h"



#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mineTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, assign) CGFloat move;
@property (nonatomic, strong) CAShapeLayer *shapeLayerSinf;
@property (nonatomic, strong) CAShapeLayer *shapeLayerSinfTwo;
@property (nonatomic, strong) CADisplayLink *layerDisplayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"我";
    
    [self initMinePageUI];
    
    [self addLayerDisplayLink];
    
}


#pragma mark ---------------------------- UI
- (void)initMinePageUI {

    [self.view addSubview:self.mineTableView];
    
    [self addMineTableViewHeadView];
    
    [self addWaveSinfAndWaveSinfTwo];
    self.move = 0;

    
}

- (void)addLayerDisplayLink {

    self.layerDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(layerDisplayLink:)];
    [self.layerDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}


- (UITableView *)mineTableView {
    
    if (!_mineTableView) {
        
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,  kScreen_Height)];
        _mineTableView.backgroundColor = [UIColor whiteColor];
        _mineTableView.dataSource = self;
        _mineTableView.delegate = self;
        
        _mineTableView.rowHeight = 60;
        
        _mineTableView.tableFooterView = [UIView new];
    }
    return _mineTableView;
}

- (void)addMineTableViewHeadView {
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 260)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.mineTableView.tableHeaderView = self.headView;
}


- (void)addWaveSinfAndWaveSinfTwo {

    CAShapeLayer *fillayer = [CAShapeLayer layer];
    fillayer.fillColor = [UIColor orangeColor].CGColor;
    fillayer.frame = self.headView.bounds;
    fillayer.shouldRasterize = YES;
    fillayer.path = [self addLayerBezierPath].CGPath;
    [self.headView.layer addSublayer:fillayer];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.frame = self.headView.bounds;
    layer.opacity = 0.3;
    layer.shouldRasterize = YES;
    layer.path = [self getWavePathA:8.0 W:0.04 D:25 + 60 Move:0].CGPath;
    self.shapeLayerSinf = layer;
    
    [self.headView.layer addSublayer:layer];
    
    
    CAShapeLayer *layerTwo = [CAShapeLayer layer];
    layerTwo.fillColor = [UIColor whiteColor].CGColor;
    layerTwo.frame = self.headView.bounds;
    layerTwo.opacity = 0.3;
    layerTwo.shouldRasterize = YES;
    layerTwo.path = [self getWavePathA:8.0 W:0.04 D:29 + 60 Move:10].CGPath;
    self.shapeLayerSinfTwo = layerTwo;
    
    [self.headView.layer addSublayer:layerTwo];
    
}




- (UIBezierPath *)getWavePathA:(CGFloat)a W:(CGFloat)w D:(CGFloat)d Move:(CGFloat)move {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 50)];
    
    for (int i = 0; i < kScreen_Width; i++) {
        
        CGFloat y = a * sinf(i * w + move + self.move) + d;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    [path addLineToPoint:CGPointMake(kScreen_Width, 0)];
    [path closePath];
    
    return path;
}




- (UIBezierPath *)addLayerBezierPath {
    
    CGFloat pathR = 25 + pow(kScreen_Width, 2)/400.f;
    
    CGPoint centerArc = CGPointMake(kScreen_Width/2.f, 260 - pathR);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, 210)];
    [bezierPath addArcWithCenter:centerArc radius:pathR startAngle:acos(kScreen_Width/(2 * pathR)) endAngle:(M_PI - acos(kScreen_Width/(2 * pathR))) clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(kScreen_Width, 210)];
    [bezierPath addLineToPoint:CGPointMake(kScreen_Width, 0)];
    [bezierPath closePath];
    
    return bezierPath;
    
}

#pragma mark --------------------------displayLink
- (void)layerDisplayLink:(CADisplayLink *)layerDisplayLink {

    self.move = self.move + 0.05;
    
    self.shapeLayerSinf.path = [self getWavePathA:8.0 W:0.04 D:25 + 60 Move:0].CGPath;
    
    self.shapeLayerSinfTwo.path = [self getWavePathA:8.0 W:0.04 D:29 + 60 Move:10.0].CGPath;

}

#pragma mark ------------------------TableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.backgroundColor = [UIColor lightTextColor];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < - 100) {
        
        MineInfoViewController *vc = [[MineInfoViewController alloc] init];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
