//
//  GiocaViewController.m
//  GiftHunters
//
//  Created by Giuseppe Tripodi on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import "GiocaViewController.h"
#import <FacebookSDK/FacebookSDK.h>


@interface GiocaViewController ()

@end

@implementation GiocaViewController
FBLoginView *loginview;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [FBLoginView class];
    loginview = [[FBLoginView alloc] init];
    loginview.readPermissions =    @[@"email",
                                     @"basic_info",
                                     @"user_birthday"];
    loginview.frame = CGRectOffset(loginview.frame, 50, 380);
    loginview.delegate = self;
    [self.view addSubview:loginview];
    [loginview sizeToFit];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
