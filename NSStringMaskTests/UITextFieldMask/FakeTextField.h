//
//  FakeTextField.h
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Fakes an UITextField implementing all methods of UITextFieldDelegate
 */
@interface FakeTextField : NSObject <UITextFieldDelegate>

/// The text displayed by the text field.
@property (nonatomic, strong) NSString *text;

@end
