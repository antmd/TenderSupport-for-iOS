//
//  NewTenderTicket.m
//  Task
//
//  Created by Sonny on 3/10/11.
//  Copyright 2011 SonsterMedia. All rights reserved.
//

#import "NewTenderTicket.h"
#import "Tender.h"
#import <QuartzCore/QuartzCore.h>

#define SCROLLVIEW_CONTENT_HEIGHT 580
#define SCROLLVIEW_CONTENT_WIDTH  320

@implementation NewTenderTicket
@synthesize table, scrollview;


- (void)dealloc
{
    [message release];
    [Field release];
    [scrollview release];
    [name release];
    [email release];
    [subject release];
    [table release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



-(void) keyboardDidShow: (NSNotification *)notif {
	if (displayKeyboard) {
		return;
	}
	
	
	NSDictionary* info = [notif userInfo];

	NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	offset = scrollview.contentOffset;
	
	CGRect viewFrame = scrollview.frame;
	viewFrame.size.height -= keyboardSize.height;
	scrollview.frame = viewFrame;
	
	CGRect textFieldRect = [message frame];
	textFieldRect.origin.y += 200;
    
	[scrollview scrollRectToVisible: textFieldRect animated:YES];
	displayKeyboard = YES;
}

-(void) keyboardDidHide: (NSNotification *)notif {
	if (!displayKeyboard) {
		return; 
	}
	
	scrollview.frame = CGRectMake(0, 0, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	
	scrollview.contentOffset =offset;
	
	displayKeyboard = NO;
	
}


static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}


#pragma mark - View lifecycle

-(void)createTenderDiscussion{
    Tender *sharedManager = [Tender shared];
    
    if (!IsEmpty(email.text) && !IsEmpty(message.text) && !IsEmpty(subject.text)) {
    NSLog(@"email: %@, body %@, subject: %@",email.text, message.text, subject.text);
#error Input Category ID below
    [sharedManager createDiscussion:subject.text categoryID:00000 public:NO authorEmail:email.text body:message.text skipSpam:YES];
    
    [name resignFirstResponder];
    [email resignFirstResponder];
    [subject resignFirstResponder];
    [message resignFirstResponder];
    
 
    
    [self performSelector:@selector(dismissNav) withObject:nil afterDelay:3.0];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Fill in all text fields" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
 
 
    
}

-(void)dismissNav{
   [self.navigationController popViewControllerAnimated:YES]; 
    
}


- (void)viewDidLoad
{
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(createTenderDiscussion)];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    image.image = [UIImage imageNamed:@"Support.png"];
    


    table.tableHeaderView = image;
    
    [table setBackgroundColor:[UIColor clearColor]];
    self.title = @"Support Ticket";
    [super viewDidLoad];

    scrollview.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH,
										SCROLLVIEW_CONTENT_HEIGHT);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.0f;   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        return 200;
    }
    else {
     return 45;   
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell...
    if (indexPath.row == 0)
    {
        name = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 200, 20)];
        name.text = @"";
        name.delegate = self;
        cell.textLabel.text = @"Name";
        [cell addSubview:name];
        name.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    else if (indexPath.row == 1)
    {
        email= [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 200, 20)];
        email.text = @"";
        email.delegate = self;
        cell.textLabel.text = @"Email";
        [cell addSubview:email];
        email.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    else if (indexPath.row == 2)
    {
        subject = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 200, 20)];
        subject.text = @"";
        subject.delegate = self;
        cell.textLabel.text = @"Subject";
        [cell addSubview:subject];
        subject.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    else if (indexPath.row == 3)
    {
        message = [[UITextView alloc] initWithFrame:CGRectMake(110, 10, 200, 180)];
        message.text = @"";
        message.delegate = self;
        cell.textLabel.text = @"Message";
        [cell addSubview:message];
    }

    
    
    
    
    return cell;
}


- (void) textFieldDidBeginEditing:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
    [table scrollToRowAtIndexPath:[table indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
 




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

@end
