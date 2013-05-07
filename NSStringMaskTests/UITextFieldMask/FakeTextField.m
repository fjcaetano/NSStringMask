//
//  FakeTextField.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "FakeTextField.h"

@implementation FakeTextField
{
    NSRange selectionRange;
}

// init
- (id)init
{
    self = [super init];
    if (self)
    {
        self.text = @"";
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = range.location != NSNotFound;
    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return NO;
}

@end
