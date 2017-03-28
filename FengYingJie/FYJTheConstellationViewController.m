//
//  FYJTheConstellationViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "FYJTheConstellationViewController.h"
#import "WZBDatePicker.h"

@interface FYJTheConstellationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *xuanz;

@end

@implementation FYJTheConstellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [WZBDatePicker showToView:self.TX pickerType:WZBDatePickerInputView resultDidChange:^(NSString *age, NSString *constellation){
        self.TX.text = [NSString stringWithFormat:@"%@--%@", age, constellation];
        self.TX.textColor = [UIColor blueColor];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
