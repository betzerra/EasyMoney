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

@implementation ExpensesViewController
@synthesize lastExpenses;

#pragma mark - Private

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lastExpenses = [[ExpensesManager sharedInstance] lastExpenses];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark - NewExpenseViewDelegateProtocol

-(void)cancelButtonTapped{
    [self dismissNewExpenseView];
}

-(void)acceptButtonTapped{
    NSString *aString = newExpenseView.text;
    [Expense expenseWithAmount:[NSNumber numberWithInteger:100]
                   description:aString
                          date:newExpenseView.dateSelected
                      category:nil
        inManagedObjectContext:[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext];

    self.lastExpenses = [[ExpensesManager sharedInstance] lastExpenses];
    [tableView reloadData];
    
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
        Expense *anExpense = [self.lastExpenses objectAtIndex:indexPath.row];
        
        [[ExpensesManager sharedInstance].expensesDatabase.managedObjectContext deleteObject:anExpense];
        
        self.lastExpenses = [[ExpensesManager sharedInstance] lastExpenses];
        [aTableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
    return [lastExpenses count];
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Expense *anExpense = [self.lastExpenses objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"ExpenseCell"];
    cell.textLabel.text = anExpense.expenseDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"At %@ - $%.2f", anExpense.date, [anExpense.amount floatValue]];
    return cell;
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
