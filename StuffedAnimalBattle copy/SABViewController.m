//
//  SABViewController.m
//  StuffedAnimalBattle
//
//  Created by Savitha Reddy on 5/15/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "SABViewController.h"
#import <SpriteKit/SpriteKit.h> //needs a spritekit View
#import "SABGameScene.h"

/// create a singleton for player health
// -track wins per player
//move buttons and bars outside of scene
//when a player is hit update singleton and also update health bar
//  notification or singleton delegate

@interface SABViewController ()

@end

@implementation SABViewController

-(id)init
{
    self=[super init];
    if(self)
    {
        SKView *skView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:skView];
        SABGameScene *skScene = [[SABGameScene alloc] initWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)]; //since CGREctMake is used use CGSizeMake
        skView.showsFPS = YES;
        skView.showsNodeCount =YES;
        [skView presentScene:skScene]; //create a subclass of SkScene //
        
        UIButton *buttonA = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, SCREEN_HEIGHT-120, 40,40)];
        [buttonA addTarget:skScene action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonA setTitle:@"A" forState:UIControlStateNormal];
        buttonA.layer.cornerRadius = 20;
        buttonA.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonA];
        
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
