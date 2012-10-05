//
//  FirstViewController.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewExpenseView.h"
#import "NewExpenseViewDelegateProtocol.h"

@interface ExpensesViewController : UIViewController <NewExpenseViewDelegateProtocol, UITableViewDataSource, UITableViewDelegate>{
    NewExpenseView *newExpenseView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *tableView;
    
    NSArray *lastExpenses;    
}

@property (retain) NSArray *lastExpenses;

- (IBAction)addButtonTapped:(id)sender;

@end
