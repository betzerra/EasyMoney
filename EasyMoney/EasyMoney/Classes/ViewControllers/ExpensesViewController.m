//
//  FirstViewController.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "ExpensesViewController.h"
#import "UIKitHelper.h"

@implementation ExpensesViewController

#pragma mark - Private

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [newExpenseView release];
    [navBar release];
    [super dealloc];
}

#pragma mark - NewExpenseViewDelegateProtocol

-(void)cancelButtonTapped{
    [self dismissNewExpenseView];
}

-(void)acceptButtonTapped{
    [self dismissNewExpenseView];
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
        
        NSLog(@"#DEBUG Tapped");
    }
}

@end
