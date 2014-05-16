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
    SKSpriteNode *player1HPBar; //HP = hit points
    SKSpriteNode *player2HPBar;
    
    SKSpriteNode *buttonA;
    SKSpriteNode *buttonB;
    
    SKSpriteNode *dpadUp;
    SKSpriteNode *dpadDown;
    SKSpriteNode *dpadLeft;
    SKSpriteNode *dpadRight;
    
    SKSpriteNode *player1;
    SKSpriteNode *player2;
    
    int maxHP;
    int playerHP;
    float barArea;
    
    SKTextureAtlas *charAtlas;
    SKTextureAtlas *danceAtlas;
    
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

        timerLabel = [SKLabelNode node];
        timerLabel.position = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-30);
        timerLabel.text = @"00:00";
        timerLabel.fontColor = [SKColor greenColor];
        timerLabel.fontSize = 16.0;
        [self addChild:timerLabel];
        
        barArea = ((SCREEN_WIDTH -60) /2.0 )-20;
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player1HPBar.position = CGPointMake((barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
        [self addChild:player1HPBar];
        
        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player2HPBar.position = CGPointMake(SCREEN_WIDTH-(barArea + 20)/2.0, SCREEN_HEIGHT-20.0);
        [self addChild:player2HPBar];
        
        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonA.position = CGPointMake(SCREEN_WIDTH-40, 80);
        [self addChild:buttonA];
        
        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonB.position = CGPointMake(SCREEN_WIDTH-80, 40);
        [self addChild:buttonB];
        
        dpadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadDown.position = CGPointMake(80 , 40);
        [self addChild:dpadDown];
        
        dpadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadUp.position = CGPointMake(80 , 120);
        [self addChild:dpadUp];
        
        dpadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadLeft.position = CGPointMake(40 , 80);
        [self addChild:dpadLeft];
        
        dpadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadRight.position = CGPointMake(120 , 80);
        [self addChild:dpadRight];
        
//        player1= [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(40, 100)];
        
         charAtlas =[SKTextureAtlas atlasNamed:@"char"];
        danceAtlas = [SKTextureAtlas atlasNamed:@"dance"];
//        for (NSString *textureName in charAtlas.textureNames) {
//            NSLog(@"%@",textureName); // to check the array objects position 1234 or 1324 ettc.. because of atlas and underscore in the fileName
//        }
//        for (int i=1; i<charAtlas.textureNames.count+1; i++) {
//            NSLog(@"charFrame%d",i); //image name have 1234 and not 0123 so i start with 1 and not 0
//        }
        
        player1 = [SKSpriteNode spriteNodeWithImageNamed:@"charFrame1"];
        player1.size = CGSizeMake(80, 100);
        
        player1.position = CGPointMake((SCREEN_WIDTH-450)/2.0 , 80);
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
        
        NSMutableArray *textures = [@[] mutableCopy];
        for (int i=1; i<danceAtlas.textureNames.count+1; i++) {
//            NSLog(@"charFrame%d",i); //image name have 1234 and not 0123 so i start with 1 and not 0
            [textures addObject :[danceAtlas textureNamed:[NSString stringWithFormat:@"dance%d",i]]];
        }
        SKAction *dance = [SKAction animateWithTextures:textures timePerFrame:0.2];
        SKAction *danceAllNight = [SKAction repeatActionForever:dance];
        [player1 runAction:danceAllNight];
        

        
        
       
        
//        SKNode *box = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
//        [self addChild:box]; // self because weare in th scene itself and it had to add to scene itself
//        box.position = CGPointMake(50, 50);
    
        maxHP = 100;
        playerHP = maxHP;
    }
    return self;
}

