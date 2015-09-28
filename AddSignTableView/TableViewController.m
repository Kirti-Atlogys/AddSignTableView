//
//  TableViewController.m
//  AddSignTableView
//
//  Created by Admin on 30/06/1937 SAKA.
//  Copyright (c) 1937 SAKA Admin. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

int newIndexPath;

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fruits =  [[NSMutableArray alloc] initWithArray:@[@"apple", @"orange", @"mango", @"grapes"]];
    self.fruitsArrayForNewRow = [[NSMutableArray alloc]init];
    
    
    //@[@"apple", @"orange", @"mango", @"grapes"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)editButtonClicked:(id)sender {
    
    
    if ([self.edit.title isEqualToString:@"Edit"]) {
        
        self.edit.title = @"Done";
        
        [self.fruitsArrayForNewRow removeAllObjects];
        [self.fruitsArrayForNewRow addObjectsFromArray:self.fruits];
        [self.fruitsArrayForNewRow addObject:@"Add another entry"];
        
        [self setEditing:YES animated:YES];
        
        [self.tableView reloadData];
        
    } else {
        self.edit.title = @"Edit";
        
        [self.fruits removeAllObjects];
        [self.fruits addObjectsFromArray:self.fruitsArrayForNewRow];
        [self.fruits removeLastObject];
        [self.fruitsArrayForNewRow removeAllObjects];
        
        [self setEditing:NO animated:YES];
        [self.tableView reloadData];
    }
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
    
    if (editing) {
        self.editButtonItem.enabled = YES;
    } else {
        self.editButtonItem.enabled = NO;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.editing) {
        
        if ([self.fruitsArrayForNewRow count]) {
            
            return [self.fruitsArrayForNewRow count];
        }
        
        else {
        
             return  [self.fruits count];
            
        }
       
    }
    
    return  [self.fruits count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
 
    if (self.editing) {
        cell.textLabel.text = [self.fruitsArrayForNewRow objectAtIndex:indexPath.row];
    }
    
    else {
        cell.textLabel.text = [self.fruits objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"accessory clicked");

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", cell.textLabel.text);
    
    newIndexPath = indexPath.row;
    
    ViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detailView.fruit = cell.textLabel.text;
    detailView.delegate = self;
    [self.navigationController pushViewController:detailView animated:YES];

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES ;
}
 

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row ==  [self.fruitsArrayForNewRow count] - 1) {

        return UITableViewCellEditingStyleInsert;
    }
    
    else {
        
        return UITableViewCellEditingStyleDelete;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
          
            [self.fruits removeObjectAtIndex:indexPath.row];
            if (self.fruitsArrayForNewRow.count) {
              
                  [self.fruitsArrayForNewRow removeObjectAtIndex:indexPath.row];
                
            }
        
            
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView reloadData];
            
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"New Entry" message:@"Please enter new row" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            
            [alert show];
            
            self.edit.title = @"Edit";
            [self setEditing:NO animated:YES];
            
        }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        //cancel
        NSLog(@"pressed cancel");
    }
    else {
        //OK
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *newFruit = textField.text;
        
        if (![newFruit isEqualToString:@""]) {
            [self.fruits addObject:textField.text];
            [self.tableView reloadData];
        }
    
        
        NSLog(@"pressed ok");
        
    }
    
    

}

-(void) changeFruitName:(NSString *)fruitName {

    [self.fruits removeObjectAtIndex:newIndexPath];
    [self.fruits insertObject:fruitName atIndex:newIndexPath];
    [self.tableView reloadData];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
