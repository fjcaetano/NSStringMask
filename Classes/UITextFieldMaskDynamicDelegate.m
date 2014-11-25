//
//  UITextFieldMaskDelegate.m
//  Pods
//
//  Created by Alessandro Nakamuta on 20/10/14.
//
//

#import "UITextFieldMaskDynamicDelegate.h"

@implementation UITextFieldMaskDynamicDelegate

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ! [self.realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string])
    {
        return NO;
    }
    
    NSString *mutableString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *clean = [self.mask validCharactersForString:mutableString];
    
    mutableString = [self.mask format:mutableString];
    
    NSRange newRange = NSMakeRange(0, 0);
    
    if (clean.length > 0)
    {
        newRange = [mutableString rangeOfString:[clean substringFromIndex:clean.length-1] options:NSBackwardsSearch];
        if (newRange.location == NSNotFound)
        {
            newRange.location = mutableString.length;
        }
        else
        {
            newRange.location += newRange.length;
        }
        
        newRange.length = 0;
    }
    
    [textField setValue:[NSValue valueWithRange:newRange] forKey:@"selectionRange"];
    textField.text = mutableString;
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [self.realDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [self.realDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [self.realDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [self.realDelegate textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [self.realDelegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.realDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        textField.text = [self.mask validCharactersForString:textField.text];
        return [self.realDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

@end
