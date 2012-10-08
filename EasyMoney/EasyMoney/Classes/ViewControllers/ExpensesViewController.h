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
#import "DateSelectionView.h"
#import <CoreData/CoreData.h>

@interface ExpensesViewController : UIViewController <NewExpenseViewDelegateProtocol, UITableViewDataSource, UITableViewDelegate, CKCalendarDelegate, NSFetchedResultsControllerDelegate>{
    NewExpenseView *newExpenseView;
    DateSelectionView *dateSelectionView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *tableView;
    
    NSFetchedResultsController *fetchedResultsController;
}

- (IBAction)addButtonTapped:(id)sender;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
