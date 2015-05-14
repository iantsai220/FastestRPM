//
//  ViewController.m
//  FastestRPM
//
//  Created by Ian Tsai on 2015-05-14.
//  Copyright (c) 2015 Ian Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) CGPoint startLocation;

@property (nonatomic) CFAbsoluteTime lastChange;

@property (nonatomic) double timeElapsed;

@property (nonatomic) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIImage *speedometer = [UIImage imageNamed:@"speedometer.png"];
    UIImage *needle = [UIImage imageNamed:@"needle.png"];
    UIImage *flippedNeedleImage = [UIImage imageWithCGImage:needle.CGImage scale:needle.scale orientation:UIImageOrientationUpMirrored];
    
    _speedOmeter.image = speedometer;
    
    _needle.image = flippedNeedleImage;
    
    _needle.transform = CGAffineTransformMakeRotation(-0.7853981634);

    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    
    
    [self.view addGestureRecognizer:panGesture];
   
    
}

-(void)reset {
    _needle.transform = CGAffineTransformMakeRotation(-0.7853981634);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)panGesture: (UIPanGestureRecognizer *) sender {
    
//    CGFloat distance = 0.0;
//    
//    if (_startLocation.x != 0.0) {
//        CGPoint currentLocation =[sender locationInView: self.view];
//        CGFloat distanceX = currentLocation.x - self.startLocation.x;
//        CGFloat distanceY = currentLocation.y - self.startLocation.y;
//        distance = sqrt(distanceX * distanceX + distanceY * distanceY);
//    
//       
//    }
//    
//    if (sender.state == UIGestureRecognizerStateChanged ) {
//        self.lastChange = CFAbsoluteTimeGetCurrent();
//    }
//    else if (sender.state == UIGestureRecognizerStateEnded ) {
//        double curTime = CFAbsoluteTimeGetCurrent();
//        self.timeElapsed = curTime - self.lastChange;
//        
//    }
    
    
//    CGFloat velocity = distance / self.timeElapsed;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(reset) userInfo:nil repeats:NO];
    
    
    CGPoint gestureVelocity = [sender velocityInView:self.view];
    
    //set max
    CGFloat constant = 3.9095 / 100;
    
    CGFloat velocity = sqrt(gestureVelocity.x * gestureVelocity.x + gestureVelocity.y * gestureVelocity.y);
    
    CGFloat radian = (velocity * (M_PI/180)) * constant;

    NSLog(@"%f", radian);
    
    _needle.transform = CGAffineTransformMakeRotation(radian);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        _needle.transform = CGAffineTransformMakeRotation(-0.7853981634);
    }

}













@end
