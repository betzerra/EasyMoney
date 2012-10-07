//
//  ExpenseCell.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/6/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense.h"

@interface ExpenseCell : UITableViewCell{
    
    IBOutlet UILabel *amountLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *categoryLabel;
    IBOutlet UILabel *dateLabel;
}

-(void)setExpense:(Expense *)anExpense;

@end
