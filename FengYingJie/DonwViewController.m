//
//  DonwViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/6/29.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//
// 保存文件名
#define HSFileName(url) url.md5String
// 缓存主目录
#define HSCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HSCache"]
// 文件的存放路径（caches）
#define HSFileFullpath(url) [HSCachesDirectory stringByAppendingPathComponent:HSFileName(url)]
#import "NSString+Hash.h"

#import "DonwViewController.h"
#import "HSDownloadManager.h"
#import "DownTableViewCell.h"
@interface DonwViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *TX_Fied;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView1;
@property (weak, nonatomic) UILabel *progressLabel1;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation DonwViewController
NSString * const downloadUrl1 = @"http://120.25.226.186:32812/resources/videos/minion_01.mp4";
static NSString * CELLIDENTIFIER = @"DownCellIndentifier";


-(NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_table registerNib:[UINib nibWithNibName:@"DownTableViewCell" bundle:nil] forCellReuseIdentifier:CELLIDENTIFIER];
    [self refreshDataWithState:DownloadStateSuspended];
    [self readToPlist];
    
    NSString *cha = [self filePath:_dataArr[0]];
    NSLog(@"%@",cha);

}
- (IBAction)xiazai:(id)sender {
    
    _TX_Fied.text = downloadUrl1;
    [self download:_TX_Fied.text progressLabel:self.progressLabel1 progressView:self.progressView1 button:sender];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_TX_Fied.text forKey:@"URL"];
    [self writToWithDic:HSFileName(downloadUrl1)];

}

#pragma mark 刷新数据
- (void)refreshDataWithState:(DownloadState)state
{
    self.progressLabel1.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:downloadUrl1] * 100];
    self.progressView1.progress = [[HSDownloadManager sharedInstance] progress:downloadUrl1];
    [self.DonwButton setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
  

    NSLog(@"-----%f", [[HSDownloadManager sharedInstance] progress:downloadUrl1]);
    
}
#pragma mark 开启任务下载资源
- (void)download:(NSString *)url progressLabel:(UILabel *)progressLabel progressView:(UIProgressView *)progressView button:(UIButton *)button
{
    [[HSDownloadManager sharedInstance] download:url progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
            progressView.progress = progress;
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [button setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
        });
    }];
}
#pragma mark 按钮状态
- (NSString *)getTitleWithDownloadState:(DownloadState)state
{
    switch (state) {
        case DownloadStateStart:
            return @"暂停";
        case DownloadStateSuspended:
        case DownloadStateFailed:
            return @"开始";
        case DownloadStateCompleted:
//             HSFileName(downloadUrl1);//保持文件名

            return @"完成";
        default:
            break;
    }
}
//写plist文件
-(void)writToWithDic:(NSString *)url
{
//    NSMutableArray *resultData = [NSMutableArray array];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:@"downName.plist"];   //获取路径

//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];  //读取数据

    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filename];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filename] == NO)
        
        {
            arr = [NSMutableArray array];
            [arr addObject:url];
            NSFileManager* fileManager = [NSFileManager defaultManager];
            [fileManager createFileAtPath:filename contents:nil attributes:nil];
            [arr writeToFile:filename atomically:YES];
        }
    else
    {
        [arr addObject:url];
        [arr writeToFile:filename atomically:YES];

    }

    [self readToPlist];
    [_table reloadData];

}
//读plist文件
-(NSMutableArray *)readToPlist
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"downName.plist"];   //获取路径
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    _dataArr = [NSMutableArray arrayWithContentsOfFile:filename];
    return _dataArr;
}
-(void)xiuGaiWithIdex:(NSInteger)idex
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"downName.plist"];   //获取路径
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    _dataArr = [NSMutableArray arrayWithContentsOfFile:filename];


    [_dataArr removeObjectAtIndex:idex];
    [_dataArr writeToFile:filename atomically:YES];
    [_table reloadData];
}
#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    cell.deteleBtn.tag = indexPath.row;
    [cell.deteleBtn addTarget:self action:@selector(deleteFile1:) forControlEvents:UIControlEventTouchUpInside];
    cell.jindu.text = _dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
}
#pragma mark 删除
- (void)deleteFile1:(UIButton *)sender
{
    [[HSDownloadManager sharedInstance] deleteFile:_dataArr[sender.tag]];
    self.progressLabel1.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:_dataArr[sender.tag]] * 100];
    [self xiuGaiWithIdex:sender.tag];
}
-(NSString*)filePath:(NSString *)url
{
    NSString *temp = HSFileFullpath(url);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:temp]){
        return temp;
    }else{
        return nil;
    }
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
