//
//  UITextFieldMaskTests.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "UITextFieldMaskTests.h"

#import "UITextFieldMask.h"

#import "CompleteExtension.h"
#import "IncompleteExtension.h"

@implementation UITextFieldMaskTests

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
    
    NSStringMask *mask = [NSStringMask maskWithPattern:@"(\\d+)"];
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    tfMask.text = @"";
    
    // Nil Placeholder
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0123789"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(6, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"012378"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0378"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"01234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    // Valid Placeholder
    mask = [NSStringMask maskWithPattern:@"(\\d).(\\d{3})"];
    mask.placeholder = @"_";
    
    tfMask = [[UITextFieldMask alloc] initWithMask:mask];
    
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1"]), @"[no throw] appending character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1.___"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"234"]), @"[no throw] appending big range");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1.234"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"0"]), @"[no throw] inserting character");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(5, 0) replacementString:@"abd[awjd*]\\],"]), @"[no throw] appending garbage");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.123"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@"789"]), @"[no throw] replacing string");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.127"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(4, 1) replacementString:@""]), @"[no throw] deleting last char");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.12_"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 2) replacementString:@""]), @"[no throw] deleting middle");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"0.2__"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(1, 3) replacementString:@"1234"]), @"[no throw] replacing middle string");
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
    
    STAssertNoThrow(([tfMask textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    
    STAssertNoThrow(([tfMask textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = NO;
    STAssertNoThrow((result = [tfMask textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
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
    STAssertNoThrow(([tfMask textFieldDidBeginEditing:tfMask]), @"[no throw] textFieldDidBeginEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidBeginEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    STAssertNoThrow(([tfMask textFieldDidEndEditing:tfMask]), @"[no throw] textFieldDidEndEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldDidEndEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldBeginEditing:tfMask]), @"[no throw] textFieldShouldBeginEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldBeginEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldClear:tfMask]), @"[no throw] textFieldShouldClear:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldClear:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldEndEditing:tfMask]), @"[no throw] textFieldShouldEndEditing:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldEndEditing:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textFieldShouldReturn:tfMask]), @"[no throw] textFieldShouldReturn:");
    STAssertTrue([tfMask.text isEqualToString:@"-[CompleteExtension textFieldShouldReturn:]"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    
    result = YES;
    tfMask.text = @"";
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(NSNotFound, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@""], [NSString stringWithFormat:@"[%@]", tfMask.text]);
    
    result = YES;
    STAssertNoThrow((result = [tfMask textField:tfMask shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"1234567890987654321"]), @"[no throw] textField:shouldChangeCharactersInRange:replacementString:");
    STAssertFalse(result, [NSString stringWithFormat:@"[%d]", result]);
    STAssertTrue([tfMask.text isEqualToString:@"1234567890987654321"], [NSString stringWithFormat:@"[%@]", tfMask.text]);
}

@end
