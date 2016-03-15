//
//  ViewController.m
//  learningUIBezierPath
//
//  Created by pbo on 2/29/16.
//  Copyright © 2016 Practice Builders. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIView *aview;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    float s1 = pow(self.aview.frame.size.height, 2); // 4225
    float s2 = pow(self.view.frame.size.width, 2); // 102400
    float sq = sqrt(s1 + s2); // 106625

    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(0, 0)];
    [trianglePath addLineToPoint:CGPointMake(sq, self.aview.frame.size.height)];
    [trianglePath addLineToPoint:CGPointMake(0, self.aview.frame.size.height)];
    [trianglePath closePath];

    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    [triangleMaskLayer setPath:trianglePath.CGPath];
    self.aview.layer.mask = triangleMaskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
