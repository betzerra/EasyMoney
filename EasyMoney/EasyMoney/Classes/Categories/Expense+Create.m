//
//  Expense+Create.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "Expense+Create.h"

@implementation Expense (Create)

+(Expense *)expenseWithAmount:(NSNumber *)aNumber
                  description:(NSString *)aDescription
                         date:(NSDate *)aDate
                     category:(Category *)aCategory
       inManagedObjectContext:(NSManagedObjectContext *)context{
    
    //  #TODO there's must be a better way to scape this. Maybe URL encoding?
    aDescription = [aDescription stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    Expense *retVal = nil;
    
    //  Predicate
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    
    NSString *firstPredicateString = [NSString stringWithFormat:@"amount = %.2f AND expenseDescription = \"%@\"", [aNumber floatValue], aDescription];
    NSPredicate *firstPredicate = [NSPredicate predicateWithFormat:firstPredicateString];
    
    NSPredicate *secondPredicate = [NSPredicate predicateWithFormat:@"date = %@", aDate];
    
    [predicates addObject:firstPredicate];
    [predicates addObject:secondPredicate];
    
    NSPredicate *aCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    //  Sort Descriptor
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    //  Fetch
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    request.predicate = aCompoundPredicate;
    request.sortDescriptors = [NSArray arrayWithObject:aSortDescriptor];
    
    NSError *anError = nil;
    NSArray *matches = [context executeFetchRequest:request error:&anError];
    
    if (!matches){
        //  Handle Error
    }else if ([matches count] == 0){
        //  #TODO add category
        
        retVal = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"
                                               inManagedObjectContext:context];
        retVal.amount = aNumber;
        retVal.expenseDescription = aDescription;
        retVal.date = aDate;
    }else{
        retVal = [matches lastObject];
    }
    
    return retVal;
}

@end
