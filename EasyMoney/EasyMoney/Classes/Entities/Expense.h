//
//  Expense.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Expense : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * expenseDescription;
@property (nonatomic, retain) Category *category;

-(NSString *)dayKey;

@end
