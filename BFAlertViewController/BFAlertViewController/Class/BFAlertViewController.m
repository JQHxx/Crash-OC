//
//  BFAlertViewController.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/20.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "BFAlertViewController.h"

typedef void(^FinishBlock)(void);

@interface BFAlertViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIView *vLineView;

@property (nonatomic, copy) FinishBlock block;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BFAlertViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self setupUI];
    
//    _block = ^{
//        NSLog(@"%@", self);
//    };
//
//    _block();
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(count) userInfo:nil repeats:YES];
}

- (void)dealloc
{
    
}

#pragma mark - Private methods
- (void) setupUI {
    
}

- (void)count {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
