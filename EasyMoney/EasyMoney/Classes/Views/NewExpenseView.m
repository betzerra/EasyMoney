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

#pragma mark - Properties

- (NSString *)text{
    NSString *retVal = expenseTextInput.text;
    return retVal;
}

#pragma mark - Public

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //  View rounded corners
    self.layer.cornerRadius = CORNER_RADIUS;
    
    //  View border color and width
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1].CGColor;
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
