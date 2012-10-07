//
//  Category+Create.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/7/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "Category+Create.h"

@implementation Category (Create)

+ (Category *)categoryWithName:(NSString *)aName
        inManagedObjectContext:(NSManagedObjectContext *)context{
    
    Category *retVal = nil;
    
    //  Predicate    
    NSString *aPredicateString = [NSString stringWithFormat:@"name = \"%@\"", aName];
    NSPredicate *aPredicate = [NSPredicate predicateWithFormat:aPredicateString];
    
    //  Sort Descriptor
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    //  Fetch
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Category"];
    request.predicate = aPredicate;
    request.sortDescriptors = [NSArray arrayWithObject:aSortDescriptor];
    
    NSError *anError = nil;
    NSArray *matches = [context executeFetchRequest:request error:&anError];
    
    if (!matches){
        //  Handle Error
    }else if ([matches count] == 0){
        //  #TODO add category
        
        retVal = [NSEntityDescription insertNewObjectForEntityForName:@"Category"
                                               inManagedObjectContext:context];
        retVal.name = aName;
    }else{
        retVal = [matches lastObject];
    }
    
    return retVal;
}

@end
