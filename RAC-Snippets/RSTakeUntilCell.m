//
//  RSTakeUntilCell.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSTakeUntilCell.h"

@interface RSTakeUntilCell ()
@property (nonatomic, readwrite) UIButton *button;

@end

@implementation RSTakeUntilCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath
{
    [self.button setTitle:[NSString stringWithFormat:@"Cell %d",indexPath.row] forState:UIControlStateNormal];
    [[[self.button
     rac_signalForControlEvents:UIControlEventTouchUpInside]
    takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(id x) {
        NSString *message = [NSString stringWithFormat:@"Cell %d Tapped",indexPath.row];
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerView show];
    }];
    
}

#pragma mark - Accessors

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(0, 0, 300, 44);
        [_button setTitle:@"Cell" forState:UIControlStateNormal];
    }
    return _button;
}

@end
