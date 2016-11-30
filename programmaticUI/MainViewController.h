//
//  MainViewController.h
//  programmaticUI
//
//  Created by Aditya Narayan on 11/28/16.
//  Copyright © 2016 emikoclark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic,strong) UILabel *myLabel;
@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UIView *myCornerView;
@property (nonatomic,strong) UIButton *rotateButton;
@property (nonatomic,strong) UISegmentedControl *mySegmentedControl;
@property (nonatomic,strong) UITextView *myTextView;

- (void) createLabel;
- (void) createImageView;
- (void) createRotateButton;
- (void) createUIView;
- (void) createCornerUIView;
- (void) createSegmentedButton;
- (void) createMyTextView;

- (IBAction) rotateButtonTapped: (id)sender;
- (IBAction) mySegmentedControlTapped: (id)sender;

@end
