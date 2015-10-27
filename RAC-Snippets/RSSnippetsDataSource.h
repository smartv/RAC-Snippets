//
//  RSSnippetsDataSource.h
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSBaseDemoViewController;

@interface RSSnippetsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic,readonly) NSArray *snippets;

+ (instancetype)sharedInstance;

-(void)addWithDescription:(NSString *)description demoClass:(Class)demoClass;

@end
