//
//  ViewController.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/20.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "ViewController.h"
#import "BFAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self removeObserver:self forKeyPath:@"frame"];
//    [self removeObserver:self forKeyPath:@"frame"];
    BFAlertViewController *VC = [BFAlertViewController new];
    [self presentViewController:VC animated:YES completion:nil];
//    NSString *str = nil;
//    NSDictionary *dict = @{@"name": str};
//    NSLog(@"%@", dict);
//
//    ViewController *vc = nil;
//    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
//    mdict[@"name"] = str;
//    [mdict setValue:vc forKey:@"age"];
//    NSLog(@"%@", mdict);
    
    
}


@end
