//
//  TableViewController.h
//  AddSignTableView
//
//  Created by Admin on 30/06/1937 SAKA.
//  Copyright (c) 1937 SAKA Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface TableViewController : UITableViewController <UIAlertViewDelegate>



@property(nonatomic, strong) UITableView *tableView;
//@property(nonatomic, strong) NSMutableArray *fruitsArray;
@property(nonatomic, strong) NSMutableArray *fruits;
@property(nonatomic, strong) NSMutableArray *fruitsArrayForNewRow;


//@property (weak, nonatomic) IBOutlet UINavigationItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;

- (IBAction)editButtonClicked:(id)sender;

@end
