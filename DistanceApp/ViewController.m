//
//  ViewController.m
//  DistanceApp
//
//  Created by Tongtong Xu on 11/23/15.
//  Copyright © 2015 Tongtong Xu. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"


@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startlocation;

@property (weak, nonatomic) IBOutlet UITextField *endlocationA;
@property (weak, nonatomic) IBOutlet UILabel *disA;

@property (weak, nonatomic) IBOutlet UITextField *endlocationB;
@property (weak, nonatomic) IBOutlet UILabel *disB;

@property (weak, nonatomic) IBOutlet UITextField *endlocationC;
@property (weak, nonatomic) IBOutlet UILabel *disC;


@property (weak, nonatomic) IBOutlet UIButton *CalButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitControl;
@end

@implementation ViewController
- (IBAction)CalButtonTapped:(id)sender {
    self.CalButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startlocation.text;
    NSString *destA = self.endlocationA.text;
    NSString *destB = self.endlocationB.text;
    NSString *destC = self.endlocationC.text;
    NSArray *dests = @[destA, destB, destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
   
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongself = weakSelf;
        if(!strongself) return;
        
        NSNull *badresult = [NSNull null];
        if(responses[0] != badresult){
            double num;
                if(strongself.unitControl.selectedSegmentIndex == 0){
                    num = ([responses[0] floatValue]/1.0);
                    NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                    strongself.disA.text = x;
                }
                else if(strongself.unitControl.selectedSegmentIndex == 1){
                    num = ([responses[0] floatValue]/1000.0);
                    NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                    strongself.disA.text = x;

                }
                else{
                    num = ([responses[0] floatValue]/1609.3);
                    NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                    strongself.disA.text = x;

                }
            }
        else{
            strongself.disA.text = @"Error";
        }
        
        if(responses[1] != badresult){
            double num;
            if(strongself.unitControl.selectedSegmentIndex == 0){
                num = ([responses[1] floatValue]/1.0);
                NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                strongself.disB.text = x;
            }
            else if(strongself.unitControl.selectedSegmentIndex == 1){
                num = ([responses[1] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongself.disB.text = x;
                
            }
            else{
                num = ([responses[1] floatValue]/1609.3);
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                strongself.disB.text = x;
                
            }
        }
        else{
            strongself.disB.text = @"Error";
        }
        
        if(responses[2] != badresult){
            double num;
            if(strongself.unitControl.selectedSegmentIndex == 0){
                num = ([responses[2] floatValue]/1.0);
                NSString *x = [NSString stringWithFormat:@"%.2f m", num];
                strongself.disC.text = x;
            }
            else if(strongself.unitControl.selectedSegmentIndex == 1){
                num = ([responses[2] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongself.disC.text = x;
                
            }
            else{
                num = ([responses[2] floatValue]/1609.3);
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                strongself.disC.text = x;
                
            }
        }
        else{
            strongself.disC.text = @"Error";
        }


        
        strongself.req = nil;
        
        strongself.CalButton.enabled = YES;

    };
    [self.req start];
}




@end
