//
//  RNOMyNewsViewController.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 1/5/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "RNOMyNewsViewController.h"
#import "RNONews.h"
#import "RNOPhoto.h"
#import "RNONewViewController.h"
#import "RNOAddNewViewController.h"
#import <Parse/Parse.h>

@interface RNOMyNewsViewController ()

@end

@implementation RNOMyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNewButton];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar cual es la noticia
    RNONews *n = [self.fetchedResultsController
                  objectAtIndexPath:indexPath];
    
    // Crear una celda
    static NSString *cellID = @"newsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellID];
    }
    
    // Configurarla (sincronizar noticia -> celda)
    cell.textLabel.text = n.titleNew;
    cell.detailTextLabel.text = n.author;
    cell.imageView.image = n.photo.image;
    
    if (n.stateValue == 1) {
        cell.textLabel.textColor = [UIColor greenColor];
    }else if (n.stateValue == 2){
        
        cell.textLabel.textColor = [UIColor blueColor];
        
    }else{
        
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    // Devolverla
    return cell;
    
}

#pragma mark - Table Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar la noticia
    RNONews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Comprobar si está en proceso de publicación
    if (n.stateValue == 1) {
        RNONewViewController *nVC = [[RNONewViewController alloc]initWithModel:n];
        NSDictionary *type = @{@"type": [NSString stringWithFormat:@"%@", [self class]]};
        // Envio el tipo de controlador al que accedo
        [PFAnalytics trackEvent:@"controller" dimensions:type];
        // Hacer un push
        [self.navigationController pushViewController:nVC
                                             animated:YES];
    }else{
        
        // Crear un contorlador de noticia
        RNOAddNewViewController *nVC = [[RNOAddNewViewController alloc] initWithModel:n];
        NSDictionary *type = @{@"type": [NSString stringWithFormat:@"%@", [self class]]};
        // Envio el tipo de controlador al que accedo
        [PFAnalytics trackEvent:@"controller" dimensions:type];
        // Hacer un push
        [self.navigationController pushViewController:nVC
                                             animated:YES];
    }
}


-(void) addNewButton{
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self action:@selector(addNew:)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}

-(void) addNew:(id) sender{
    
    RNONews *n = [RNONews newWithTitle:nil
                                author:@"Rafa"
                                  text:nil
                                 state:3
                                 photo:[RNOPhoto photoWithImageData:nil
                                                            context:self.fetchedResultsController.managedObjectContext]
                              location:nil
                               context:self.fetchedResultsController.managedObjectContext];
    
    NSDictionary *type = @{@"type": [NSString stringWithFormat:@"%@", [self class]]};
    // Envio el tipo de controlador al que accedo
    [PFAnalytics trackEvent:@"controller" dimensions:type];
    
    [self.navigationController pushViewController:[[RNOAddNewViewController alloc] initWithModel:n]
                                         animated:YES];
    
}

@end
