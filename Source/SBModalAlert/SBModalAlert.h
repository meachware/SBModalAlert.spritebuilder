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


#import "CCNode.h"

@interface SBModalAlert : CCScene {
    
}

@property long currentSliderValue;
@property NSString *currentTextString;

// Used for background
- (CCSprite*) screenShot;

// Limited
- (void) showAskSBAlertWithQuestion:(NSString *) questionText withYesBlock: (void(^)())yesBlock andNoBlock: (void(^)())noBlock;
- (void) showConfirmSBAlertWithNotice:(NSString *) noticeText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock;
- (void) showTellSBAlertWithStatement:(NSString *) statementText withOkBlock: (void(^)())okBlock;

// User input
- (void) showTextFieldSBAlertWithConfirm:(NSString *) questionText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock;
- (void) showSliderSBAlertWithMaxValue:(long)max confirm:(NSString *) questionText withOkBlock: (void(^)())okBlock andCancelBlock: (void(^)())cancelBlock;

@end
