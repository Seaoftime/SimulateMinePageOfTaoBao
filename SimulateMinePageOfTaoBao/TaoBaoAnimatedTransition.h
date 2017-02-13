//
//  TaoBaoAnimatedTransition.h
//  SimulateMinePageOfTaoBao
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 RuiZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, AnimatedTransitionTaoBaoModelType) {
    AnimatedTransitionTaoBaoModelTypePresent,
    AnimatedTransitionTaoBaoModelTypeDismiss
};


@interface TaoBaoAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (TaoBaoAnimatedTransition *)animatedTranstionTaoBao:(AnimatedTransitionTaoBaoModelType)modelType;

@end












