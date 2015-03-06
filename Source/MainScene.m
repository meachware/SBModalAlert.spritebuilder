#import "MainScene.h"
#import "SBModalAlert.h"

@interface MainScene () {
    CCLabelTTF *_textValue, *_sliderValue;
}
@end

@implementation MainScene

-(void)didLoadFromCCB {
}

- (void) fakeMethod {
    NSLog(@"fakeMethod ran");
}

-(void)tellMe:(id)sender {
    SBModalAlert *alertScene = (SBModalAlert*)[CCBReader load:@"SBModalAlert"];
    [alertScene addChild:[alertScene screenShot] z:-1];
    
    [alertScene showConfirmSBAlertWithNotice:@"Run fake method?"
                           withOkBlock:^ {
                               [self fakeMethod];
                           } andCancelBlock:^ {
                               NSLog(@"No fakemethod");
                           }];
    
    [[CCDirector sharedDirector] pushScene:alertScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
}

-(void)showMe:(id)sender {
    SBModalAlert *alertScene = (SBModalAlert*)[CCBReader load:@"SBModalAlert"];
    [alertScene addChild:[alertScene screenShot] z:-1];
    
    [alertScene showTellSBAlertWithStatement:@"Hey, you messed up!"
                        withOkBlock:^ {
                            NSLog(@"Dang it!");
                        }];
    
    [[CCDirector sharedDirector] pushScene:alertScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
}

-(void)askMe:(id)sender {
    SBModalAlert *alertScene = (SBModalAlert*)[CCBReader load:@"SBModalAlert"];
    [alertScene addChild:[alertScene screenShot] z:-1];
    
    [alertScene showAskSBAlertWithQuestion:@"Play a game?"
                      withYesBlock:^{
                          NSLog(@"Selected YES");
                      } andNoBlock:^{
                          NSLog(@"Selected NO");
                      }];
    
    [[CCDirector sharedDirector] pushScene:alertScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
}

-(void)slideMe:(id)sender {
    __weak __block SBModalAlert *alertScene = (SBModalAlert*)[CCBReader load:@"SBModalAlert"];
    [alertScene addChild:[alertScene screenShot] z:-1];
    
    [alertScene showSliderSBAlertWithMaxValue:10
                                      confirm:@"Slider Test"
                                  withOkBlock:^ {
                                      [self fakeMethod];
                                      NSLog(@"Slider: %li",[alertScene currentSliderValue]);
                                      [_sliderValue setString:[NSString stringWithFormat:@"%li",[alertScene currentSliderValue]]];
                                  } andCancelBlock:^ {
                                      
                                  }];
    
    [[CCDirector sharedDirector] pushScene:alertScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
}

-(void)textMe:(id)sender {
    __weak __block SBModalAlert *alertScene = (SBModalAlert*)[CCBReader load:@"SBModalAlert"];
    [alertScene addChild:[alertScene screenShot] z:-1];
    
    [alertScene showTextFieldSBAlertWithConfirm:@"Enter Your Name"
                                    withOkBlock:^ {
                                        [self fakeMethod];
                                        NSLog(@"Text: %@",[alertScene currentTextString]);
                                        [_textValue setString:[alertScene currentTextString]];
                                    } andCancelBlock:^{
                                        
                                    }];
    
    [[CCDirector sharedDirector] pushScene:alertScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
}


@end
