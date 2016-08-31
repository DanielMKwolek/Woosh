//
//  ViewController.m
//  MovingStory
//
//  Created by Daniel Kwolek on 8/30/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
- (IBAction)buttonPressRelease:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *mainButton;
@property (strong, nonatomic)NSMutableString *firstString;
@property (strong, nonatomic)NSMutableString *secondString;
@property (nonatomic)NSInteger buttonCount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textFieldConstraint;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)startUp
{
    [self.mainButton.titleLabel setText:@"Press to confirm First Sentence"];
    [self.textField setPlaceholder:@"Please enter first sentence."];
    self.firstString = [[NSMutableString alloc]  initWithString:@""];
    self.secondString = [[NSMutableString alloc] initWithString:@""];
    self.textField.delegate = self;
    self.buttonCount = 0;
    [self.mainButton setHidden:NO];
    [self.textField setHidden:NO];
    self.textFieldConstraint.constant = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)moveFrameto:(CGFloat)flooola
{
    self.textFieldConstraint.constant = flooola;
}

- (IBAction)buttonPressRelease:(UIButton *)sender {
    if (self.buttonCount == 0)
    {
        if ([self.textField.text isEqualToString:[self removeNonAlpha:self.textField.text]] && self.textField.text.length > 0)
        {
            [self.firstString setString:self.textField.text];
            [self.textField  setText:@"First sentence stored, please enter another."];
            [self.textField setPlaceholder:@"Please enter a second sentence."];
            self.buttonCount++;
        } else
        {
            [self.textField setText:[self removeNonAlpha:self.textField.text]];
        }
    } else if (self.buttonCount == 1)
    {
        if ([self.textField.text isEqualToString:[self removeNonAlpha:self.textField.text]] && self.textField.text.length > 0)
        {
            [self.secondString setString:self.textField.text];
            [self.textField setText:@""];
            [self.textField setPlaceholder:@""];
            self.buttonCount++;
            self.textFieldConstraint.constant += 400;
        } else
        {
            [self.textField setText:[self removeNonAlpha:self.textField.text]];
        }
    } else if (self.buttonCount == 2)
    {
        [self.mainButton.titleLabel setText:@"Press to make the magic happen"];
        [self.textField setText:self.firstString];
        [UIView animateWithDuration:7
                         animations:^
         {
             self.textFieldConstraint.constant -= 800;
             [self.view layoutSubviews];
         }];
        
        
        self.buttonCount++;
        [self moveFrameto:400];
        
    } else if(self.buttonCount == 3)
    {
        [self updateViewConstraints];
        
        [self.textField setText:self.secondString];
        [UIView animateWithDuration:7
                         animations:^
         {
             self.textFieldConstraint.constant -= 800;
             [self.view layoutSubviews];
         }];
        [self.mainButton.titleLabel setText:@"Go again?"];
        [self.mainButton setHidden:NO];
        self.buttonCount++;
    }else if(self.buttonCount == 4)
    {
        [self startUp];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (NSString *)removeNonAlpha:(NSString *)nsstring
{
    NSCharacterSet *alphaOnly = [NSCharacterSet characterSetWithCharactersInString:@"acbdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ."];
    NSString *newNstring = [[nsstring componentsSeparatedByCharactersInSet:[alphaOnly invertedSet]] componentsJoinedByString:@""];
    return newNstring;
}
@end
