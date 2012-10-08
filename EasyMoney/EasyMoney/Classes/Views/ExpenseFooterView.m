//
//  ExpenseFooterView.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/8/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpenseFooterView.h"

@implementation ExpenseFooterView

#pragma mark - Properties

-(void)setTotalAmount:(float)newTotalAmount{
    totalAmount = newTotalAmount;
    totalLabel.text = [NSString stringWithFormat:@"Total: %.2f", totalAmount];
}

-(float)totalAmount{
    return totalAmount;
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [totalLabel release];
    [super dealloc];
}
@end
