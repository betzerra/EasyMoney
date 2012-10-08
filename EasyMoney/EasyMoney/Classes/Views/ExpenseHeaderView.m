//
//  ExpenseHeaderView.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/8/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpenseHeaderView.h"

@implementation ExpenseHeaderView

#pragma mark - Properties

-(void)setTitle:(NSString *)title{
    titleLabel.text = title;
}

-(NSString *)title{
    return titleLabel.text;
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
    [titleLabel release];
    [super dealloc];
}
@end
