//
//  ViewController.m
//  NSURLSessionConfiguration (配置)
//
//  Created by Aotu on 16/3/9.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionDownloadDelegate>
{
    NSURLSessionDownloadTask *_downLoadTask;
    NSURLSessionConfiguration *_sessionConfiguration;
    NSURLRequest *_request;
    NSURLSession *_session;
    NSData *_partial; //部分下载好的data
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UIImageView *showImageVIew2;

@property (weak, nonatomic) IBOutlet UIImageView *showBigImageVIew;

@property (weak, nonatomic) IBOutlet UIProgressView *progressVIew;
@property (weak, nonatomic) IBOutlet UIButton *dowmloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *resume;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     NSURLSesssion提供的功能
     1.通过url 可以将数据下载到内存
     2.通过url,将数据下载到文件系统
     3.将数据上传到指定url
     4.灵活且强大的后台处理能力
     
     
     */
    
    /*
     用法
     使用NSURLSession的一般套路如下：
     
     1. 定义一个NSURLRequest
     2. 定义一个NSURLSessionConfiguration，配置各种网络参数
     3. 使用NSURLSession的工厂方法获取一个所需类型的NSURLSession
     4. 使用定义好的NSURLRequest和NSURLSession构建一个NSURLSessionTask
     5. 使用Delegate或者CompletionHandler处理任务执行过程的所有事件。

     */
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://photo.l99.com/bigger/20/1369291999760_0czr7j.jpg"]];

    //(一) NSURLSessionConfiguration 配置参数
//    三种模式可供创建
//    默认session || 瞬时session || 后台Session
    //1
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //1.1
    sessionConfiguration.allowsCellularAccess = YES ; //指定是否允许使用蜂窝网络
    //1.2
    //如果 sessionConfiguration模式为 后台模式 backgroundSessionConfigurationWithIdentifier 则⬇️
    sessionConfiguration.discretionary = YES;  //标示当程序后台运行时候,由系统自己选择最合适的网络链接配置
    
    
    //(二)NSURLSession
    
    //首先,得获取一个session
    //2.获取NSURLSession的几种方法
    //2.1 静态的sharedSession ,官方文档说其使用共享的方法获取session,这种方式获取的session拥有全局的Cache,Cookie,证书,
    NSURLSession *session1 = [NSURLSession sharedSession];
    
    //2.2一般创建方法 与NSURLSessionConfiguration 组合使用
    NSURLSession *session2 = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    //2.3 带delegate & delegateQueue
    NSURLSession *session3 = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    [session3 invalidateAndCancel]; //当不需要连接时 调用此方法取消
    
    
    //(三) 构建Task处理
    
    //3 NSURLSessionTask (网络请求处理类) 包含三个子类 NSURLSessionDataTask(可以说上传内容,且上传后可下载) || NSURLSessionUploadTask(上传用的task,不能再下载) NSURLSessionDownloadTask(仅下载用的task)
    
    //3.1 NSURLSessionDataTask 创建方法
    
    //基于reques 创建
    NSURLSessionDataTask *dataTaskREQ = [session1 dataTaskWithRequest:request];
   
    //基于Url    创建
    NSURLSessionDataTask *dataTaskURL = [session2 dataTaskWithURL:[NSURL URLWithString:@"http://photo.l99.com/bigger/20/1369291999760_0czr7j.jpg"]];
    //基于request 创建 带Block返回 data数据 response error等信息
    NSURLSessionDataTask *dataTaskREQWith =  [session2 dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data === %@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            _showImageView.image = [UIImage imageWithData:data];
        });
    }];
    
    //基于Url创建 带Block返回 Data数据 response error等信息
    NSURLSessionDataTask *dataTaskURLWith = [session2 dataTaskWithURL:[NSURL URLWithString:@"http://tupian.enterdesk.com/2013/lxy/12/30/2/5.jpg"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data === %@",data);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _showImageVIew2.image = [UIImage imageWithData:data];
        });
        
        
    }];
    
    //3.2 NSURLSessionUploadTask
    NSURLSessionUploadTask *uploadTask1 = [session2 uploadTaskWithRequest:request fromData:nil];
    NSURLSessionUploadTask *uploadTask2 = [session2 uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error111 === %@",error);
        
    }];
    NSURLSessionUploadTask *uploadTask3 = [session2 uploadTaskWithRequest:request fromFile:nil];
    NSURLSessionUploadTask *uploadTask4 = [session2 uploadTaskWithRequest:request fromFile:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //由于没有后台服务器支持 故上传实现不了 这里写上方法
    }];
    NSURLSessionUploadTask *uploadTask5 = [session2 uploadTaskWithStreamedRequest:request];

    
    //3.3NSURLSessionDownloadTask
    NSURLSessionDownloadTask *downLoadTask1 = [session2 downloadTaskWithRequest:request];
    NSURLSessionDownloadTask *downLoadTask2 = [session2 downloadTaskWithURL:[NSURL URLWithString:@"http://tupian.enterdesk.com/2013/lxy/12/30/2/5.jpg"]];
