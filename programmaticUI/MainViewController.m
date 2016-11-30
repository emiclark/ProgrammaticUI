//
//  MainViewController.m
//  programmaticUI
//
//  Created by Aditya Narayan on 11/28/16.
//  Copyright © 2016 emikoclark. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#define MAX_NUM 100

static CGRect screenSize;
static CGFloat screenWidth;
static CGFloat screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // calculate screen dimensions for centering uivew
    screenSize = [[UIScreen mainScreen] bounds];
    screenWidth = CGRectGetWidth(screenSize);
    screenHeight = CGRectGetHeight(screenSize);
        
    // Create objects programmactically
    [self createLabel];
    [self createImageView];
    [self createRotateButton];
    [self createUIView];
    [self createSegmentedButton];
    [self createMyTextView];
    [self createCornerUIView];
}


#pragma mark Create elements

- (void) createLabel {
    // Creating a UILabel programmactically
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"TurnToTech";
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    self.myLabel.frame =  CGRectMake((screenWidth - (MAX_NUM*1.25))/2, MAX_NUM/2, MAX_NUM*1.25, 50);
    self.myLabel.textColor = [UIColor blueColor];
    self.myLabel.backgroundColor = [UIColor whiteColor];
    [self.myLabel setFont:[UIFont fontWithName: @"Helvetica"  size:24]];
    [self.view addSubview: self.myLabel];
}


- (void) createImageView {
    // Creating a UIImageView programmactically
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-(MAX_NUM*1.5))/2, MAX_NUM*1.25, MAX_NUM*1.5, MAX_NUM*1.5)];
    self.myImageView.image = [ UIImage  imageNamed: @"turntotech.png"];
    self.myImageView.backgroundColor = [UIColor whiteColor];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.myImageView.layer.borderWidth = 1;
    self.myImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    // create drop shadow
    UIBezierPath *dropShadow = [UIBezierPath bezierPathWithRect: self.myImageView.bounds];
    self.myImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myImageView.layer.masksToBounds = NO;
    self.myImageView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    self.myImageView.layer.shadowRadius = 5;
    self.myImageView.layer.shadowOpacity = 0.5f;
    self.myImageView.layer.shadowPath = dropShadow.CGPath;

    [self.view addSubview: self.myImageView];

}

- (void) createRotateButton {
    
    // create button
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //set the position of the button
    self.rotateButton.frame = CGRectMake((screenWidth-(MAX_NUM*3))/2, MAX_NUM*3.25, MAX_NUM*3, MAX_NUM/2);
    self.rotateButton.layer.cornerRadius = 5;
    
    //set the button's title
    [self.rotateButton setTitle:@"Click to rotate Image" forState:UIControlStateNormal];
    self.rotateButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.rotateButton.backgroundColor = [UIColor greenColor];
    [self.rotateButton addTarget:self  action:@selector(rotateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.rotateButton];
}

- (void) createUIView {
    
    // create subView for customization
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(50, screenHeight - (MAX_NUM * 2.5), screenWidth - MAX_NUM, 25)];
    self.myView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.myView];
}

- (void) createCornerUIView {
    
    // create a view that is pinned to lower rhs of screen regardless of orientation
    self.myCornerView = [[UIView alloc] init];
    NSLog(@"%d",UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation));
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0) { //Default orientation
        //UI is in Default (Portrait) -- this is really a just a failsafe.
        self.myCornerView.frame = CGRectMake(screenWidth-MAX_NUM, screenHeight - MAX_NUM, MAX_NUM, MAX_NUM);
    }
    else if ((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortraitUpsideDown)) {
        //Do something if the orientation is in Portrait
        self.myCornerView.frame = CGRectMake(screenWidth-MAX_NUM, screenHeight - MAX_NUM, MAX_NUM, MAX_NUM);
    }
    else if((orientation == UIInterfaceOrientationLandscapeLeft)  || (orientation == UIInterfaceOrientationLandscapeRight)){
        // Do something if orientation is in Landscape
        self.myCornerView.frame = CGRectMake(screenHeight - MAX_NUM,  screenWidth-MAX_NUM, MAX_NUM, MAX_NUM);
    }
    
    self.myCornerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.myCornerView];
}


- (void) createSegmentedButton {

    // initialize with items
    self.mySegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"IOS", @"Android",nil]];
    
    // center on page
    self.mySegmentedControl.frame = CGRectMake((screenWidth - (self.mySegmentedControl.frame.size.width))/2, 450, self.mySegmentedControl.frame.size.width, self.mySegmentedControl.frame.size.height);

    // set background color
    self.mySegmentedControl.backgroundColor = [UIColor cyanColor];
    
    // set font type and size
    UIFont *myFont = [UIFont fontWithName:@"Helvetica-Bold" size: 17.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject: myFont forKey: NSFontAttributeName];
    [self.mySegmentedControl setTitleTextAttributes: attributes forState:UIControlStateNormal];
    
    // set segments to be proportional to item names
    self.mySegmentedControl.apportionsSegmentWidthsByContent = YES;
    
    
    // add method to handle action when tapped
    [self.mySegmentedControl addTarget:self action:@selector(mySegmentedControlTapped:) forControlEvents: UIControlEventValueChanged];
    
    // add to view
    [self.view addSubview:self.mySegmentedControl];
}

- (void) createMyTextView {
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 500, screenWidth, screenHeight - (screenHeight/3))];
    
    // initialize text into textView
    for (int i=0; i< 50; i++) {
        self.myTextView.text = [self.myTextView.text stringByAppendingString: @"The quick brown fox jumps upon a lazy dog.\n"];
    }
    self.myTextView.backgroundColor = [UIColor redColor];
    [self.myTextView setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.myTextView.textColor = [UIColor whiteColor];
    self.myTextView.scrollEnabled = YES;
    
    // add to view
    [self.view addSubview: self.myTextView];
}



#pragma mark Button Tapped Methods

- (IBAction) rotateButtonTapped: (id)sender {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^ {
        self.myImageView.transform = CGAffineTransformRotate(self.myImageView.transform, M_PI/4);
     } completion:NULL];

}

- (IBAction) mySegmentedControlTapped: (id)sender {

    if (self.mySegmentedControl.selectedSegmentIndex == 0) {
        self.myView.backgroundColor = [UIColor blueColor];
    } else {
        self.myView.backgroundColor = [UIColor yellowColor];
    }
}


#pragma mark Check Device Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Code to execute before the rotation begins.
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    // Code to perform animations during the rotation, or pass nil or leave this block empty if not necessary.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.

        // check self.view size and set self.myCornerView to lower rhs after rotation
        self.myCornerView.frame = CGRectMake(self.view.bounds.size.width - MAX_NUM, self.view.bounds.size.height - MAX_NUM, MAX_NUM, MAX_NUM);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
