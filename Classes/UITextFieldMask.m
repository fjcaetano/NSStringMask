//
//  UITextFieldMask.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "UITextFieldMask.h"

@interface UITextFieldMask ()
{
    id<UITextFieldDelegate> extension;
}

@end

@implementation UITextFieldMask

- (void)awakeFromNib
{
    [super awakeFromNib];
    [super setDelegate:self];
}

// An adapter of UITextFieldDelegate to easily integrate with NSStringMask.
- (id)initWithMask:(NSStringMask *)mask
{
    if (! mask) return nil;
    
    self = [super init];
    if (self)
    {
        self.mask = mask;
    }
    return self;
}

#pragma mark - Properties

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    extension = delegate;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([extension respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ! [extension textField:textField shouldChangeCharactersInRange:range replacementString:string])
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
    
    textField.text = mutableString;
    [textField setValue:[NSValue valueWithRange:newRange] forKey:@"selectionRange"];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [extension textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [extension textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [extension textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [extension textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [extension textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([extension respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        textField.text = [self.mask validCharactersForString:textField.text];
        return [extension textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)dealloc
{
    [_mask release], _mask = nil;
    
    [super dealloc];
}

@end
