//
//  ViewController.m
//  AddSignTableView
//
//  Created by Admin on 30/06/1937 SAKA.
//  Copyright (c) 1937 SAKA Admin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.fruit;
    self.fruitsLabel.text = self.fruit;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)changeClicked:(id)sender {
    //call delegate method of TableViewController
    
    NSString *fruityy = self.updateFruit.text;
    [self.delegate changeFruitName:fruityy];
    [self.navigationController popViewControllerAnimated:YES];
        
}
@end
