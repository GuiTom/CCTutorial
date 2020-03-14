//
//  Block__blockViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Block__blockViewController.h"
#import "Block__block.m"
@interface Block__blockViewController ()
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSArray *dataSource;
@end

@implementation Block__blockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark UITableDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [[Block__block new] test1];
    }else if(indexPath.row==1){
        [[Block__block new] test2];
    }
}
-(NSArray*)dataSource{
    if(!_dataSource){
        _dataSource = @[
            @"__block修饰的基本类型变量",
            @"__block修饰的对象变量",
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
