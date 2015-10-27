//
//  RSUseThenAndTakeViewController.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSUseThenAndTakeViewController.h"
#import "RSSnippetsDataSource.h"

@interface RSUseThenAndTakeViewController ()
@property (nonatomic) UIButton *button;
@property (nonatomic) UIViewController *presentVC;
@end

@implementation RSUseThenAndTakeViewController

+ (void)load
{
    return [[RSSnippetsDataSource sharedInstance] addWithDescription:@"Use `then` and `take`" demoClass:[self class]];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self.navigationController presentViewController:self.presentVC animated:YES completion:^{
                [subscriber sendCompleted];
            }];
            
            return nil;
        }] then:^RACSignal *{
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
        return signal;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, 100, 200, 30);
        [_button setTitle:@"Present a ViewController" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    }
    return _button;
}

- (UIViewController *)presentVC
{
    if (!_presentVC) {
        _presentVC = [[UIViewController alloc] init];
        _presentVC.view.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Back" forState:UIControlStateNormal];

        button.frame = CGRectMake(100, 100, 100, 30);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }];
        [_presentVC.view addSubview:button];
        
    }
    return _presentVC;
}

@end
