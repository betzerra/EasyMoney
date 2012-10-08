//
//  ExpensesManager.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpensesManager.h"
#import "Expense.h"
#import "Expense+Create.h"
#import "Category.h"
#import "Category+Create.h"

@implementation ExpensesManager
@synthesize expensesDatabase;

-(id)init{
    
    self = [super init];
    if (self){
        //  Init database
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *databaseUrl = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        databaseUrl = [databaseUrl URLByAppendingPathComponent:@"EasyMoneyData"];
        expensesDatabase = [[UIManagedDocument alloc] initWithFileURL:databaseUrl];
        
        if (![fm fileExistsAtPath:[databaseUrl path]]){
            //  Database doesn't exist
            
            [expensesDatabase saveToURL:databaseUrl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            }];
            
        }else if(expensesDatabase.documentState == UIDocumentStateClosed){
            //  Database exists
            
            [expensesDatabase openWithCompletionHandler:^(BOOL success) {
            }];
            
        }else if(expensesDatabase.documentState == UIDocumentStateNormal){
            //  Database exists
            
            [expensesDatabase openWithCompletionHandler:^(BOOL success) {
            }];
        }
        
        NSLog(@"#DEBUG expensesDatabase state: %d", expensesDatabase.documentState);        
    }
    return self;
}

-(NSFetchedResultsController *) lastExpenses{
    NSFetchedResultsController *retVal = nil;
    NSManagedObjectContext *objectContext = [expensesDatabase managedObjectContext];
    
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:objectContext];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    request.sortDescriptors = [NSArray arrayWithObject:aSortDescriptor];
    
    retVal = [[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                  managedObjectContext:objectContext
                                                    sectionNameKeyPath:@"dayKey"
                                                             cacheName:@"lastExpenses"] autorelease];
    return retVal;
}

-(void) addExpenseWithString:(NSString *)aString andDate:(NSDate *)aDate{
    //  Split string into elements using " " as divisor
    NSArray *elements = [aString componentsSeparatedByString:@" "];
    
    NSInteger i = 0;
    
    //  numberFormatter will determine if the string is a number or not
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    //  all the elements starting with "#" are categories
    NSRange firstCharRange = NSMakeRange(0, 1);
    
    NSNumber *amount = nil;
    Category *category = nil;
    NSString *categoryString = nil;
    NSString *descriptionString = nil;
    
    while (i < [elements count]){
        NSString *anElement = [elements objectAtIndex:i];
        
        if (![anElement isEqualToString:@""]){
            //  Get amount
            NSNumber *aNumber = [numberFormatter numberFromString:anElement];
            if (aNumber){
                amount = aNumber;
                
            }else if ([[anElement substringWithRange:firstCharRange] isEqualToString:@"#"]){
                //  Category
                categoryString = anElement;
                
            }else{
                //  Description
                descriptionString = anElement;
            }
        }
        
        i++;
    }
    
    if (categoryString){
        category = [Category categoryWithName:categoryString inManagedObjectContext:[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext];
    }
    
    if (!descriptionString){
        descriptionString = @"";
    }
    
    [Expense expenseWithAmount:amount
                   description:descriptionString
                          date:aDate
                      category:category
        inManagedObjectContext:[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext];
}


SYNTHESIZE_SINGLETON_IMPLEMENTATION_FOR_CLASS(ExpensesManager)

@end
