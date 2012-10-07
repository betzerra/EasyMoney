//
//  Category+Create.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/7/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "Category.h"

@interface Category (Create)

+ (Category *)categoryWithName:(NSString *)aName
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
