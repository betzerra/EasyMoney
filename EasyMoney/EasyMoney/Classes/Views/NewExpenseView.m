//
//  NewExpenseView.m
//  EasyMoney
//
//  Created by Ezequiel A Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "NewExpenseView.h"
#import <QuartzCore/QuartzCore.h>

@implementation NewExpenseView
@synthesize delegate;

#pragma mark - Public

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = CORNER_RADIUS;
}

- (void)dealloc {
    [expenseTextInput release];
    [super dealloc];
}

#pragma mark - Actions

- (IBAction)cancelButtonTapped:(id)sender {
    [delegate cancelButtonTapped];
}

- (IBAction)acceptButtonTapped:(id)sender {
    [delegate acceptButtonTapped];
}
@end