//    NSURLSessionDownloadTask *downLoadTask3 = [session2 downloadTaskWithResumeData:nil];  //断点下载
    
    //同样 下载也有 completionHandler 包含的回调信息 这里就不写了
    
    
    //4 调用resume 开始执行
    [dataTaskREQ resume];
    [dataTaskURL resume];
    [dataTaskREQWith resume];
    [dataTaskURLWith resume];
    
    [uploadTask1 resume];
    [uploadTask2 resume];
    
    [downLoadTask1 resume];
    [downLoadTask2 resume];
//    [downLoadTask3 resume];
    
    
    
    // 好了 那么下面 做一个断点续传的例子 检验下
    
    [self crateSession];
}

//配置网络
-(void)crateSession{
    
    _progressVIew.progress = 0;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tupian.enterdesk.com/2013/lxy/12/30/2/5.jpg"]];
    
    _sessionConfiguration = sessionConfiguration;
    _session = session;
    _request = request;
    
    
}

//点击下载
- (IBAction)download:(id)sender {
    
    _downLoadTask = [_session downloadTaskWithRequest:_request];
    [_downLoadTask resume];
    
    _dowmloadBtn.enabled = NO;

}

//点击暂停
- (IBAction)pause:(id)sender {
    
    if (_downLoadTask) {
        [_downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            _partial = resumeData;
            _downLoadTask = nil;
        }];
    }
}

//点击继续
- (IBAction)resume:(id)sender {
    if (!_downLoadTask) {
        
        //判断是否有下载过的数据,有就断点续传 没有就下载
        if (_partial) {
            
            _downLoadTask = [_session downloadTaskWithResumeData:_partial];  // 从已有的数据上继续下载
            
        }else{
            _downLoadTask = [_session downloadTaskWithRequest:_request];     //重新下载
            
        }
     
    }
       [_downLoadTask resume];
    
}


//download Delegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"下载完成后,文件的tem目录地址信息 %@",location);
    
    NSURL *destitnaion = [self createDirectoryWithlocationForDownloadTempByUrl:location];
    BOOL success = [self copyTempFileFormURL:location toDestination:destitnaion];

    if (success) {
        //文件保存成功
        //下载完成  显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _showBigImageVIew.image = [UIImage imageWithContentsOfFile:[destitnaion path]];
            NSLog(@"下载完成后,文件的document目录地址信息 %@",destitnaion);
        });
        
    }else if (!success){
        NSLog(@"hahahahahha");
    }
    _downLoadTask = nil;

}
//刷新进度条方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    //刷新进度条
    double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressVIew.progress = currentProgress;
//        _progressVIew.hidden = NO;
        if (currentProgress == 1) {
            _dowmloadBtn.enabled = YES;
        }
       
    });
}


//创建文件的documents的(路径)保存目录
-(NSURL*)createDirectoryWithlocationForDownloadTempByUrl:(NSURL*)location{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSLog(@"urls ********   %@",urls);
    NSURL *documentsDirectory = urls[0];
    NSLog(@"urls[0] ********   %@",documentsDirectory);
    NSLog(@" [location lastPathComponent] ********   %@",[location lastPathComponent]);
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}

//从tem复制到Documents文件夹
-(BOOL)copyTempFileFormURL:(NSURL*)location toDestination:(NSURL*)destination{

    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
