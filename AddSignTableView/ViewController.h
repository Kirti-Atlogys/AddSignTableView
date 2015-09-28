//
//  ViewController.h
//  AddSignTableView
//
//  Created by Admin on 30/06/1937 SAKA.
//  Copyright (c) 1937 SAKA Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DelegateProtocol <NSObject>

-(void) changeFruitName:(NSString *)fruitName;

@end


@interface ViewController : UIViewController

@property(nonatomic, weak) id delegate;

@property(nonatomic, strong)IBOutlet UILabel *fruitsLabel;
@property(nonatomic, strong)NSString *fruit;

@property (weak, nonatomic) IBOutlet UITextField *updateFruit;
- (IBAction)changeClicked:(id)sender;


@end

