//
//  RNOPhotoViewController.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 1/5/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "RNOPhotoViewController.h"
#import "RNOPhoto.h"

@interface RNOPhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation RNOPhotoViewController

-(id)initWithModel:(RNOPhoto *)aModel{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = aModel;
    }
    
    return self;
    
}



#pragma mark - View Life cycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Me aseguro que la vista no ocupa toda la
    // pantalla, sino lo que queda disponible
    // dentro del navigation
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    // sincronizo modelo -> vista
    self.imageNewView.image = self.model.image;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.model.image = self.imageNewView.image;
}



- (IBAction)takePicture:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // Uso la cámara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        // Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Lo muestro de forma modal
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Esto se va a ejecutar cuando termine la
                         // animación que muestra al picker.
                     }];
    
}

- (IBAction)deletePhoto:(id)sender {
    
    // la eliminamos del modelo
    self.model.image = nil;
    
    // sincronizo modelo -> vista
    CGRect oldRect = self.imageNewView.bounds;
    [UIView animateWithDuration:0.7
                     animations:^{
                         
                         self.imageNewView.alpha = 0;
                         self.imageNewView.bounds = CGRectZero;
                         self.imageNewView.transform = CGAffineTransformMakeRotation(M_PI_2);
                         
                     } completion:^(BOOL finished) {
                         
                         self.imageNewView.alpha = 1;
                         self.imageNewView.bounds = oldRect;
                         self.imageNewView.transform = CGAffineTransformIdentity;
                         self.imageNewView.image = nil;
                     }];

}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // ¡OJO! Pico de memoria asegurado, especialmente en
    // dispositivos antiguos
    
    
    // Sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardo en el modelo
    [self.model setImage:img];
    
    // Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Se ejecutará cuando se haya ocultado del todo
                             }];
}


@end
