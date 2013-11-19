//
//  UITextFieldMaskTests.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "UITextFieldMask.h"

#import "CompleteExtension.h"
#import "IncompleteExtension.h"

@interface UITextFieldMaskTests : SenTestCase

/**
 *  Asserts same behavior between `tfMask` and `defaultTextField`.
 *
 *  @param tfMask           A textfield with mask.
 *  @param defaultTextField A default UITextField.
 *  @param range            The text range to be changed.
 *  @param replacement      A replacement string.
 *  @param description      The assertion description.
 */
- (void)assertTextFieldMask:(UITextFieldMask *)tfMask
       withDefaultTextField:(UITextField *)defaultTextField
                      range:(NSRange)range
          replacementString:(NSString *)replacement
                description:(NSString *)description;

@end

@implementation UITextFieldMaskTests

// Unit test cases for the class UITextFieldMask
- (void)testInvalidMask
{
    UITextFieldMask *tfMask;
    UITextField *defaultTextField = [UITextField new];
    
    STAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:nil]), @"[no throw] empty mask");
    STAssertNotNil(tfMask, [NSString stringWithFormat:@"[nil] %@", tfMask]);
    
    CompleteExtension *completeExtension = [CompleteExtension new];
    tfMask.delegate = completeExtension;
    
    // Nil placeholder
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(0, 0)
            replacementString:@"1"
                  description:@"appending character"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(1, 0)
            replacementString:@"234"
                  description:@"appending big range"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(0, 0)
            replacementString:@"0"
                  description:@"inserting character"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(5, 0)
            replacementString:@"5"
                  description:@"appending character"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(4, 1)
            replacementString:@"789"
                  description:@"replacing string"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(tfMask.text.length-1, 1)
            replacementString:@""
                  description:@"deleting last character"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(1, 2)
            replacementString:@""
                  description:@"deleting middle characters"];
    
    [self assertTextFieldMask:tfMask
         withDefaultTextField:defaultTextField
                        range:NSMakeRange(1, 3)
            replacementString:@"1234"
                  description:@"replacing middle string"];
}

// Testing the initialization with valid masks.
- (void)testValidMask
{
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    UITextFieldMask *tfMask;
    
    STAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:mask]), @"[no throw] empty mask");
    STAssertNotNil(tfMask, [NSString stringWithFormat:@"[%@]", tfMask]);
    
    mask.placeholder = @"_";
    
    STAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:mask]), @"[no throw] empty mask");
    STAssertNotNil(tfMask, [NSString stringWithFormat:@"[%@]", tfMask]);
}

// Testing UITextFieldDelegate methods without extension.
- (void)testNilExtension
{
    BOOL result = NO;
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.text = @"";
    
    // Nil placeholder
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0123789"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(6, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"012378"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0378"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    // Valid Placeholder
    mask = [NSStringMask maskWithPattern:@"(\\d).(\\d{3})"];
    mask.placeholder = @"_";
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1.___"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1.234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.127"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.12_"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.2__"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
}

#pragma mark - Testing Extensions

// Testing parcially implemented UITextFieldDelegate methods with extension.
- (void)testExtensionWithoutOptionalMethods
{
    IncompleteExtension *incompleteExtension = [IncompleteExtension new];
    
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\w+)"];
    mask.placeholder = @"x";
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.text = @"";
    tfMask.delegate = incompleteExtension;
    
    BOOL result = NO;
    
    STAssertNoThrow(([tfMask.delegate textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    
    STAssertNoThrow(([tfMask.delegate textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    
    result = NO;
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1234567890987654321"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
}

// Testing fully implemented UITextFieldDelegate methods with extension.
- (void)testExtensionWithOptionalMethods
{
    CompleteExtension *completeExtension = [CompleteExtension new];
    
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\w+)"];
    mask.placeholder = @"abcdefghijklmnopqrstuvwxyz";
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.text = @"";
    tfMask.delegate = completeExtension;
    
    BOOL result = YES;
    
    tfMask.text = @"";
    STAssertNoThrow(([tfMask.delegate textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidBeginEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow(([tfMask.delegate textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidEndEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldBeginEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldClear:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldEndEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldReturn:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(NSNotFound, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@""], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    result = YES;
    NSString *newString = @"1234567890987654321";
    STAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:newString]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:newString], @"[%@] %@", newString, tfMask.text);
}

#pragma mark - Private Methods

//  Asserts same behavior between `tfMask` and `defaultTextField`.
- (void)assertTextFieldMask:(UITextFieldMask *)tfMask
       withDefaultTextField:(UITextField *)defaultTextField
                      range:(NSRange)range
          replacementString:(NSString *)replacement
                description:(NSString *)description
{
    BOOL result;
    [defaultTextField.delegate textField:defaultTextField shouldChangeCharactersInRange:range replacementString:replacement];
    STAssertNoThrow(result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:range replacementString:replacement], @"[no throw] %@", description);
    STAssertFalse(result, @"[%d]", result);
    STAssertTrue([tfMask.text isEqualToString:defaultTextField.text], @"[%@] %@", defaultTextField.text, tfMask.text);
}

@end
