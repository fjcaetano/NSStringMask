//
//  FakeNYITextField.h
//  NSStringMask
//
//  Created by Flávio Caetano on 5/6/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Fakes an UITextField without implementing any methods of UITextFieldDelegate
 */
@interface FakeNYITextField : NSObject <UITextFieldDelegate>

/// The text displayed by the text field.
@property (nonatomic, strong) NSString *text;

@end
