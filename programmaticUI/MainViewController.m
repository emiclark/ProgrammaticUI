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
#define TEXTVIEW_HEIGHT 500

static CGRect screenSize;
static CGFloat screenWidth;
static CGFloat screenHeight;
static UIButton *addButton;

#pragma mark View methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.view.bounds;

    self.view.backgroundColor = [UIColor colorWithRed:200/255. green:240/255. blue:252/255. alpha:1.0];

    // calculate screen dimensions for centering uivew in portrait mode
    screenSize = [[UIScreen mainScreen] bounds];
    screenWidth = CGRectGetWidth(screenSize);
    screenHeight = CGRectGetHeight(screenSize);
        
    // Create all objects programmactically
    [self createAllObjects];
    
    // set green square to lower rhs corner of screen
    self.myCornerView.frame = CGRectMake(screenWidth-MAX_NUM, screenHeight - MAX_NUM, MAX_NUM, MAX_NUM);
    [self.view bringSubviewToFront: self.myCornerView];
    
    // add tap gesture to dismiss keyboard when tapped outside of uitextfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark Check Device Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Code to execute before the rotation begins.
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code to perform animations during the rotation, or pass nil or leave this block empty if not necessary.
    
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code to execute after the rotation has finished
        
        // check if orientation is portrait or landscape
        
        if (self.view.frame.size.width == screenWidth) {
            // in portrait mode
            // check self.view size and set self.myCornerView to lower rhs after rotation
            self.myCornerView.frame = CGRectMake(screenWidth - MAX_NUM, screenHeight - MAX_NUM, MAX_NUM, MAX_NUM);
            [self.view bringSubviewToFront:self.myCornerView];
            
            // reset self.myScrollView height to screen height when in portrait mode
            self.myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
            
            [self.myScrollView setContentSize:(CGSizeMake(screenWidth, screenHeight))];
        
        } else {
        // in orientation is landscape
            
            // check self.view size and set self.myCornerView to lower rhs after rotation
            self.myCornerView.frame = CGRectMake(screenHeight - MAX_NUM, screenWidth - MAX_NUM, MAX_NUM, MAX_NUM);
            
            // reset self.myScrollView height to screen height when in portrait mode
            self.myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
            
            // calculate scroll view's content height
            CGFloat scrollHeight = [self calculateScrollContentHeight];
            [self.myScrollView setContentSize:(CGSizeMake(screenWidth, scrollHeight))];
        }
    }];
  }


#pragma mark Create objects and subviews

- (void) createAllObjects {
    // Create objects programmactically
    [self createScrollView];
    [self createLabel];
    [self createImageView];
    [self createRotateButton];
    [self createUIView];
    [self createSegmentedButton];
    [self createMyTextView];
    [self createCornerUIView];
    [self createSimpleCalculator];
}

- (void) createScrollView {
    // create scroll view to scroll through content when device is in landscape mode
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.myScrollView.autoresizesSubviews = YES;
    self.myScrollView.contentMode = UIViewContentModeCenter;

    self.myScrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    [self.view addSubview: self.myScrollView];
    
    // create myContentView to put all subviews to facillitate calculating scrollview height for when in landscape/portrait
    self.myContentView = [[UIView alloc] initWithFrame:self.myScrollView.frame];
    [self.myScrollView addSubview: self.myContentView];
}

- (void) createLabel {
    // Creating a UILabel programmactically
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"TurnToTech";
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    self.myLabel.frame =  CGRectMake((screenWidth - (MAX_NUM*2.25))/2, MAX_NUM/2, MAX_NUM*2.25, 50);
    self.myLabel.textColor = [UIColor blueColor];
    [self.myLabel setFont:[UIFont fontWithName: @"Helvetica"  size:26]];
    [self.myContentView addSubview: self.myLabel];
}


- (void) createImageView {
    // Creating a UIImageView programmactically
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-MAX_NUM)/2, MAX_NUM*01.025, MAX_NUM, MAX_NUM)];
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
    [self.myContentView addSubview: self.myImageView];

}

- (void) createRotateButton {
    
    // create button
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //set the position of the button
    self.rotateButton.frame = CGRectMake((screenWidth-(MAX_NUM*2))/2, MAX_NUM*2.25, MAX_NUM*2, MAX_NUM/4);
    self.rotateButton.layer.cornerRadius = 5;
    
    //set the button's title
    [self.rotateButton setTitle:@"Click to rotate Image" forState:UIControlStateNormal];
    self.rotateButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.rotateButton.backgroundColor = [UIColor greenColor];
    [self.rotateButton addTarget:self  action:@selector(rotateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.myContentView addSubview: self.rotateButton];
}

- (void) createUIView {
    
    // create subView for customization
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(50, screenHeight - (MAX_NUM * 4.0), screenWidth - MAX_NUM, 25)];
    self.myView.backgroundColor = [UIColor yellowColor];
    [self.myContentView addSubview:self.myView];
}


