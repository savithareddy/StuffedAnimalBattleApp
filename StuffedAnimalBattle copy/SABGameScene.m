//
//  SABGameScene.m
//  StuffedAnimalBattle
//
//  Created by Savitha Reddy on 5/15/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "SABGameScene.h"
@interface SABGameScene () <SKPhysicsContactDelegate> // added this interface class and delegate and self delgate and contact method

@end

@implementation SABGameScene
{
    SKLabelNode *timerLabel;
    
    SKSpriteNode *player1;
    SKSpriteNode *player2;
    
    SKTextureAtlas *charAtlas;
    SKTextureAtlas *danceAtlas;
    
    float barArea;
    float currentBarArea;
    
    SKSpriteNode *player1HPbar;
    SKSpriteNode *player2HPbar;
    
}

-(instancetype)initWithSize:(CGSize)size //SDM
{
    self=[super initWithSize:size];
    if (self) {
        
        self.backgroundColor  =[UIColor whiteColor];
        
        SKPhysicsBody *scenePhysics = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.physicsBody = scenePhysics;
        self.physicsWorld.contactDelegate = self;
        
        SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(SCREEN_WIDTH, 30)];
        floor.position = CGPointMake(SCREEN_WIDTH/2.0, 15);
        [self addChild:floor];
        SKPhysicsBody *floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        floor.physicsBody = floorPhysics;
 barArea = ((SCREEN_WIDTH -60) /2.0 )-20;
        currentBarArea = barArea;
        
               
//        player1= [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(40, 100)];
        player1 = [SKSpriteNode spriteNodeWithImageNamed:@"charFrame1"];
        player1.size = CGSizeMake(80, 100);
        player1.position = CGPointMake((SCREEN_WIDTH-350)/2.0 , 80);
        [self addChild:player1];
        SKPhysicsBody *player1Physics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size ]; //center:floor.position actual is player1.position
        player1.physicsBody = player1Physics;
        
//        player2= [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(40, 100)];
        player2 = [SKSpriteNode spriteNodeWithImageNamed:@"charFrame1"];
        player2.size =CGSizeMake(80, 100);
        player2.position = CGPointMake(SCREEN_WIDTH/2 * 1.5 , 80);
        [self addChild:player2];
        SKPhysicsBody *player2Physics = [SKPhysicsBody bodyWithRectangleOfSize:player2.size ]; //center:floor.position actual is player1.position
        player2.physicsBody = player2Physics;
        player2.userData = [@{@"type":@"player2"}mutableCopy];
//        player2.physicsBody.contactTestBitMask= 2; // for collision this is most imp
        
        danceAtlas = [SKTextureAtlas atlasNamed:@"dance"];
        NSMutableArray *textures = [@[] mutableCopy];
        for (int i=1; i<danceAtlas.textureNames.count+1; i++) {
//            NSLog(@"charFrame%d",i); //image name have 1234 and not 0123 so i start with 1 and not 0
            [textures addObject :[danceAtlas textureNamed:[NSString stringWithFormat:@"dance%d",i]]];
        }
        SKAction *dance = [SKAction animateWithTextures:textures timePerFrame:0.2];
        SKAction *danceAllNight = [SKAction repeatActionForever:dance];
        [player1 runAction:danceAllNight];
    
              barArea = ((SCREEN_WIDTH -60) /2.0 )-20;
        
        
                player1HPbar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
            player1HPbar.position = CGPointMake((barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
               [self addChild:player1HPbar];
    
               player2HPbar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
                player2HPbar.position = CGPointMake(SCREEN_WIDTH-(barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
                [self addChild:player2HPbar];

    }
    return self;
}

-(void) buttonAClick:(UIButton *)sender
{
    NSLog(@" Button A Clicked");
    NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Fireball" ofType:@"sks"];
    SKEmitterNode *fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    
    fireball.position = CGPointMake(player1.position.x+58.0, player1.position.y);
    SKPhysicsBody *fireBallPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10,10)];
    
    fireball.physicsBody = fireBallPhysics;
    fireBallPhysics.affectedByGravity = NO;
    fireball.physicsBody.contactTestBitMask = 1;
    fireball.userData = [@{@"type":@"fireball"} mutableCopy];
    [self addChild:fireball];
    [fireball.physicsBody applyImpulse:CGVectorMake(10.0, 1.0)];
    [self runAction:[SKAction playSoundFileNamed:@"Lift Off FX 001.wav" waitForCompletion:YES]];

}

-(void)buttonBClick:(UIButton *)sender
{
    NSLog(@" Button B Clicked");
}
-(void)buttonDown:(UIButton *)sender
{
    NSLog(@" Down Arrow Clicked");
}
-(void)buttonUp:(UIButton *)sender
{
    NSLog(@" Up Arrow  Clicked");
    charAtlas =[SKTextureAtlas atlasNamed:@"char"];
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i=1; i<charAtlas.textureNames.count+1; i++)
    {
        NSLog(@"charFrame%d",i); //image name have 1234 and not 0123 so i start with 1 and not 0
        [textures addObject :[charAtlas textureNamed:[NSString stringWithFormat:@"charFrame%d",i]]];
    }
    SKAction *setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.2];
    [player1 runAction:setFrame2];
    
    for (SKTexture *texture in textures)
    {
        NSLog(@"%@",texture);
    }
    
    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 200.0)];// jumps and back to position
    
//    static const CGFloat thrust = 0.12;
//    [player1.physicsBody applyTorque:thrust]; // rolls

}
-(void)buttonLeft:(UIButton *)sender
{
    NSLog(@" Left Arrow Clicked");
    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];
}
-(void)buttonRight:(UIButton *)sender
{
    NSLog(@" Right Arrow Clicked");
     [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
}

-(void)update:(NSTimeInterval)currentTime //SDM
{
// add currenttime
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
//    NSLog(@" %@", contact.bodyA.node.userData[@"type"]);
//     NSLog(@" %@", contact.bodyB.node.userData[@"type"]);
//    [contact.bodyA.node, contact.bodyB.node]
    NSMutableArray *nodes = [@[]mutableCopy];
    
    if(contact.bodyA.node != nil) [nodes addObject:contact.bodyA.node];
    if(contact.bodyB.node != nil) [nodes addObject:contact.bodyB.node];
    for (SKNode *node in nodes)
    {
        if ([node.userData[@"type"] isEqualToString:@"fireball"]) //case sensitive string
        {
            [node removeFromParent];
            NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
            SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
            explosion.position = contact.contactPoint;
            explosion.numParticlesToEmit = 200;
            [self addChild:explosion];
            
            currentBarArea -= 20;
            [player2HPbar removeFromParent];
            player2HPbar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake((currentBarArea), 30)];
            player2HPbar.position = CGPointMake(SCREEN_WIDTH-(barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
            [self addChild:player2HPbar];

            
        }
    
    }
}





@end
