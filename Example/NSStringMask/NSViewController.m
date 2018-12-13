//
//  NSViewController.m
//  NSStringMask
//
//  Created by fjcaetano on 04/17/2017.
//  Copyright (c) 2017 fjcaetano. All rights reserved.
//

#import "NSViewController.h"

#import <NSStringMask/NSStringMask.h>
#import <NSStringMask/UITextFieldMask.h>


@interface NSViewController ()
    
    @property (weak, nonatomic) IBOutlet UITextFieldMask *textField;

@end


@implementation NSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField.mask = [[NSStringMask alloc] initWithPattern:@"\\+ (\\d{2}) \\((\\d{3})\\) (\\d{5})-(\\d{4})" placeholder:@"_"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
