//
//  UITextFieldMaskTests.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "UITextFieldMaskTests.h"

#import "UITextFieldMask.h"

#import "FakeTextField.h"
#import "FakeNYITextField.h"

@implementation UITextFieldMaskTests

// Testing the initialization with invalid masks.
- (void)testEmptyMask
{
    UITextFieldMask *tfMask;
    
    STAssertNoThrow((tfMask = [UITextFieldMask new]), @"[no throw] empty mask");
    STAssertNil(tfMask, [NSString stringWithFormat:@"[%@]", tfMask]);
    
    STAssertNoThrow((tfMask = [[UITextFieldMask alloc] init]), @"[no throw] empty mask");
    STAssertNil(tfMask, [NSString stringWithFormat:@"[%@]", tfMask]);
    
    STAssertNoThrow((tfMask = [[UITextFieldMask alloc] initWithMask:nil]), @"[no throw] empty mask");
    STAssertNil(tfMask, [NSString stringWithFormat:@"[%@]", tfMask]);
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
    UITextFieldMask *tfMask;
    BOOL result;
    
    UITextField *textField = (UITextField *)[FakeTextField new];
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    
    // Nil Placeholder
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1234"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0123789"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(6, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"012378"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0378"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    // Valid Placeholder
    mask = [NSStringMask maskWithPattern:@"(\\d).(\\d{3})"];
    mask.placeholder = @"_";
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    
    textField.text = @"";
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1.___"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1.234"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.127"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.12_"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.2__"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", textField.text]);
}

#pragma mark - Testing Extensions

// Testing parcially implemented UITextFieldDelegate methods with extension.
- (void)testExtensionWithoutOptionalMethods
{
    FakeNYITextField *fakeTextField = [FakeNYITextField new];
    fakeTextField.text = @"";
    
    UITextField *textField = (UITextField *)fakeTextField;
    
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\w+)"];
    mask.placeholder = @"x";
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.extension = fakeTextField;
    
    BOOL result = NO;
    
    STAssertNoThrow(([tfMask textFieldDidBeginEditing:textField]), @"[no throw] textFieldDidBeginEditing:");
    
    STAssertNoThrow(([tfMask textFieldDidEndEditing:textField]), @"[no throw] textFieldDidEndEditing:");
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldBeginEditing:textField]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldClear:textField]), @"[no throw] textFieldShouldClear:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldEndEditing:textField]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldReturn:textField]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1234567890987654321"], [NSString stringWithFormat:@"[%@]", textField.text]);
}

// Testing fully implemented UITextFieldDelegate methods with extension.
- (void)testExtensionWithOptionalMethods
{
    FakeTextField *fakeTextField = [FakeTextField new];
    fakeTextField.text = @"";
    
    UITextField *textField = (UITextField *)fakeTextField;
    
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\w+)"];
    mask.placeholder = @"abcdefghijklmnopqrstuvwxyz";
    
    UITextFieldMask *tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.extension = fakeTextField;
    
    BOOL result = YES;
    
    fakeTextField.text = @"";
    STAssertNoThrow(([tfMask textFieldDidBeginEditing:textField]), @"[no throw] textFieldDidBeginEditing:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldDidBeginEditing:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    STAssertNoThrow(([tfMask textFieldDidEndEditing:textField]), @"[no throw] textFieldDidEndEditing:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldDidEndEditing:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    result = YES;
    fakeTextField.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldBeginEditing:textField]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldShouldBeginEditing:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    fakeTextField.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldClear:textField]), @"[no throw] textFieldShouldClear:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldShouldClear:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    fakeTextField.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldEndEditing:textField]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldShouldEndEditing:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    fakeTextField.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldReturn:textField]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue([textField.text isEqualToString:@"-[FakeTextField textFieldShouldReturn:]"], [NSString stringWithFormat:@"[%@]", textField.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    fakeTextField.text = @"";
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(NSNotFound, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@""], [NSString stringWithFormat:@"[%@]", textField.text]);
    
    result = YES;
    STAssertNoThrow((result = [tfMask textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([textField.text isEqualToString:@"1234567890987654321"], [NSString stringWithFormat:@"[%@]", textField.text]);
}

@end
