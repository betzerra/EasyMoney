//
//  Expense+Create.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "Expense.h"
#import "Category.h"

@interface Expense (Create)

+(Expense *)expenseWithAmount:(NSNumber *)aNumber
                  description:(NSString *)aDescription
                         date:(NSDate *)aDate
                     category:(Category *)aCategory
       inManagedObjectContext:(NSManagedObjectContext *)context;

@end
