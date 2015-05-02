//
//  RNONewViewController.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "RNONewViewController.h"
#import "RNONews.h"
#import "RNOPhoto.h"

@interface RNONewViewController ()

@end

@implementation RNONewViewController

-(id) initWithModel:(RNONews *)aModel{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self syncWithModel];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) syncWithModel{
    
    self.title = self.model.titleNew;
    self.titleNewView.text = self.model.titleNew;
    self.authorNewView.text = self.model.author;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:NSDateFormatterShortStyle];
    self.publishDate.text = [fmt stringFromDate:self.model.creationDate];
    
    self.textNew.text = self.model.textNew;
    
    if (self.model.photo.image) {
        self.imageNewView.image = self.model.photo.image;
    }
    
}

@end
