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
{
    UIDatePicker *timer;
    UIView *player1HPbar;
    UIView *player2HPbar;
}

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
        
        UIButton *buttonA = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-140)/2, SCREEN_HEIGHT-80, 40,40)];
        [buttonA addTarget:skScene action:@selector(buttonAClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonA setTitle:@"A" forState:UIControlStateNormal];
        buttonA.layer.cornerRadius = 20;
        buttonA.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonA];
        
        UIButton *buttonB = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, SCREEN_HEIGHT-80, 40,40)];
        [buttonB addTarget:skScene action:@selector(buttonBClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonB setTitle:@"B" forState:UIControlStateNormal];
        buttonB.layer.cornerRadius = 20;
        buttonB.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonB];
        
        UIButton *buttonUp = [[UIButton alloc] initWithFrame:CGRectMake(50, 170, 40,40)];
        [buttonUp addTarget:skScene action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside];
        [buttonUp setTitle:@"^" forState:UIControlStateNormal];
        buttonUp.layer.cornerRadius = 20;
        buttonUp.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonUp];
        
        UIButton *buttonDown = [[UIButton alloc] initWithFrame:CGRectMake(50, 240, 40,40)];
        [buttonDown addTarget:skScene action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        [buttonDown setTitle:@"v" forState:UIControlStateNormal];
        buttonDown.layer.cornerRadius = 20;
        buttonDown.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonDown];
        
        UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 40,40)];
        [buttonLeft addTarget:skScene action:@selector(buttonLeft:) forControlEvents:UIControlEventTouchUpInside];
        [buttonLeft setTitle:@"<" forState:UIControlStateNormal];
        buttonLeft.layer.cornerRadius = 20;
        buttonLeft.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonLeft];
        
        UIButton *buttonRight = [[UIButton alloc] initWithFrame:CGRectMake(90, 200, 40,40)];
        [buttonRight addTarget:skScene action:@selector(buttonRight:) forControlEvents:UIControlEventTouchUpInside];
        [buttonRight setTitle:@">" forState:UIControlStateNormal];
        buttonRight.layer.cornerRadius = 20;
        buttonRight.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:buttonRight];
        
//        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"mm:ss"];
//        NSLog(@"%@",[dateformatter stringFromDate:[datePicker date]]);
//        timer = [[UIDatePicker alloc] initWithFrame:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-30)];
//        
//        timerLabel.position =
//        timerLabel.text = @"00:00";
//        timerLabel.fontColor = [SKColor greenColor];
//        timerLabel.fontSize = 16.0;
//        [self addChild:timerLabel];
//
//      barArea = ((SCREEN_WIDTH -60) /2.0 )-20;
//
//        
//        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
//        player1HPBar.position = CGPointMake((barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
//        [self addChild:player1HPBar];
//        
//        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
//        player2HPBar.position = CGPointMake(SCREEN_WIDTH-(barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
//        [self addChild:player2HPBar];

        
        
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
