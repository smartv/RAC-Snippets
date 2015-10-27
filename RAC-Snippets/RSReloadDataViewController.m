//
//  RSReloadDataViewController.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSReloadDataViewController.h"

@interface RSReloadDataViewController ()
@property (nonatomic,copy) NSArray *data;
@end

@implementation RSReloadDataViewController

+ (void)load
{
    [[RSSnippetsDataSource sharedInstance] addWithDescription:@"UITableView reloadData" demoClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = @[@"pull down to refresh"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [[refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        
        NSInteger CellCount = arc4random() % 30;
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:CellCount];
        for (int i = 0 ; i < CellCount;  i++) {
            NSInteger random = arc4random() * 1000;
            [data addObject:[NSString stringWithFormat:@"Random Number: %d",random]];
            
        }
        self.data = data;
        [self.refreshControl endRefreshing];
    }];
    
    self.refreshControl = refreshControl;
    
    @weakify(self);
    [RACObserve(self, data) subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
@end
