//
//  RNONewsViewController.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "RNONewsViewController.h"
#import "RNONews.h"
#import "RNOPhoto.h"
#import "RNONewViewController.h"
#import "RNOAddNewViewController.h"
#import "RNOMyNewsViewController.h"

@interface RNONewsViewController ()

@end

@implementation RNONewsViewController

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
    
    
    // Devolverla
    return cell;
    
    
}

#pragma mark - Table Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar la noticia
    RNONews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear un contorlador de noticia
    RNONewViewController *nVC = [[RNONewViewController alloc] initWithModel:n];
    
    // Hacer un push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
}


-(void) addNewButton{
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self action:@selector(addNew:)];
    
    self.navigationItem.rightBarButtonItem = add;
    
    UIBarButtonItem *myNews = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                            target:self
                                                                            action:@selector(viewMyNews:)];
    self.navigationItem.leftBarButtonItem = myNews;
    
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
    
    [self.navigationController pushViewController:[[RNOAddNewViewController alloc] initWithModel:n]
                                         animated:YES];
    
}

-(void)viewMyNews:(id) sender{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RNONews entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.state
                                                          ascending:YES],
                            [NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.creationDate
                                                          ascending:NO],
                            [NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.titleNew
                                                          ascending:YES]];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"author = 'Rafa'"];
    req.predicate = p;
    NSFetchedResultsController *fc= [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                        managedObjectContext:self.fetchedResultsController.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
   [self.navigationController pushViewController:[[RNOMyNewsViewController alloc] initWithFetchedResultsController:fc
                                                                                                             style:UITableViewStylePlain]
                                        animated:YES];
    
}

@end
