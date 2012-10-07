//
//  ExpenseCell.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/6/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpenseCell.h"

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
    categoryLabel.text = @"#tag";
    amountLabel.text = [NSString stringWithFormat:@"%.2f", [anExpense.amount floatValue]];
    dateLabel.text = [NSString stringWithFormat:@"At %@", [dateFormatter stringFromDate:anExpense.date]];
    
    [dateFormatter release];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize descriptionLabelSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font];
    CGRect descriptionLabelRect = CGRectMake(descriptionLabel.frame.origin.x,
                                             descriptionLabel.frame.origin.y,
                                             descriptionLabelSize.width,
                                             descriptionLabelSize.height);
    descriptionLabel.frame = descriptionLabelRect;

    CGSize categoryLabelSize = [categoryLabel.text sizeWithFont:categoryLabel.font];
    CGRect categoryLabelRect = CGRectMake(descriptionLabel.frame.origin.x + descriptionLabel.frame.size.width + 15,
                                          categoryLabel.frame.origin.y,
                                          categoryLabelSize.width,
                                          categoryLabelSize.height);
    categoryLabel.frame = categoryLabelRect;
}

- (void)dealloc {
    [amountLabel release];
    [descriptionLabel release];
    [categoryLabel release];
    [dateLabel release];
    [super dealloc];
}
@end
