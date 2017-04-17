//
//  CompleteExtension.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "CompleteExtension.h"

@implementation CompleteExtension

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = range.location != NSNotFound;
    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

@end
