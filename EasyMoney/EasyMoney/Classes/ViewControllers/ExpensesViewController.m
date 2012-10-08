//
//  FirstViewController.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpensesViewController.h"
#import "UIKitHelper.h"
#import "ExpensesManager.h"
#import "Expense.h"
#import "Expense+Create.h"
#import "ExpenseCell.h"
#import "Category.h"
#import "Category+Create.h"

@implementation ExpensesViewController
@synthesize lastExpenses;

#pragma mark - Private

- (void)configureCell:(ExpenseCell *)anExpenseCell atIndexPath:(NSIndexPath *)anIndexPath{
    Expense *anExpense = [self.lastExpenses objectAtIndexPath:anIndexPath];
    [anExpenseCell setExpense:anExpense];
}

- (void)dismissDateSelectionView{
    //  Animate and release view
    [UIView animateWithDuration:0.5 animations:^{
        CGRect endFrame = dateSelectionView.frame;
        endFrame.origin.y = -dateSelectionView.frame.size.height;
        dateSelectionView.frame = endFrame;
    }completion:^(BOOL completed){
        [dateSelectionView removeFromSuperview];
        [dateSelectionView release];
        dateSelectionView = nil;
    }];
}

- (void)dismissNewExpenseView{
    //  Animate and release view
    [UIView animateWithDuration:0.5 animations:^{
        CGRect endFrame = newExpenseView.frame;
        endFrame.origin.y = -newExpenseView.frame.size.height;
        newExpenseView.frame = endFrame;
    }completion:^(BOOL completed){
        [newExpenseView removeFromSuperview];
        [newExpenseView release];
        newExpenseView = nil;
    }];
}

#pragma mark - Public

- (void)viewDidLoad{
    [super viewDidLoad];
    NSError *anError = [[[NSError alloc] init] autorelease];
    self.lastExpenses = [[ExpensesManager sharedInstance] lastExpenses];
    self.lastExpenses.delegate = self;
    BOOL success = [self.lastExpenses performFetch:&anError];
    
    if (!success){
        NSLog (@"#DEBUG ERROR: %@", [anError debugDescription]);
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [lastExpenses release];
    [newExpenseView release];
    [navBar release];
    [tableView release];
    [super dealloc];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];            
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(ExpenseCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [tableView endUpdates];
}

#pragma mark - NewExpenseViewDelegateProtocol

-(void)cancelButtonTapped{
    [self dismissNewExpenseView];
}

-(void)acceptButtonTapped{
    NSString *aString = newExpenseView.text;
    
    NSArray *elements = [aString componentsSeparatedByString:@" "];

    NSInteger i = 0;

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSRange firstCharRange = NSMakeRange(0, 1);
    
    NSNumber *amount = nil;
    Category *category = nil;
    NSString *categoryString = nil;
    NSString *descriptionString = nil;
    
    while (i < [elements count]){
        NSString *anElement = [elements objectAtIndex:i];
        
        //  Get amount
        NSNumber *aNumber = [numberFormatter numberFromString:anElement];
        if (aNumber){
            amount = aNumber;
            
        }else if ([[anElement substringWithRange:firstCharRange] isEqualToString:@"#"]){
            categoryString = anElement;
            
        }else{
            descriptionString = anElement;
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
                          date:newExpenseView.dateSelected
                      category:category
        inManagedObjectContext:[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext];
    
    [self dismissNewExpenseView];
}

-(void)dateButtonTapped{
    if (!dateSelectionView){
        CGRect newFrame = CGRectMake(0, 0, 306, self.view.frame.size.height);
        dateSelectionView = [[DateSelectionView alloc] initWithFrame:newFrame];
        dateSelectionView.delegate = self;
        dateSelectionView.selectedDate = newExpenseView.dateSelected;
        [dateSelectionView retain];
        [self.view insertSubview:dateSelectionView belowSubview:navBar];
        
        //  Animate
        CGRect beginFrame = [UIKitHelper centeredFrameWithUIView:dateSelectionView];
        beginFrame.origin.y = -beginFrame.size.height;
        dateSelectionView.frame = beginFrame;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect endFrame = [UIKitHelper centeredFrameWithUIView:dateSelectionView];
            endFrame.origin.y = navBar.frame.size.height - CORNER_RADIUS;
            dateSelectionView.frame = endFrame;
        }];
    }
}

#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    newExpenseView.dateSelected = date;
    [self dismissDateSelectionView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Expense *anExpense = [self.lastExpenses objectAtIndexPath:indexPath];
        [[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext deleteObject:anExpense];        
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger retVal = 0;
    
    if ([[self.lastExpenses sections] count]){
        retVal = [[self.lastExpenses sections] count];
    }
        
    return retVal;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
    NSInteger retVal = 0;
    
    if ([[self.lastExpenses sections] count]){
        id sectionInfo = [[self.lastExpenses sections] objectAtIndex:section];
        retVal = [sectionInfo numberOfObjects];
    }
    
    return retVal;
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpenseCell *cell = (ExpenseCell *)[aTableView dequeueReusableCellWithIdentifier:@"ExpenseCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *retVal = nil;
    
    if ([[self.lastExpenses sections] count]){
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.lastExpenses sections] objectAtIndex:section];

        float amount = 0;
        for (Expense *anExpense in [sectionInfo objects]){
            amount += [[anExpense amount] floatValue];
        }
        
        retVal = [NSString stringWithFormat:@"%@ ($%.2f)", [sectionInfo name], amount];
    }
    
    return retVal;
}

#pragma mark - Actions

- (IBAction)addButtonTapped:(id)sender {

    if (!newExpenseView){
        newExpenseView = (NewExpenseView *)[UIKitHelper viewFromNibNamed:@"NewExpenseView"];
        newExpenseView.delegate = self;
        [newExpenseView retain];
        [self.view insertSubview:newExpenseView belowSubview:navBar];

        //  Animate
        CGRect beginFrame = [UIKitHelper centeredFrameWithUIView:newExpenseView];
        beginFrame.origin.y = -beginFrame.size.height;
        newExpenseView.frame = beginFrame;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect endFrame = [UIKitHelper centeredFrameWithUIView:newExpenseView];
            endFrame.origin.y = navBar.frame.size.height - CORNER_RADIUS;
            newExpenseView.frame = endFrame;
        }];
    }
}

@end
