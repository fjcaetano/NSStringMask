//
//  UITextFieldMask.m
//  NSStringMask
//
//  Created by Flávio Caetano on 5/3/13.
//  Copyright (c) 2013 Flavio Caetano. All rights reserved.
//

#import "UITextFieldMask.h"
#import "UITextFieldMaskDynamicDelegate.h"

@interface UITextFieldMask ()

/**
 *  The user defined `UITextFieldDelegate`.
 */
//@property (nonatomic, strong) id<UITextFieldDelegate> _extension;

@property (nonatomic) UITextFieldMaskDynamicDelegate *maskDelegate;

@end

@implementation UITextFieldMask

// An adapter of UITextFieldDelegate to easily integrate with NSStringMask.
- (id)initWithMask:(NSStringMask *)mask
{
    self = [super init];
    if (self)
    {
        self.mask = mask;
    }
    return self;
}

#pragma mark - Properties

-(UITextFieldMaskDynamicDelegate *)maskDelegate{
    if (!_maskDelegate) {
        _maskDelegate = [UITextFieldMaskDynamicDelegate new];
    }
    return _maskDelegate;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    self.maskDelegate.realDelegate = delegate;
}

-(id<UITextFieldDelegate>)delegate{
    return self.maskDelegate.realDelegate;
}

- (void)setMask:(NSStringMask *)mask
{
    self.maskDelegate.mask = mask;
    
    [super setDelegate:(mask ? self.maskDelegate : nil)];
}

-(NSStringMask *)mask{
    return self.maskDelegate.mask;
}

#pragma mark - Overridden Methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self.mask)
    {
        [super setDelegate:self.maskDelegate];
    }
}

@end
