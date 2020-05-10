//
//  TableViewAutoSizeController.m
//  CCTutorial
//
//  Created by 陈超 on 2020/5/10.
//  Copyright © 2020年 kayak. All rights reserved.
//

#import "TableViewAutoSizeController.h"

@interface TableViewAutoSizeController ()

@end

@implementation TableViewAutoSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.detailTextLabel.text = @"经过艰苦卓绝的努力，武汉保卫战、湖北保卫战取得决定性成果，疫情防控阻击战取得重大战略成果，统筹推进疫情防控和经济社会发展工作取得积极成效。我们要继续抓紧做好各项工作，时刻绷紧疫情防控这根弦，扎实推进复工复产复学，确保完成决战决胜脱贫攻坚目标任务，全面建成小康社会";
    }else {
            cell.detailTextLabel.text = @"经过艰苦卓绝的努力，武汉保卫战、湖北保卫战取得决定性成果，疫情防控阻击战取得重大战略成果，统筹推进疫情防控和经济社会发展工作取得积极成效。我们要继续抓紧做好各项工作，时刻绷紧疫情防控这根弦，扎实推进复工复产复学，确保完成决战决胜脱贫攻坚目标任务，全面建成小康社会";
    }
    return cell;
 
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
