//
//  VideosViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2018/5/30.
//  Copyright © 2018年 Macintosh HD. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "VideosViewController.h"
#import "WMPlayer.h"
#import "WMPlayerModel.h"
#import "VideoCell.h"
@interface VideosViewController ()<WKNavigationDelegate,UIWebViewDelegate,WMPlayerDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) WKWebView *webView;
@property(nonatomic,strong)    WMPlayer  *wmPlayer;//记录支不支持旋转
@property(nonatomic,strong)    UIButton *nextBtn;
@property(nonatomic,assign)    BOOL  forbidRotate;//手势返回的时候禁止旋转VC
@property(nonatomic,strong)VideoCell *currentCell;

@end

@implementation VideosViewController
//全屏的时候hidden底部homeIndicator
-(BOOL)prefersHomeIndicatorAutoHidden{
    return self.wmPlayer.isFullscreen;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return self.wmPlayer.prefersStatusBarHidden;
}
//视图控制器实现的方法
- (BOOL)shouldAutorotate{
    if (self.forbidRotate) {
        return NO;
    }
    return !self.wmPlayer.isLockScreen;
}
//viewController所支持的全部旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
    return result;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    //对于present出来的控制器，要主动的（强制的）选择VC，让wmPlayer全屏
    //    UIInterfaceOrientationLandscapeLeft或UIInterfaceOrientationLandscapeRight
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    return UIInterfaceOrientationLandscapeRight;
}
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmplayer.isFullscreen) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }else{
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
///播放暂停
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
}
///全屏按钮
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wmPlayer.isFullscreen) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }else{//非全屏
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}
///单击播放器
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    [self setNeedsStatusBarAppearanceUpdate];
}
///双击播放器
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}
///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
//    if (self.wmPlayer.isLockScreen){
//        return;
//    }
    if (self.forbidRotate==YES) {
        return ;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:
            break;
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) {
        return;
    }
    [self.wmPlayer removeFromSuperview];
    
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.backBtnStyle = BackBtnStyleClose;
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.wmPlayer.superview);
        }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = YES;
        self.wmPlayer.backBtnStyle = BackBtnStylePop;
        if(currentOrientation ==UIInterfaceOrientationPortrait){
            [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
                make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.center.equalTo(self.wmPlayer.superview);
            }];
        }else{
            [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
                make.center.equalTo(self.wmPlayer.superview);
            }];
        }
    }
    
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    //也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    //给你的播放视频的view视图设置旋转
    [UIView animateWithDuration:0.4 animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
        [self.wmPlayer layoutIfNeeded];
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    [self.view addSubview:self.table];
    [self.table registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];

    

    
}
- (void)handleDocumentOpenURL:(NSURL *)url {
    [self displayAlert:[url absoluteString]];
}

-(void) displayAlert:(NSString *) str {
 
    //file:///private/var/mobile/Containers/Data/Application/7F111913-51CD-4816-B54E-8B380A66F804/Documents/Inbox/6b47956f916ff127-1.mp4
    WMPlayerModel *playerModel = [WMPlayerModel new];
    //    playerModel.title = self.videoModel.title;
//    NSURL *URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4k" ofType:@"mp4"]];
    playerModel.videoURL = [NSURL URLWithString:str];
    [self.dataArr addObject:playerModel];
    [self.table reloadData];
    NSLog(@"地址: %@",str);
}  
#pragma mark - tableViewDelegate ----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    cell.model = self.dataArr[indexPath.row];
    cell.model.indexPath = indexPath;
    __weak __typeof(&*self) weakSelf = self;
    
    cell.startPlayVideoBlcok = ^(UIImageView *backgroundIV, WMPlayerModel *videoModel) {
        [weakSelf releaseWMPlayer];
        weakSelf.currentCell = (VideoCell *)backgroundIV.superview.superview;
        WMPlayerModel *playerModel = [WMPlayerModel new];
        playerModel.title = videoModel.title;
        playerModel.videoURL = videoModel.videoURL;
        
        weakSelf.wmPlayer = [[WMPlayer alloc] init];
        weakSelf.wmPlayer.delegate = weakSelf;
        weakSelf.wmPlayer.playerModel = playerModel;
        [backgroundIV addSubview:weakSelf.wmPlayer];
        
        [weakSelf.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(backgroundIV);
        }];
        [weakSelf.wmPlayer play];
        [weakSelf.table reloadData];
    };
    
    if (self.wmPlayer&&self.wmPlayer.superview) {
        if (indexPath.row==self.currentCell.model.indexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 274;
}




-(void)to
{
    if (!_textField.text)
    {
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_textField.text];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
 
   
   
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
//    NSString * hasVideoTestString = @"document.documentElement.getElementsByTagName(\"video\").length";
    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if(![response isEqual:[NSNull null]] && response != nil){
            //截获到视频地址了
            NSLog(@"截获到视频地址了response == %@",response);
        }else{
            //没有视频链接
        }
    }];

}
-(void)setUI{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, WIDTH - 80, 60)];
    _textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textField];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDTH - 80, 0, 80, 60);
    [btn setTitle:@"前往" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(to) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor orangeColor];
        [_webView sizeToFit];
        
        
    }
    return _webView;
}
/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [self.wmPlayer pause];
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer = nil;
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
