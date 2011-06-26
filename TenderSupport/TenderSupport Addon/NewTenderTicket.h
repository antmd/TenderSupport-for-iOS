//
//  NewTenderTicket.h
//  Task
//
//  Created by Sonny on 3/10/11.
//  Copyright 2011 SonsterMedia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewTenderTicket : UIViewController <UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    UITableView *table;
    UITextField *name;
    UITextField *email;
    UITextField *subject;
    UITextView *message;
    UIScrollView *scrollview;
    BOOL displayKeyboard;
    CGPoint  offset;
    UITextField *Field;
}
@property (nonatomic,retain) IBOutlet UITableView *table;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollview;
@end
