//
//  FirstViewController.m
//  Vungle Sample App
//
//  Created by Jordyn Chuhaloff on 3/24/14.
//  Copyright (c) 2014 Jordyn Chuhaloff. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background color
    #define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
    #define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
    [self.view setBackgroundColor: RGB(0, 191, 255)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (IBAction)showAd
{
    // Play a Vungle ad (with default options)
    VungleSDK* sdk = [VungleSDK sharedSDK];
    [sdk playAd:self];
}

@end

