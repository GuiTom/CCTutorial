//
//  Block_TypeViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/14.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Block_TypeViewController.h"
#import "BlockType.h"
@interface Block_TypeViewController ()

@end

@implementation Block_TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark UITableDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [[BlockType new] test1];
    }else if(indexPath.row==1){
        [[BlockType new] test2];
    }else if(indexPath.row==2){
        [[BlockType new] test3];
    }else if(indexPath.row==3){
        [[BlockType new] test4];
    }
}
-(NSArray*)dataSource{
    return @[
            @"全局block",
            @"栈block",
            @"堆block",
            @"练习题"
        ];
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
