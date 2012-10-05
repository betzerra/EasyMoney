//
//  ExpensesManager.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/5/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpensesManager.h"
#import <CoreData/CoreData.h>

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

-(NSArray *) lastExpenses{
    NSArray *retVal = nil;
    NSManagedObjectContext *objectContext = [expensesDatabase managedObjectContext];
    
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:objectContext];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    request.sortDescriptors = [NSArray arrayWithObject:aSortDescriptor];
    
    NSError *error = [[[NSError alloc] init] autorelease];
    retVal = [objectContext executeFetchRequest:request error:&error];
    return retVal;
}

SYNTHESIZE_SINGLETON_IMPLEMENTATION_FOR_CLASS(ExpensesManager)

@end
