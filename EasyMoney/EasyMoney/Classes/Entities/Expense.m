//
//  Expense.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "Expense.h"
#import "Category.h"


@implementation Expense

@dynamic date;
@dynamic amount;
@dynamic expenseDescription;
@dynamic category;

- (NSString *)dayKey {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *retVal = [dateFormatter stringFromDate:self.date];
    return retVal;
}

@end
