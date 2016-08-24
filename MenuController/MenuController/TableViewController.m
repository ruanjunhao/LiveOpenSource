//
//  TableViewController.m
//  MenuController
//
//  Created by LeeWong on 16/7/22.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "TableViewController.h"
#import "MenuCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[MenuCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:longPressGesture];
    return cell;
}


- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        NSLog(@"%tu",indexPath.row);
        UITableViewCell *cell = (UITableViewCell *)recognizer.view;
//        这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        menu.arrowDirection = UIMenuControllerArrowLeft;
        
        //
        CGRect rect = CGRectMake(100, 5, 100, 30);
        
        
        [menu setMenuItems:[NSArray arrayWithObjects:itDelete,  nil]];
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

- (void)handleDeleteCell
{
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
}


- (void)handleDeleteCell:(UITableViewCell *)cell
{
    [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:cell.tag inSection:0]];
}


@end