-(void) buttonClick:(UIButton *)sender
{
//   NSLog
}
-(void) drawHealthBar:(SKNode *)node withName:(NSString *)name andHealthPoints:(int)hp
{
    [node removeAllChildren];
    
    float widthOfHealth = (barArea - 2.0f)*hp/maxHP;
    
    UIColor *clearColor = [UIColor clearColor];
    UIColor *fillColor = [UIColor colorWithRed:113.0f/255.0f green:202.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
    UIColor *borderColor = [UIColor colorWithRed:35.0f/255.0f green:28.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    
    //create the outline for the health bar
    CGSize outlineRectSize = CGSizeMake(barArea-1.0f, 20-1.0);
    UIGraphicsBeginImageContextWithOptions(outlineRectSize, NO, 0.0);
    CGContextRef healthBarContext = UIGraphicsGetCurrentContext();
    
    //Drawing the outline for the health bar
    CGRect spriteOutlineRect = CGRectMake(0.0, 0.0, barArea-1.0f, 20-1.0f);
    CGContextSetStrokeColorWithColor(healthBarContext, borderColor.CGColor);
    CGContextSetLineWidth(healthBarContext, 1.0);
    CGContextAddRect(healthBarContext, spriteOutlineRect);
    CGContextStrokePath(healthBarContext);
    
    //Fill the health bar with a filled rectangle
    CGRect spriteFillRect = CGRectMake(0.5, 0.5, outlineRectSize.width-1.0, outlineRectSize.height-1.0);
    spriteFillRect.size.width = widthOfHealth;
    CGContextSetFillColorWithColor(healthBarContext, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(healthBarContext, clearColor.CGColor);
    CGContextSetLineWidth(healthBarContext, 1.0);
    CGContextFillRect(healthBarContext, spriteFillRect);
    
    //Generate a sprite image of the two pieces for display
    UIImage *spriteImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef spriteCGImageRef = [spriteImage CGImage];
    SKTexture *spriteTexture = [SKTexture textureWithCGImage:spriteCGImageRef];
    spriteTexture.filteringMode = SKTextureFilteringLinear; //This is the default anyway
    SKSpriteNode *frameSprite = [SKSpriteNode spriteNodeWithTexture:spriteTexture size:outlineRectSize];
    frameSprite.position = CGPointZero;
    frameSprite.name = name;
    frameSprite.anchorPoint = CGPointMake(0.0, 0.5);
    
    [node addChild:frameSprite];
}

-(void)update:(NSTimeInterval)currentTime //SDM
{
    [self drawHealthBar:player1HPBar withName:@"playerHealth" andHealthPoints:playerHP];
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
        }
    
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event //SDM
{
//    UITouch *touch =[touches anyObject];
    CGPoint location = [[[touches allObjects] firstObject] locationInNode:self];
//    CGPoint location = [[touch locationInNode:button]];
    
//    NSLog(@"%f %f",location.x, location.y);
//    NSLog(@"%u", [buttonA containsPoint:location]); //%u is BOOl yes/No so gives 0 or 1//says whether the button is clicked or not
     [self testButtonsWithLocation:location];
}

-(void) testButtonsWithLocation :(CGPoint) location //UDM
{
    NSArray *buttons = @[buttonA,buttonB,dpadUp,dpadDown,dpadLeft,dpadRight];
    for (SKNode *button in buttons)
    {
        if ([button containsPoint:location])
        {
//            NSLog(@"button %d",[buttons indexOfObject:button]);
            switch ([buttons indexOfObject:button]) { // index of object refers to the array decalred above
                case 0: //buttonA
                {
//                    NSLog(@"Punch");
                    
//                    SKSpriteNode *fireball = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(10, 10)];
                    
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
                    break;
                case 1: //buttonB
//                    NSLog(@"Kick");
                    break;
                case 2: //up
                {
//                    NSLog(@"Jump");
//                    for (NSString *textureName in charAtlas.textureNames) {
//                        NSLog(@"%@",textureName); // to check the array objects position 1234 or 1324 ettc.. because of atlas and underscore in the fileName
//                    }
                    NSMutableArray *textures = [@[] mutableCopy];
                    for (int i=1; i<charAtlas.textureNames.count+1; i++) {
                        NSLog(@"charFrame%d",i); //image name have 1234 and not 0123 so i start with 1 and not 0
                        [textures addObject :[charAtlas textureNamed:[NSString stringWithFormat:@"charFrame%d",i]]];
                    }
                         SKAction *setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.2];
                         [player1 runAction:setFrame2];
                    
                    for (SKTexture *texture in textures) {
                        NSLog(@"%@",texture);
                    }

                    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 200.0)];// jumps and back to position
               
                    static const CGFloat thrust = 0.12;
                    [player1.physicsBody applyTorque:thrust]; // rolls
                                    }
                    break;
                case 3:
//                NSLog(@"down");
                    break;
                
                case 4:
//                    NSLog(@"left");
                {
//                    UIImage* left = [UIImage imageNamed: @"char_frame1"];
//                    SKTexture* leftT = [SKTexture textureWithImage: left];
//                    SKSpriteNode * leftNode = [[SKSpriteNode alloc] initWithTexture: leftT];
//                    leftNode.size = CGSizeMake(100, 100);
//                    leftNode.position = CGPointMake((SCREEN_WIDTH-450)/2.0 , 80);
//                    [self addChild: leftNode];
                    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];
                }
//                    SKAction *moveLeft = [SKAction moveToX:(player1.position.x-5) duration:0.1];
//                    [player1 runAction:moveLeft];
                    break;
                case 5:
//                    NSLog(@"right");
                {
//                    UIImage* right = [UIImage imageNamed: @"char_frame1"];
//                    SKTexture* rightT = [SKTexture textureWithImage: right];
//                    SKSpriteNode * rightNode = [[SKSpriteNode alloc] initWithTexture:rightT];
//                    rightNode.size = CGSizeMake(100, 100);
//                    rightNode.position = CGPointMake((SCREEN_WIDTH-450)/2.0 , 80);
//                    [self addChild: rightNode];
                    [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
//                    SKAction *moveRight = [SKAction moveToX:(player1.position.x+5) duration:0.1]; //SKAction has a class methods tso no alloc init
//                                      [player1 runAction:moveRight];
                }
                    break;
                default:
                    break;
            }
                }
//        NSLog(@"button %d %u", [buttons indexOfObject:button],[button containsPoint:location]);
    }
}


















@end
