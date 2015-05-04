//
//  RNOAddNewViewController.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "RNOAddNewViewController.h"
#import "RNONews.h"
#import "RNOPhoto.h"
#import "RNOPhotoViewController.h"
#import <Parse/Parse.h>
#import "RNOKeys.h"

@interface RNOAddNewViewController ()<UITextFieldDelegate>

@end

@implementation RNOAddNewViewController

-(id) initWithModel:(RNONews *) aModel{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = aModel;
    }
    
    return self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addNewButton];
    
    //Asigno delegados
    self.titleNewView.delegate = self;
    
    // Alta en notificaciones de teclado
    [self setupKeyboardNotifications];
    
    //sincronizar modelo --> vista
    [self syncWithModel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(didTap:)];
    [self.imageNewView addGestureRecognizer:tap];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Baja en notificaciones
    [self tearDownKeyboardNotifications];
    
    // Validaciones y carga del modelo
    [self validateInputs];
    
}

#pragma mark - actions
//oculatar el teclado
-(IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
    
}

- (IBAction)publicar:(id)sender {
    
    [self.model setStateValue:2];
    [self pushNewNoticeToParse:[self validateInputs]];
    
}

//cambiar foto
-(void)didTap:(UITapGestureRecognizer *) tap{
    
    [self.navigationController pushViewController:[[RNOPhotoViewController alloc]initWithModel:self.model.photo]
                                         animated:YES];
    
}

-(BOOL) validateInputs{
    
    if (![self.authorNewView.text isEqualToString:@""] && ![self.titleNewView.text isEqualToString:@""]  && ![self.textNewView.text isEqualToString:@""]) {
        self.model.author =self.authorNewView.text;
        self.model.titleNew = self.titleNewView.text;
        self.model.textNew = self.textNewView.text;
        UIImage *img = [UIImage imageNamed:@"noImage"];
        if (![self.imageNewView.image isEqual:img]) {
            self.model.photo.image = self.imageNewView.image;
        }
        return YES;
        
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error al validar campos"
                                                                       message:@"Revise que tiene rellenos los campos title y text o que está correctamente logueado."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *accion = [UIAlertAction actionWithTitle:@"Cerrar"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        [alert addAction:accion];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        [self.model.managedObjectContext deleteObject:self.model];
        return NO;
        
    }
    
    
}

#pragma mark - utils
-(void) syncWithModel{
    
    self.title = self.model.titleNew;
    self.titleNewView.text = self.model.titleNew;
    self.authorNewView.text = self.model.author;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:NSDateFormatterShortStyle];
    self.publishDateView.text = [fmt stringFromDate:self.model.creationDate];
    
    self.textNewView.text = self.model.textNew;
    
    if (self.model.photo.image) {
        self.imageNewView.image = self.model.photo.image;
    }
    
}

-(void) addNewButton{
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithTitle:@"Validate"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(validateInputs)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // Buen momento para validar el texto
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    // Buen momento para guardar el texto
}

#pragma mark - keyboard notifications
-(void) setupKeyboardNotifications{
    
    // Alta en notificaciones
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
}

-(void) tearDownKeyboardNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc removeObserver:self];
    
}

// UIKeyboardWillShowNotification
-(void) notifyThatKeyboardWillAppear:(NSNotification *)n{
    
    // Sacar la duración de la animación del teclado
    double duration = [[n.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Sacar el tamaño (bounds) del teclado del objeto
    // userInfo que viene en la notificación
    NSValue *wrappedFrame = [n.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbdFrame = [wrappedFrame CGRectValue];
    
    
    // Calcular los nuevos bounds de self.textView
    // Hacerlo con una animación que coincida con la
    // del teclado
    CGRect currentFrame = self.textNewView.frame;
    
    CGRect newRect = CGRectMake(currentFrame.origin.x,
                                currentFrame.origin.y,
                                currentFrame.size.width,
                                currentFrame.size.height -
                                kbdFrame.size.height);
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.textNewView.frame = newRect;
                     }];
    
    
    
}

//UIKeyboardWillHideNotification
-(void)notifyThatKeyboardWillDisappear:(NSNotification *) n{
    
    // Sacar la duración de la animación del teclado
    double duration = [[n.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Devolver a self.textNewView su bounds original
    // mediante una animación que coincide con la
    // del teclado.
    [UIView animateWithDuration:duration
                     animations:^{
                         self.textNewView.frame = CGRectMake(8,
                                                          171,
                                                          304,
                                                          389);
                         
                     }];
    
}

#pragma mark - parse
-(void)pushNewNoticeToParse:(BOOL) validation{
    NSDictionary *type = @{@"type": [NSString stringWithFormat:@"%@", [self class]]};
    // Envio el tipo de controlador al que accedo
    [PFAnalytics trackEvent:@"controller" dimensions:type];
    if (validation) {
        PFObject *p = [PFObject objectWithClassName:NOTICIAS];
        p[TITULO] = self.model.titleNew;
        p[AUTOR] = [PFUser currentUser];
        p[TEXTO] = self.model.textNew;
        p[STATE] = self.model.state;
        p[LOCALIACION] = [[PFGeoPoint alloc] init];
        [p saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error) {
                // NSLog(@"%@", error);
                PFFile *fileBlob = [PFFile fileWithName:[NSString stringWithFormat:@"img_%@.jpg", self.model.titleNew]
                                                   data:UIImageJPEGRepresentation(self.model.photo.image, 0.9)];
                [fileBlob saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                    if (succeeded) {
                        [p setObject:fileBlob forKey:FOTO];
                        [p saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                            NSLog(@"Subido");
                        }];
                    }
                }progressBlock:^(int percentValue){
                    NSLog(@"Subiendo %d", percentValue);
                }];
            }
            
        }];

    }

    
}

@end
