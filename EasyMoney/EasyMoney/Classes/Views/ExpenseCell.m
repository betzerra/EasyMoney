//
//  ExpenseCell.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/6/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpenseCell.h"
#import "Category.h"

@implementation ExpenseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setExpense:(Expense *)anExpense{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    descriptionLabel.text = [NSString stringWithFormat:@"%@", anExpense.expenseDescription];
    categoryLabel.text = anExpense.category.name;
    amountLabel.text = [NSString stringWithFormat:@"%.2f", [anExpense.amount floatValue]];
    
    [dateFormatter release];
}

- (void)dealloc {
    [amountLabel release];
    [descriptionLabel release];
    [categoryLabel release];
    [super dealloc];
}
@end
