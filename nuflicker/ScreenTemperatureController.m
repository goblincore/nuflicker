//
//  ScreenTemperatureController.m
//  nuflicker
//
//  Created by Donny on 4/18/24.
//

#import <Foundation/Foundation.h>
// ScreenTemperatureController.m
#import "ScreenTemperatureController.h"
#import <ApplicationServices/ApplicationServices.h>

@implementation ScreenTemperatureController

+ (void)setColorTemperature:(CGFloat)temperature {
    CGDirectDisplayID displayID = CGMainDisplayID(); // Get the main display ID
    CGGammaValue redMin, redMax, redGamma, greenMin, greenMax, greenGamma, blueMin, blueMax, blueGamma;

    CGGetDisplayTransferByTable(displayID, 0, NULL, NULL, NULL, NULL); // Get the current gamma table values
//    CGGetDisplayTransferByTable(displayID, 256, &redMin, &redMax, &redGamma, &greenMin, &greenMax, &greenGamma, &blueMin, &blueMax, &blueGamma);

    CGFloat newGamma = MAX(0.8, MIN(3.0, 1.0 + (6500 - temperature) / 500)); // Calculate new gamma based on temperature

    CGSetDisplayTransferByFormula(displayID, redMin, redMax, newGamma, greenMin, greenMax, newGamma, blueMin, blueMax, newGamma);
}

@end
