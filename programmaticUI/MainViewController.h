//
//  MainViewController.h
//  programmaticUI
//
//  Created by Aditya Narayan on 11/28/16.
//  Copyright © 2016 emikoclark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic,strong) UIView *myContentView;
@property (nonatomic,strong) UILabel *myLabel;
@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UIView *myCornerView;
@property (nonatomic,strong) UIButton *rotateButton;
@property (nonatomic,strong) UISegmentedControl *mySegmentedControl;
@property (nonatomic,strong) UITextView *myTextView;
@property (nonatomic,strong) UIView *calcView;
@property (nonatomic,strong) UITextField *num1;
@property (nonatomic,strong) UITextField *num2;
@property (nonatomic,strong) UILabel *sum;

- (void) createAllObjects;
- (void) createScrollView;
- (void) createLabel;
- (void) createImageView;
- (void) createRotateButton;
- (void) createUIView;
- (void) createCornerUIView;
- (void) createSegmentedButton;
- (void) createMyTextView;
- (void) createSimpleCalculator;

- (IBAction) rotateButtonTapped: (id)sender;
- (IBAction) mySegmentedControlTapped: (id)sender;
- (IBAction)addButtonTapped:(id)sender;

- (CGFloat) calculateScrollContentHeight;

@end
