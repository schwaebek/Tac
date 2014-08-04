//
//  TTTTouchSpot.m
//  Tac
//
//  Created by Katlyn Schwaebe on 7/29/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import "TTTTouchSpot.h"

@implementation TTTTouchSpot
{
    UIImageView * imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // add a UIImageView alloc int
        
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview: imageView];
        
        
    }
    return self;
}

// player setter method will change image
-(void) setPlayer: (int)player
{
    _player = player;
    
    switch (player) {
        case 0:
            imageView.image = [UIImage imageNamed: @"spot"];
            break;
        case 1:
            imageView.image = [UIImage imageNamed: @"x"];
            break;
        case 2:
            imageView.image = [UIImage imageNamed: @"circle"];
            break;
         
    }

    
}
    
    //    if player == 0 then imageView.image = spot
    //    if player == 1 then imageView.image = x
    //    if player == 2 then imageView.image = circle
    
    
    
//UIImage * xImage = [UIImage imageNamed:@"x"];


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
