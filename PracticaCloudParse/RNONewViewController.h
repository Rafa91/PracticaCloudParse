//
//  RNONewViewController.h
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNONews;

@interface RNONewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageNewView;
@property (weak, nonatomic) IBOutlet UILabel *titleNewView;
@property (weak, nonatomic) IBOutlet UILabel *authorNewView;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *textNew;

@property  (nonatomic, strong) RNONews *model;

-(id) initWithModel:(RNONews*) aModel;


@end
