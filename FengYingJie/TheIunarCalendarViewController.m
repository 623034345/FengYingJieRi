//
//  TheIunarCalendarViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/24.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "TheIunarCalendarViewController.h"

@interface TheIunarCalendarViewController ()
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation TheIunarCalendarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    DataCalender *dataCalend = [[DataCalender alloc] init];
//    dataCalend.frame = self.view.bounds;
//    [self.view addSubview:dataCalend];
    
    NSDate *date = [NSDate date];
    UICalender *ca = [[UICalender alloc] initWithCurrentDate:date];
    ca.frame = CGRectMake(0, 64, DeviceWidth, self.view.bounds.size.height - 64);
    
    [self.view addSubview:ca];

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
