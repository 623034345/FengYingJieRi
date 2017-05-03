//
//  LCPanNavigationController.h
//  PanBackDemo
//
//  Created by clovelu on 5/30/14.
//
//

#import <UIKit/UIKit.h>

@protocol LCPanGestureDelegateProtocol <NSObject>
//增加导航控制器手势执行的其他判断条件,如果返回NO就直接关闭手势相应，如果返回YES就继续执行自己的判断。
- (BOOL)otherGestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer;
@end

@interface LCPanNavigationController : UINavigationController
@property (readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (readonly, nonatomic, weak) id<LCPanGestureDelegateProtocol> child;
@end

@protocol LCPanBackProtocol <NSObject>
- (BOOL)enablePanBack:(LCPanNavigationController *)panNavigationController;
- (void)startPanBack:(LCPanNavigationController *)panNavigationController;
- (void)finshPanBack:(LCPanNavigationController *)panNavigationController;
- (void)resetPanBack:(LCPanNavigationController *)panNavigationController;

@end

