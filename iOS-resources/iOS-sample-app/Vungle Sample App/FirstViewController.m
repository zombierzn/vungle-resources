//
//  FirstViewController.m
//  Vungle Sample App
//
//  Created by Jordyn Chuhaloff on 3/24/14.
//  Copyright (c) 2014 Jordyn Chuhaloff. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (strong) NSTimer* canPlayTimer;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Timer (used to check if an ad has been cached)
    _canPlayTimer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1.0f target:self selector:@selector(checkPlay:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_canPlayTimer forMode:NSDefaultRunLoopMode];
    
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

- (void)checkPlay:(NSTimer*)timer {
    
    // When an ad has not yet been cached, disable buttons
    if (![[VungleSDK sharedSDK] isCachedAdAvailable]) {
        _showAdButton.enabled = NO;
        _showAdWithOptionsButton.enabled = NO;
        
    // When an ad has been cached, enable buttons
    } else {
        _showAdButton.enabled = YES;
        _showAdWithOptionsButton.enabled = YES;
    }
}

- (IBAction)showAd
{
    // Play a Vungle ad (with default options)
    VungleSDK* sdk = [VungleSDK sharedSDK];
    [sdk playAd:self];
}

// Play a Vungle ad (with customized options)
-(IBAction)showAdWithOptions
{
    // Grab instance of Vungle SDK
    VungleSDK* sdk = [VungleSDK sharedSDK];
    
    // Dict to set custom ad options
    NSDictionary* options = @{@"orientations": @(UIInterfaceOrientationMaskLandscape),
                              @"incentivized": @(YES),
							  @"userInfo": @{@"user": @""},
                              @"showClose": @(NO)};
    
    // Pass in dict of options, play ad
    [sdk playAd:self withOptions:options];
}

@end

