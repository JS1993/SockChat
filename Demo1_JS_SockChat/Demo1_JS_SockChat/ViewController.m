//
//  ViewController.m
//  Demo1_JS_SockChat
//
//  Created by  江苏 on 16/3/26.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"
@interface ViewController ()<AsyncSocketDelegate>
@property(nonatomic,strong)AsyncSocket* sreverSocket;
@property(nonatomic,strong)AsyncSocket* mySreverSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sreverSocket=[[AsyncSocket alloc]initWithDelegate:self];
    [self.sreverSocket acceptOnPort:8000 error:nil];
}
//当接收新的accept的时候
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.mySreverSocket=newSocket;//将newSocket持有住
}
//当连接成功的时候
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    [self.mySreverSocket readDataWithTimeout:-1 tag:0];
}
//当读取数据的时候
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString* string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    //保证后续数据可以持续得到
    [self.mySreverSocket readDataWithTimeout:-1 tag:0];
}
//当断开连接的时候
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
