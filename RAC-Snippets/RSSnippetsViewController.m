//
//  RSSnippetsViewController.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSSnippetsViewController.h"
#import "RSSnippetsDataSource.h"

@interface RSSnippetsViewController ()
@property (nonatomic) UITableView *tableView;
@end

@implementation RSSnippetsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        self.tableView.dataSource = [RSSnippetsDataSource sharedInstance];
        self.tableView.delegate = self;
        self.tableView.separatorInset = UIEdgeInsetsZero;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tableView];
        self.title = @"RAC Snippets";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marke - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *snippet = [RSSnippetsDataSource sharedInstance].snippets[indexPath.row];
    UIViewController *viewController = [[snippet[@"demoClass"] alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
