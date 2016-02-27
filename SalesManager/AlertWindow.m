//
//  AlertWindow.m
//  Edwardsver1
//
//  Created by Admin on 23.02.16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "AlertWindow.h"
#import "Container.h"

#define NON_TITLE @""

@implementation AlertWindow

+ (void)showInfoErrorWindow:(id)sender info:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NON_TITLE message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:okButton];
    [sender presentViewController:alert animated:YES completion:nil];
}
@end
