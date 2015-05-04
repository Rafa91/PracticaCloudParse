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
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "RNOKeys.h"

@interface RNONewsViewController ()<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation RNONewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNewButton];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Descargando noticias nuevas"
                                                                          attributes:@{NSFontAttributeName:[UIFont italicSystemFontOfSize:14]}];
    [self.refreshControl addTarget:self
                            action:@selector(refreshByPull:)
                  forControlEvents:UIControlEventValueChanged];
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self loginWithParse];
    
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
    
    UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                            target:self action:@selector(logOutAction:)];
    
    self.navigationItem.rightBarButtonItem = logOutButton;
    
    UIBarButtonItem *myNews = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                            target:self
                                                                            action:@selector(viewMyNews:)];
    self.navigationItem.leftBarButtonItem = myNews;
    
}

-(void) logOutAction:(id) sender{
    
    if ([PFUser currentUser]) {
        [PFUser logOut];
        [self loginWithParse];
    }
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

#pragma mark - Parse

-(void) loginWithParse{
    
    if (![PFUser currentUser]) {
        PFLogInViewController *pfVC = [[PFLogInViewController alloc] init];
        pfVC.delegate = self;
        PFSignUpViewController *suVC = [[PFSignUpViewController alloc]init];
        suVC.delegate = self;
        
        [pfVC setSignUpController:suVC];
        
        [self presentViewController:pfVC
                           animated:YES
                         completion:nil];
    }
    
}

-(void) logInViewController:(PFLogInViewController * __nonnull)logInController
               didLogInUser:(PFUser * __nonnull)user{
    
    NSLog(@"el usuario logado es: %@", [user username]);
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

-(void) logInViewController:(PFLogInViewController * __nonnull)logInController
    didFailToLogInWithError:(nullable NSError *)error{
    
    NSLog(@"%@", error);
    
}

-(void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController
              didSignUpUser:(PFUser * __nonnull)user{
    
    NSLog(@"el usuario logado es: %@", [user username]);
    [PFUser logInWithUsername:user.username password:user.password];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

-(void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController
   didFailToSignUpWithError:(nullable NSError *)error{
    
    NSLog(@"%@", error);
    
}

-(void)downloadDataFromParseWith: (NSDate *)aDate{
    
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    [query whereKey:STATE equalTo:[NSNumber numberWithInt:1]];
    if (aDate) {
        [query whereKey:DATE   greaterThanOrEqualTo:aDate];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        
        if (!error) {
            //cuando lo tengo todo me voy a primer plano
            dispatch_async(dispatch_get_main_queue(), ^{
            [self addToDataBase:objects];
            });
        }else{
            NSLog(@"%@", error);
        }
        
    }];
    
}

-(void)addToDataBase:(NSArray *)objects{
    
    for (PFObject *notice in objects) {
        
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RNONews entityName]];
        req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.creationDate
                                                              ascending:YES]];
        req.predicate = [NSPredicate predicateWithFormat:@"titleNew == %@", notice[TITULO] ];
        NSError *err;
        NSArray *res = [self.fetchedResultsController.managedObjectContext executeFetchRequest:req
                                                                                         error:&err];
        
        if ([res count] == 0) {
            // no tenemos ninguna noticia
            RNONews *n = [RNONews newWithTitle:notice[TITULO]
                                        author:nil
                                          text:notice[TEXTO]
                                         state:[notice[STATE] doubleValue]
                                         photo:nil
                                      location:nil
                                       context:self.fetchedResultsController.managedObjectContext];
            
            if ([notice objectForKey:FOTO]) {
                PFFile *f = notice[FOTO];
                [f getDataInBackgroundWithBlock:^(NSData *result, NSError *error){
                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            n.photo = [RNOPhoto photoWithImageData:result
                                                           context:self.fetchedResultsController.managedObjectContext];
                        });
                    }
                }];
                
            }
            
            PFQuery *query = [PFUser query];
            [query whereKey:PARSEID equalTo:[notice[AUTOR] objectId]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    n.author = [[objects lastObject] username];
                });
                
            }];
        }else{
            RNONews *n = [res lastObject];
            n.state = notice [STATE];
        }
            

            
        
        
    }

   [self.refreshControl endRefreshing];
}

#pragma mark - utils
-(void) refreshByPull: (UITableView *) aTableView{
    
    [self.refreshControl beginRefreshing];
    [self downloadDataFromParseWith:[self lastUpdate]];
    
    
}

-(NSDate *) lastUpdate{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RNONews entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.creationDate
                                                          ascending:YES]];
    NSError *err;
    NSArray *res = [self.fetchedResultsController.managedObjectContext executeFetchRequest:req
                                                                                     error:&err];
    
    if ([res count] == 0) {
        // no tenemos ninguna noticia
        return nil;
    }else{
        return [[res lastObject] creationDate];
    }
    
    
}

@end
