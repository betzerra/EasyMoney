//
//  ExpensesManager.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import <CoreData/CoreData.h>

@interface ExpensesManager : NSObject{
    UIManagedDocument *expensesDatabase;
}

-(NSFetchedResultsController *) lastExpenses;

@property (readonly) UIManagedDocument* expensesDatabase;

SYNTHESIZE_SINGLETON_INTERFACE_FOR_CLASS(ExpensesManager)

@end
