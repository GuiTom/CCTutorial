//
//  BlockViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "BlockTransmitViewController.h"
#import "BlockTransmit.h"

@interface BlockTransmitViewController ()
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSArray *dataSource;
@end
@implementation BlockTransmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark UITableDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [[BlockTransmit new] test1];
    }else if(indexPath.row==1){
        [[BlockTransmit new] test2];
    }else if(indexPath.row==2){
        [[BlockTransmit new] test3];
    }else if(indexPath.row==3){
        [[BlockTransmit new] test4];
    }else if(indexPath.row==4){
        [[BlockTransmit new] test5];
    }
}
-(NSArray*)dataSource{
    if(!_dataSource){
        _dataSource = @[
            @"局部变量,截获值",
            @"局部静态变量，截获指针",
            @"全局静态变量，不截获",
            @"全局变量，不截获",
            @"对象类型,连同所有权修饰符一期截获"
        ];
    }
    return _dataSource;
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
