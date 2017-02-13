//
//  TaoBaoAnimatedTransition.m
//  SimulateMinePageOfTaoBao
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 RuiZhang. All rights reserved.
//

#import "TaoBaoAnimatedTransition.h"


@interface TaoBaoAnimatedTransition ()

@property (nonatomic, assign) AnimatedTransitionTaoBaoModelType modelType;

@end


@implementation TaoBaoAnimatedTransition


+ (TaoBaoAnimatedTransition *)animatedTranstionTaoBao:(AnimatedTransitionTaoBaoModelType)modelType {
    
    TaoBaoAnimatedTransition *transtion = [[TaoBaoAnimatedTransition alloc] init];
    transtion.modelType = modelType;
    return transtion;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    if (self.modelType == AnimatedTransitionTaoBaoModelTypePresent) {
        
        [self present:transitionContext];
        
    } else {
        
        [self dismiss:transitionContext];
        
    }
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}


- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromeView];
    [containerView addSubview:toView];
    
    fromeView.frame = containerView.frame;
    toView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromeView.frame = CGRectMake(0, containerView.frame.size.height*4/5.0f, containerView.frame.size.width, containerView.frame.size.height);
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
    
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromeView];
    [containerView addSubview:toView];
    
    fromeView.frame = containerView.frame;
    toView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromeView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
    
}




@end
