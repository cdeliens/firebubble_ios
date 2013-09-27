//
//  FBTappableView.h
//  FireBubble
//
//  Created by Jose Medrano on 9/24/13.
//  Copyright (c) 2013 Jose Medrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@protocol FPTappableViewDelegate <NSObject>
-(void)bubbleBurstedInLocation:(NSDictionary *)location;
@end

@interface FBTappableView : UIView {
    SystemSoundID _pewPewSound;
}

@property (nonatomic, weak) id <FPTappableViewDelegate> delegate; 

@property (nonatomic) BOOL touched;
@property (nonatomic) CGPoint locationOfTouch;

@end
