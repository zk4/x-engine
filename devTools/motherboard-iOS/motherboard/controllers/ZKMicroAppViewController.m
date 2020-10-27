//
//  ZKMicroAppViewController.m
//  motherboard
//
//  Created by 李宫 on 2020/10/23.
//  Copyright © 2020 zk. All rights reserved.
//

#import "ZKMicroAppViewController.h"
#import <Masonry/Masonry.h>
#import "Prefix.h"
#import "ZKTYScanViewController.h"
#import <MircroAppController.h>

@interface ZKMicroAppViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) UIButton * scanBtn;
@property (strong,nonatomic)NSMutableArray * scanResultArr;
@end

@implementation ZKMicroAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scanResultArr = [[NSMutableArray alloc]init];
    self.title = @"微应用";
    [self setUpUI];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)setUpUI{
    _searchBar.layer.borderWidth=1;
    _searchBar.layer.borderColor=[UIColor whiteColor].CGColor;
    
    //扫描按钮
    _scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, CGRectGetMaxY(self.searchBar.frame) +50, (kWidth-48)/4, (kWidth-48)/4)];
    _scanBtn.layer.borderWidth = 1;
    _scanBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_scanBtn setImage:[UIImage imageNamed:@"dsapp_addImg"] forState:UIControlStateNormal];
    [_scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    _scanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _scanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_scanBtn];
}

- (IBAction)goMicroAppAction:(UIButton *)sender {
    if (self.searchBar.text.length > 0) {
        NSDictionary * dataDic = @{
            @"image":@"1",
            @"url":self.searchBar.text
        };
        BOOL containBool = [self.scanResultArr containsObject:dataDic];
        if (!containBool) {
            [self.scanResultArr addObject:dataDic];
        }
        [self reloadUIView];
        MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:self.searchBar.text];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webLaderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    [self.searchBar resignFirstResponder];
}

-(void)scanAction{
    ZKTYScanViewController *vc = [[ZKTYScanViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.block = ^(NSString *data) {
        MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:data];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webLaderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
        self.searchBar.text = data;
        NSDictionary * dataDic = @{
            @"image":@"1",
            @"url":data
        };
        BOOL containBool = [self.scanResultArr containsObject:dataDic];
        if (!containBool) {
            [weakSelf.scanResultArr addObject:dataDic];
        }
        [weakSelf reloadUIView];
        
    };
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)reloadUIView{
    if (self.scanResultArr.count > 0) {
        for (int i=0; i<self.scanResultArr.count;i++) {
            UIButton * imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(21 + (i%4)*((kWidth-48)/4+2), CGRectGetMaxY(self.searchBar.frame) +50+(i/4)*(20 + (kWidth-48)/4), (kWidth-48)/4, (kWidth-48)/4)];
            imageBtn.tag = i;
            [imageBtn addTarget:self action:@selector(goWebAction:) forControlEvents:UIControlEventTouchUpInside];
            imageBtn.backgroundColor = [UIColor orangeColor];
            imageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageBtn];
        }
        self.scanBtn.frame = CGRectMake(21 + (self.scanResultArr.count%4)*((kWidth-48)/4+2), CGRectGetMaxY(self.searchBar.frame) +50 +(self.scanResultArr.count/4)*(20+(kWidth-48)/4), (kWidth-48)/4, (kWidth-48)/4);
    }
}

-(void)goWebAction:(UIButton *)sender{
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:self.scanResultArr[sender.tag][@"url"]];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webLaderVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

-(void)dismissKeyBoard{
    [self.searchBar resignFirstResponder];
}
@end
