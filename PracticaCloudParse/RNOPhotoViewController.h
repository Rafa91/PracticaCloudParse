//
//  RNOPhotoViewController.h
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 1/5/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNOPhoto;
@interface RNOPhotoViewController : UIViewController

@property (strong, nonatomic) RNOPhoto *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageNewView;

-(id)initWithModel:(RNOPhoto *)aModel;
- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@end
