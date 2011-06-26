//
//  TenderSupportViewController.m
//  TenderSupport
//
//  Created by Sonny Fazio on 6/5/11.
//  Copyright 2011 SonsterMedia. All rights reserved.
//

#import "TenderSupportViewController.h"
#import "NewTenderTicket.h"

@implementation TenderSupportViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)launchSupport:(id)sender
{
    NewTenderTicket *newTicket = [[NewTenderTicket alloc]initWithNibName:@"NewTenderTicket" bundle:nil];
    [[self navigationController] pushViewController:newTicket animated:YES];
    [newTicket release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
