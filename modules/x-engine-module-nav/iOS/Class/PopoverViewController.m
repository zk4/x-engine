//
//  PopoverViewController.m
//  AFNetworking
//
//  Created by edz on 2020/8/4.
//

#import "PopoverViewController.h"
//#import <x-engine-module-engine/MicroAppLoader.h>
#import "xengine__module_nav.h"
@interface PopoverViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView; /** tableView */
@end

@implementation PopoverViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.allowsSelection
        
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
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    NSDictionary *item = self.itemList[indexPath.item];
//    NavPopModelDTO *item = self.itemList[indexPath.item];
    NSString * contexText = [NSString stringWithFormat:@"%@",item[@"title"]];
//    NSString * contexText = item.title;
    cell.textLabel.text = contexText;

    NSString * path = [NSString stringWithFormat:@"%@",item[@"icon"]];
//    NSString * path = item.icon;
    if ([self getNoEmptyString:path]) {
        NSString * pathName = [self localFile:path];
        UIImage *iconImage = [UIImage imageWithContentsOfFile:pathName];
        cell.imageView.image =  [self setImageSize:[self getImageSize:item[@"iconSize"]] image:iconImage];
//        cell.imageView.image =  [self setImageSize:[self getImageSize:item.iconSize] image:iconImage];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectCellBlock){
        self.selectCellBlock(tableView, indexPath);
    }
}

- (UIImage *)setImageSize:(CGSize)size image:(UIImage *)image{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaledImage;
}

- (CGSize)getImageSize:(NSArray *)iconSizeArray
{
    CGSize iconSize = CGSizeMake(20,20);
    
    if (iconSizeArray && iconSizeArray.count > 1){
        NSString *width = iconSizeArray[0];
        NSString *height = iconSizeArray[1];
        iconSize.width = width.floatValue;
        iconSize.height = height.floatValue;
    }
    return iconSize;
    
}

//获取文件名
-(NSString *)localFile:(NSString *)pathName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    NSString *fileName;
    NSString *R ;
    while (fileName = [dirEnum nextObject]) {
        if ([fileName hasSuffix:pathName]) {
            R = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
        }
    }
    return R;
}

//判断字符串
-(BOOL)getNoEmptyString:(NSString *)sting{
    if (sting != nil & sting != NULL & ![sting isEqualToString:@"(null)"] & ![sting isEqualToString:@"null"] &![sting isEqualToString:@""] & ![sting isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}
@end
