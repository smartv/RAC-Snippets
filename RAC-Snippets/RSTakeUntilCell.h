//
//  RSTakeUntilCell.h
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTakeUntilCell : UITableViewCell
@property (nonatomic,readonly) UIButton *button;

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath;
@end
