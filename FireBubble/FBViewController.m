//
//  FBViewController.m
//  FireBubble
//
//  Created by Jose Medrano on 9/24/13.
//  Copyright (c) 2013 Jose Medrano. All rights reserved.
//

#import "FBViewController.h"
#import <Firebase/Firebase.h>
#import <QuartzCore/QuartzCore.h>


@interface FBViewController ()
@property (nonatomic) Firebase *firebaseBubble;
@property (nonatomic) FBTappableView *tappableView;
@end

static NSString *const FireBaseURL = @"YOUR_FIREBASE_URL";


@implementation FBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tappableView = (FBTappableView *)self.view;
    _tappableView.delegate = self;
    _firebaseBubble = [[Firebase alloc] initWithUrl:FireBaseURL];
    [self addFirebaseBubbleObserver];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bubbleBurstedInLocation:(NSDictionary *)location
{
    NSString *x = [NSString stringWithFormat:@"%@", [location objectForKey:@"x"]];
    NSString *y = [NSString stringWithFormat:@"%@", [location objectForKey:@"y"]];
    
    
    [[_firebaseBubble childByAppendingPath:@"x"] setValue:x];
    [[_firebaseBubble childByAppendingPath:@"y"] setValue:y];
}

-(void)addFirebaseBubbleObserver
{
    [_firebaseBubble observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *bubble = snapshot.value;
        NSString *x = [NSString stringWithFormat:@"%@", [bubble objectForKey:@"x"]];
        NSString *y = [NSString stringWithFormat:@"%@", [bubble objectForKey:@"y"]];
        
        CGPoint touchLocation = CGPointMake([x floatValue], [y floatValue]);
        
        if (!CGPointEqualToPoint(_tappableView.locationOfTouch,touchLocation))
        {
            _tappableView.locationOfTouch = touchLocation;
            _tappableView.touched = YES;
            
            [_tappableView setNeedsDisplay];
        }

    }];
}

@end
