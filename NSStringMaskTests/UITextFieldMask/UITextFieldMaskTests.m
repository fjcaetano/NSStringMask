//
//  UITextFieldMaskTests.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UITextFieldMask.h"

#import "CompleteExtension.h"
#import "IncompleteExtension.h"

@interface UITextFieldMaskTests : XCTestCase

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
    
    XCTAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:nil]), @"[no throw] empty mask");
    XCTAssertNotNil(tfMask, @"[nil] %@", tfMask);
    
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
    
    XCTAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:mask]), @"[no throw] empty mask");
    XCTAssertNotNil(tfMask, @"[%@]", tfMask);
    
    mask.placeholder = @"_";
    
    XCTAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:mask]), @"[no throw] empty mask");
    XCTAssertNotNil(tfMask, @"[%@]", tfMask);
}

// Testing UITextFieldDelegate methods without extension.
- (void)testNilExtension
{
    BOOL result = NO;
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.text = @"";
    
    // Nil placeholder
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"1"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"1234"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"01234"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"01234"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0123789"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(6, 1) replacementString:@""]), @"[no throw] deleting last char");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"012378"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0378"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"01234"], @"[%@]", tfMask.text);
    
    // Valid Placeholder
    mask = [NSStringMask maskWithPattern:@"(\\d).(\\d{3})"];
    mask.placeholder = @"_";
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"1.___"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"1.234"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.123"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.123"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.127"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@""]), @"[no throw] deleting last char");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.12_"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.2__"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"0.123"], @"[%@]", tfMask.text);
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
    
    XCTAssertNoThrow(([tfMask.delegate textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    
    XCTAssertNoThrow(([tfMask.delegate textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    
    result = NO;
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    XCTAssertTrue(result, @"[%d]", result);
    
    result = NO;
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    XCTAssertTrue(result, @"[%d]", result);
    
    result = NO;
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    XCTAssertTrue(result, @"[%d]", result);
    
    result = NO;
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    XCTAssertTrue(result, @"[%d]", result);
    
    result = YES;
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@"1234567890987654321"], @"[%@]", tfMask.text);
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
    XCTAssertNoThrow(([tfMask.delegate textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidBeginEditing:]"], @"[%@]", tfMask.text);
    
    XCTAssertNoThrow(([tfMask.delegate textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidEndEditing:]"], @"[%@]", tfMask.text);
    
    result = YES;
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldBeginEditing:]"], @"[%@]", tfMask.text);
    XCTAssertFalse(result, @"[%d]", result);
    
    result = YES;
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldClear:]"], @"[%@]", tfMask.text);
    XCTAssertFalse(result, @"[%d]", result);
    
    result = YES;
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldEndEditing:]"], @"[%@]", tfMask.text);
    XCTAssertFalse(result, @"[%d]", result);
    
    result = YES;
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    XCTAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldReturn:]"], @"[%@]", tfMask.text);
    XCTAssertFalse(result, @"[%d]", result);
    
    result = YES;
    tfMask.text = @"";
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(NSNotFound, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:@""], @"[%@]", tfMask.text);
    
    result = YES;
    NSString *newString = @"1234567890987654321";
    XCTAssertNoThrow((result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:newString]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:newString], @"[%@] %@", newString, tfMask.text);
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
    XCTAssertNoThrow(result = [tfMask.delegate textField:tfMask shouldChangeCharactersInRange:range replacementString:replacement], @"[no throw] %@", description);
    XCTAssertFalse(result, @"[%d]", result);
    XCTAssertTrue([tfMask.text isEqualToString:defaultTextField.text], @"[%@] %@", defaultTextField.text, tfMask.text);
}

@end
