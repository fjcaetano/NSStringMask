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

/** An adapter of UITextFieldDelegate to easily integrate with NSStringMask.
 
 This delegate should go between a UITextField and your UITextFieldDelegate. That is, the text field's delegate __must be__ an instance of UITextFieldMask, but if you need a custom UITextFieldDelegate, than it will be your mask delegate's _extension_. The _extension_ must conform to UITextFieldDelegate
 
 ## Usage Example
 
 Example.h
 
    @interface Example : NSObject <UITextFieldDelegate>
    {
        UITextFieldMask *maskDelegate;
 
        UITextField *textField;
    }
 
    - (void)start;
 
    - (BOOL)doSearch:(NSString *)text;
 
    @end
 
 Example.m
 
    @implementation Example
    
    - (void)start
    {
        NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
 
        maskDelegate = [[UITextFieldMask alloc] initWithMask:mask];
        maskDelegate.extension = self;
 
        textField.delegate = maskDelegate
    }
 
    - (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        return [self doSearch:textField.text];
    }
 
    ...
    
    @end
 
 Note that the _textField_'s delegate is _maskDelegate_ and not self!
 
 The _extension_ methods will always be called __before__ and their results have preference. Therefore, if _Example_'s `textFieldShouldReturn:` return `NO`, UITextFieldMask will repass it to _textField_.
 
 */
@interface UITextFieldMask : NSObject <UITextFieldDelegate>

#pragma mark - Properties
/// @name Properties

/** The class "extension" if a custom UITextFieldDelegate is needed. Has preference over self.
 */
@property (nonatomic, assign) id<UITextFieldDelegate> extension;

/** The mask to be applied to the text field.
 */
@property (nonatomic, readonly) NSStringMask *mask;

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