//
//  RSCommandViewController.m
//  RAC-Snippets
//
//  Created by luguobin on 15/10/27.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "RSCommandViewController.h"
#import "RSSnippetsDataSource.h"
#import <AFNetworking.h>

@interface RSCommandViewController ()
@property (nonatomic) UIButton *button;
@property (nonatomic) UILabel *resultLabel;
@end

@implementation RSCommandViewController

+ (void)load
{
    return [[RSSnippetsDataSource sharedInstance] addWithDescription:@"RACCommand Demo" demoClass:[self class]];
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
    [self.view addSubview:self.resultLabel];
    
    
    RACSignal *flagSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@YES];
        
        double  delayInSenconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSenconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:flagSignal signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[AFHTTPRequestOperationManager manager] GET:@"https://httpbin.org/ip" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [subscriber sendNext:responseObject[@"origin"]];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
    
    RACSignal *startSignal = [self.button.rac_command.executionSignals map:^id(id value) {
        return @"Sending Request....";
    }];
    
    RACSignal *successSignal = [self.button.rac_command.executionSignals switchToLatest];
    
    RACSignal *failSignal = [self.button.rac_command.errors map:^id(id value) {
        return @"Request Error";
    }];
    
    RAC(self, resultLabel.text) = [RACSignal merge:@[startSignal,successSignal,failSignal]];
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
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button setTitle:@"Get My IP" forState:UIControlStateNormal];
        _button.frame = CGRectMake(100, 100, 100, 30);
        
    }
    return _button;
}

- (UILabel *)resultLabel
{
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 30)];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.textColor = [UIColor blueColor];
        _resultLabel.text = @"---";
    }
    return _resultLabel;
}


@end
