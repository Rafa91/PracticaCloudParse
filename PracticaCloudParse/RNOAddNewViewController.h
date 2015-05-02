//
//  RNOAddNewViewController.h
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNONews;

@interface RNOAddNewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageNewView;
@property (weak, nonatomic) IBOutlet UITextField *titleNewView;
@property (weak, nonatomic) IBOutlet UILabel *authorNewView;
@property (weak, nonatomic) IBOutlet UILabel *publishDateView;
@property (weak, nonatomic) IBOutlet UITextView *textNewView;

@property (strong, nonatomic) RNONews *model;

-(id) initWithModel:(RNONews *) aModel;

-(IBAction)hideKeyboard:(id)sender;
- (IBAction)publicar:(id)sender;

@end
