/*
 //  SBModalAlert.m
 //  SampleGame
 //
 //  Created by Greg Meach on 3/4/15.
 //  Copyright (c) 2015 MeachWare. All rights reserved.
 *
 *  Version 0.2
 -  removed unused items
 +  added slider and text field values
 *
 */
/*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/**** INSPIRED BY *****/
/*
 * ModalAlert - Customizable popup dialogs/alerts for Cocos2D
 *
 * For details, visit the Rombos blog:
 * http://rombosblog.wordpress.com/2012/02/28/modal-alerts-for-cocos2d/
 *
 * Copyright (c) 2012 Hans-Juergen Richstein, Rombos
 * http://www.rombos.de
 *
 */


#import "SBModalAlert.h"

typedef void (^btn1Block)(void);
typedef void (^btn2Block)(void);
typedef void (^btn3Block)(void);

@interface SBModalAlert () {
    // SB Scene Objects
    CCLabelTTF *_titleLabel, *_messageLabel;
    CCButton *_button1, *_button2, *_button3;
    CCSprite *_dialogBox;
    CCNodeColor *_colorNode;
    
    // Control Nodes
    CCNode *_messageNode, *_textFieldNode, *_sliderNode;
    
    // TextField Node
    CCLabelTTF *_textFieldMessage;
    CCTextField *_textField;
    
    // Slider Node
    CCSlider *_slider;
    CCLabelTTF *_sliderValue, *_sliderMessage;
    long maxValue;
    
}

@property (nonatomic, copy) btn1Block block1Btn;
@property (nonatomic, copy) btn2Block block2Btn;
@property (nonatomic, copy) btn3Block block3Btn;


@end

@implementation SBModalAlert


/*
 * Galactic Guardian
 *
 * Copyright (c) 2015 Scott Lembcke and Andy Korth
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
/*
 * Screenshot code from Galactic Guardian using runningScene.visit
 */
- (CCSprite*) screenShot {
    CCDirector *director = [CCDirector sharedDirector];
    CGSize viewSize = director.viewSize;
    
    CCRenderTexture *renderTexture = [CCRenderTexture renderTextureWithWidth:viewSize.width height:viewSize.height];
    
    [renderTexture begin];
    [[[CCDirector sharedDirector] runningScene] visit];
    [renderTexture end];
    
    CCSprite *screenGrab = [CCSprite spriteWithTexture:renderTexture.texture];
    screenGrab.anchorPoint = ccp(0.0, 0.0);
    screenGrab.effect = [CCEffectStack effects:
#if !CC_DIRECTOR_IOS_THREADED_RENDERING
                         // BUG!
                         [CCEffectBlur effectWithBlurRadius:4.0],
#endif
                         [CCEffectSaturation effectWithSaturation:-0.5],
                         nil];
    
    return screenGrab;
}

- (void) didLoadFromCCB {
    self.contentSize = [CCDirector sharedDirector].designSize;
    self.contentSizeType = CCSizeTypePoints;
}


- (void) showAskSBAlertWithQuestion:(NSString *) questionText withYesBlock: (void(^)())yesBlock andNoBlock: (void(^)())noBlock {
    [_button1 setTitle: @"YES"];
    [_button2 setTitle: @"NO"];
    [_button3 setVisible: false];
    [_messageLabel setString: (questionText ? questionText : @"null message")];
    [_titleLabel setString: @"Please Choose"];
    
    self.block1Btn = [yesBlock copy];
    self.block2Btn = [noBlock copy];
}

- (void) showConfirmSBAlertWithNotice:(NSString *) noticeText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock {
    [_button1 setTitle: @"OK"];
    [_button2 setTitle: @"CANCEL"];
    [_button3 setVisible: false];
    [_messageLabel setString: (noticeText ? noticeText : @"null question")];
    [_titleLabel setString: @"Please Confirm"];
    
    self.block1Btn = [okBlock copy];
    self.block2Btn = [cancelBlock copy];
}

- (void) showTellSBAlertWithStatement:(NSString *) statementText withOkBlock: (void(^)())okBlock {
    [_button3 setTitle: @"OKAY"];
    [_button1 setVisible: false];
    [_button2 setVisible: false];
    [_button3 setVisible: true];
    [_messageLabel setString: (statementText ? statementText : @"null statement")];
    [_titleLabel setString: @"Information"];
    
    self.block3Btn = [okBlock copy];
}

- (void) showTextFieldSBAlertWithConfirm:(NSString *) questionText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock {
    [_button1 setTitle: @"OK"];
    [_button2 setTitle: @"CANCEL"];
    [_button3 setVisible: false];
    [_messageNode setVisible:false];
    [_textFieldMessage setString: (questionText ? questionText : @"null question")];
    [_titleLabel setString: @"Please Confirm"];
    [_textFieldNode setVisible:true];
    _currentTextString = @"";
    
    self.block1Btn = [okBlock copy];
    self.block2Btn = [cancelBlock copy];
}

- (void) showSliderSBAlertWithMaxValue:(long)max confirm:(NSString *) questionText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock {
    [_button1 setTitle: @"OK"];
    [_button2 setTitle: @"CANCEL"];
    [_button3 setVisible: false];
    [_messageNode setVisible:false];
    [_sliderNode setVisible:true];
    maxValue = max;
    [_sliderMessage setString:(questionText ? questionText : @"Selected Amount")];
    [_titleLabel setString: @"Please Select"];
    
    self.block1Btn = [okBlock copy];
    self.block2Btn = [cancelBlock copy];
}

- (void) closeSBAlertExecutingBlock:(void(^)())btnBlock {
    [_dialogBox runAction:[CCActionSequence actions:
                           [CCActionMoveTo actionWithDuration:0.4 position:ccp(_dialogBox.position.x,_dialogBox.position.y*3)],
                           [CCActionCallBlock actionWithBlock:^{
        if (btnBlock) {
            btnBlock();
        } else {
            NSLog(@"SBModalAlert Notice: btnBlock is NIL");
        }
        [[CCDirector sharedDirector] popScene];
    }],nil]];
    
}

-(void)sliderChanged:(id)sender {
    float sliderVal = (_slider.sliderValue * maxValue);
    [_sliderValue setString:[NSString stringWithFormat:@"Value: [%.0f]",sliderVal]];
    _currentSliderValue = (long)sliderVal;
}

-(void)opt1Button:(id)sender {
    if (_textFieldNode.visible) {
        _currentTextString = _textField.string;
    }
    [self closeSBAlertExecutingBlock:self.block1Btn];
}
-(void)opt2Button:(id)sender {
    [self closeSBAlertExecutingBlock:self.block2Btn];
}
-(void)opt3Button:(id)sender {
    [self closeSBAlertExecutingBlock:self.block3Btn];
}

- (instancetype) init {
    if((self = [super init])) {
    }
    return self;
}

@end
