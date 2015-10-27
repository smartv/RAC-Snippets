//
//  RSSnippetsDataSource.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSSnippetsDataSource.h"

@interface RSSnippetsDataSource()
@property (nonatomic) NSMutableArray *mutableSnippets;
@end


@implementation RSSnippetsDataSource

+ (instancetype)sharedInstance
{
    static RSSnippetsDataSource *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addWithDescription:(NSString *)description demoClass:(Class)demoClass
{
    NSDictionary *snippet = NSDictionaryOfVariableBindings(description,demoClass);
    [self.mutableSnippets addObject:snippet];
}

- (NSArray *)snippets
{
    return [self.mutableSnippets copy];
}

#pragma mark - Accessors 
- (NSMutableArray *)mutableSnippets
{
    if (!_mutableSnippets) {
        _mutableSnippets = [[NSMutableArray alloc] init];
    }
    return _mutableSnippets;
}

#pragma mark - UITableViewDataSouce 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.snippets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.snippets[indexPath.row][@"description"];
    return cell;
}
@end
