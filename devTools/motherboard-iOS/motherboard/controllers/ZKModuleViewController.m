//
//  ZKModuleViewController.m
//  motherboard
//
//  Created by 李宫 on 2020/10/23.
//  Copyright © 2020 zk. All rights reserved.
//

#import "ZKModuleViewController.h"
#import <XEngineContext.h>
#import <MircroAppController.h>
#import "UIViewController+.h"
#import "moduleTableViewCell.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
@interface ZKModuleViewController ()<UITableViewDelegate, UITableViewDataSource,moduleTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView; /** tableView */

@end

@implementation ZKModuleViewController

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat navigationHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 88 : 64;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - navigationHeight) style:UITableViewStylePlain];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewSafeAreaInsetsDidChange{
    if (@available(iOS 11.0, *)){
        [super viewSafeAreaInsetsDidChange];
        NSLog(@"%f",self.tableView.safeAreaInsets.top);
        self.tableView.contentInset = UIEdgeInsetsMake(13, 0, 0, 0);
    } else {
        // Fallback on earlier versions
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([moduleTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.title = @"模块";
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    moduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell ==nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([moduleTableViewCell class]) owner:nil options:nil] lastObject];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (@available(iOS 11.0, *)){
        return 55 * 11  + 13;
    }
    return 55 * 11  ;
}

-(void)module_nav:(UIButton *)button{
    [self pushTestModule:@"com.zkty.module.nav"];
    
}

- (void)module_nav_push:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.navpush"];
    
}

- (void)module_localstorage:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.localstorage"];
}

- (void)module_camera:(UIButton * _Nullable)butto {
    [self pushTestModule:@"come.zkty.module.camera"];
}


- (void)module_device:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.device"];
}


-(void)module_bluetooth:(UIButton *)button{
    [self pushTestModule:@"com.zkty.module.bluetooth"];
}

- (void)module_dcloud:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.dcloud"];
}

- (void)module_lope:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.lope"];
}

- (void)module_network:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.network"];
}

- (void)module_offline:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.offline"];
}

- (void)module_router:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.router"];
}

- (void)module_scan:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.scan"];
}

- (void)module_UI:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.UI"];
}

- (void)module_tzcash:(UIButton * _Nullable)button {
    [self pushTestModule:@"com.zkty.module.tzcash"];
}
- (void)pushTestModule:(NSString*) appid {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:appid ];
    [self pushViewController:webLaderVC];
}


@end
