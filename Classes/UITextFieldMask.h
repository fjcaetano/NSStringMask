//
//  UITextFieldMask.h
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_OS_IPHONE_SIMULATOR

#import <Foundation/Foundation.h>

#import "NSStringMask.h"

/** This subclass of UITextField is used to adapt a text field to NSStringMask.
 
 UITextFieldMask implements all methods in UITextFieldDelegate to be able to integrate and format its text, but it sends the delegate's method's calls forward in case a custom UITextFieldDelegate implementation is needed. In this case, the custom delegate's returns have preference over UITextFieldMask own responses.
 
 For the instance to apply a mask to its text, an instance of NSStringMask must be supplied. It's recommended that the mask is passed in the initialization of the text field, so if the text field is in a nib, the mask must be passed inside `[UIViewController viewDidLoad]` or `[UIView awakeFromNib]`.
 
 ## Usage Example
 
 Example.h
 
    @interface Example : UIView <UITextFieldDelegate>
    
    @property (nonatomic, strong) UITextFieldMask *textFieldMask;
 
    - (BOOL)doSearch:(NSString *)text;
 
    @end
 
 Example.m
 
    @implementation Example
 
    - (void)awakeFromNib
    {
        NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
 
        self.textFieldMask.mask = mask;
        self.textFieldMask.delegate = self;
    }
 
    - (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        return [self doSearch:textField.text];
    }
 
    ...
 
    @end
 
 The instance's methods that conforms to UITextFieldDelegate will always be called __before__ UITextFieldMask's methods and their results have preference. Therefore, if _Example_'s `textFieldShouldReturn:` return `NO`, UITextFieldMask will not evaluate the mask.
 
 */
@interface UITextFieldMask : UITextField <UITextFieldDelegate>

#pragma mark - Properties
/// @name Properties

/** The mask to be applied to the text field.
 */
@property (nonatomic, strong) NSStringMask *mask;

#pragma mark - Instance Methods
/// @name Instance Methods

/** Initializes the instance with a NSStringMask.
 
 _mask_ can't be nil. If so, the method returns nil.
 
 @param mask An instance of NSStringMask
 
 @return An instance of UITextFieldMask
 @return nil if _mask_ is nil
 */
- (id)initWithMask:(NSStringMask *)mask;

@end

#endif