- (void) createSegmentedButton {

    // initialize with items
    self.mySegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"IOS", @"Android",nil]];
    
    // center on page
    self.mySegmentedControl.frame = CGRectMake((screenWidth - (self.mySegmentedControl.frame.size.width))/2, 300, self.mySegmentedControl.frame.size.width, self.mySegmentedControl.frame.size.height);

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
    [self.myContentView addSubview:self.mySegmentedControl];
}

- (void) createMyTextView {
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, TEXTVIEW_HEIGHT, screenWidth, screenHeight - (screenHeight/3))];
    
    // initialize text into textView
    for (int i=0; i< 50; i++) {
        self.myTextView.text = [self.myTextView.text stringByAppendingString: @"The quick brown fox jumps upon a lazy dog.\n"];
    }
    self.myTextView.backgroundColor = [UIColor redColor];
    [self.myTextView setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.myTextView.textColor = [UIColor whiteColor];
    self.myTextView.scrollEnabled = YES;
    [self.myContentView addSubview: self.myTextView];
}

- (void) createSimpleCalculator {
    
    // create field for num1
    self.num1 = [[UITextField alloc] initWithFrame:CGRectMake((screenWidth - MAX_NUM*3.0)/2, (screenHeight+10 - MAX_NUM*3.0), MAX_NUM, MAX_NUM/4)];
    self.num1.textColor = [UIColor lightGrayColor];
    self.num1.backgroundColor = [UIColor whiteColor];
    self.num1.layer.borderWidth = 1;
    self.num1.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.num1 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    self.num1.placeholder = @" Enter 1st # ";
    self.num1.textAlignment =  NSTextAlignmentCenter;
    [self.myContentView addSubview: self.num1];

    // create field for num2
    self.num2 = [[UITextField alloc] initWithFrame:CGRectMake((screenWidth - MAX_NUM*3.0)/2, (screenHeight+45 - MAX_NUM*3.0), MAX_NUM, MAX_NUM/4)];
    self.num2.textColor = [UIColor lightGrayColor];
    self.num2.backgroundColor = [UIColor whiteColor];
    self.num2.layer.borderWidth = 1;
    self.num2.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.num2.placeholder = @" Enter 2nd # ";
    [self.num2 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    self.num2.textAlignment =  NSTextAlignmentCenter;
    [self.myContentView addSubview: self.num2];
    
    // create an addButton to ADD num1 & num2
    addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake((screenWidth - MAX_NUM*.5)/2, screenHeight+7 - MAX_NUM*3.0, MAX_NUM/2, MAX_NUM/2 + 15);
    addButton.backgroundColor = [UIColor cyanColor];
    [addButton setTitle:@"ADD" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [addButton addTarget:self action:@selector(addButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.myContentView addSubview: addButton];
 
    // create field for sum
    self.sum = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - MAX_NUM*(-.75))/2, (screenHeight+25 - MAX_NUM*3.0), MAX_NUM, MAX_NUM/4)];
    self.sum.textColor = [UIColor lightGrayColor];
    self.sum.textAlignment =  NSTextAlignmentCenter;
    self.sum.backgroundColor = [UIColor whiteColor];
    self.sum.layer.borderWidth = 1;
    self.sum.text = @" 0 ";
    self.sum.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.myContentView addSubview: self.sum];
    [self.view addSubview: self.myScrollView];
}

- (void) createCornerUIView {
    
    // create a view that is pinned to lower rhs corner of screen and is visible regardless of orientation
    self.myCornerView = [[UIView alloc] init];
    self.myCornerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.myCornerView];
    [self.view bringSubviewToFront: self.myCornerView];
}

#pragma mark Button Tapped Methods

- (IBAction) rotateButtonTapped: (id)sender {
    
    // tapping the rotate button rotates the image 90 degrees
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^ {
        self.myImageView.transform = CGAffineTransformRotate(self.myImageView.transform, M_PI/4);
     } completion:NULL];

}

- (IBAction) mySegmentedControlTapped: (id)sender {
    
    // selecting segment changes color for self.myView
    if (self.mySegmentedControl.selectedSegmentIndex == 0) {
        self.myView.backgroundColor = [UIColor blueColor];
    } else {
        self.myView.backgroundColor = [UIColor purpleColor];
    }
}


- (IBAction)addButtonTapped:(id)sender {
    
    // adds numbers labels num1 and num2 and displays sum in a label
    self.sum.text = [NSString stringWithFormat:@"%d", [self.num1.text intValue] +  [self.num2.text intValue]];
}


#pragma mark Misc methods

-(void)dismissKeyboard {
    
    // clears keyboard when user taps outside of num1 and num2 label
    [self.num1 resignFirstResponder];
    [self.num2 resignFirstResponder];
    [self.myTextView resignFirstResponder];

}


- (CGFloat) calculateScrollContentHeight {

    // calculates self.contentView subviews to set content size of scroll view
    CGFloat topPoint = 0;
    CGFloat height = 0;
    
    for (UIView *myView in self.myContentView.subviews) {
        if (myView.frame.origin.y > topPoint) {
            topPoint = myView.frame.origin.y;
            height = myView.frame.size.height;
        }
    }
    return height + topPoint;
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
