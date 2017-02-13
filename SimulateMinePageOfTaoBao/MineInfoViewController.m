//
//  MineInfoViewController.m
//  SimulateMinePageOfTaoBao
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 RuiZhang. All rights reserved.
//

#import "MineInfoViewController.h"


#import "TaoBaoAnimatedTransition.h"

@interface MineInfoViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor orangeColor];

    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.backBtn addTarget:self action:@selector(backBtnIsClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [TaoBaoAnimatedTransition animatedTranstionTaoBao:AnimatedTransitionTaoBaoModelTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    
    return [TaoBaoAnimatedTransition animatedTranstionTaoBao:AnimatedTransitionTaoBaoModelTypeDismiss];
}




- (void)backBtnIsClicked {

    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
