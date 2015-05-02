//
//  AppDelegate.m
//  PracticaCloudParse
//
//  Created by Rafael Navarro on 30/4/15.
//  Copyright (c) 2015 Rafael Navarro. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "RNOPhoto.h"
#import "RNONews.h"
#import "RNONewsViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) AGTCoreDataStack* model;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.model = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    //[self addDummyData];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RNONews entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.creationDate
                                                          ascending:NO],
                            [NSSortDescriptor sortDescriptorWithKey:RNONewsAttributes.titleNew
                                                          ascending:YES]];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"state == 1"];
    req.predicate = p;
    NSFetchedResultsController *fc= [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                        managedObjectContext:self.model.context
                                                                          sectionNameKeyPath:nil cacheName:nil];
    RNONewsViewController *newsVC = [[RNONewsViewController alloc] initWithFetchedResultsController:fc
                                                                                              style:UITableViewStylePlain];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    self.window = [[UIWindow alloc] initWithFrame:
                   [[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = navVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.model saveWithErrorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"error al guardar!!!");
        }
        
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.model saveWithErrorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"error al guardar!!!");
        }
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) addDummyData{
    
    //[self.model zapAllData];
    
    //genero fotos para agregar noticias dummys
    RNOPhoto *caminante = [RNOPhoto photoWithImageData: UIImageJPEGRepresentation([UIImage imageNamed:@"caminante.jpg"], 0.9)
                                               context:self.model.context];
    RNOPhoto *jaime = [RNOPhoto photoWithImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"jaime.jpg"], 0.9)
                                           context:self.model.context];
    RNOPhoto *joffrey = [RNOPhoto photoWithImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"joffrey.jpg"], 0.9)
                                           context:self.model.context];
    RNOPhoto *ned = [RNOPhoto photoWithImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"ned.jpg"], 0.9)
                                         context:self.model.context];
    RNOPhoto *martell = [RNOPhoto photoWithImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"martell.jpg"], 0.9)
                                             context:self.model.context];
    RNOPhoto *robb = [RNOPhoto photoWithImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"robb.jpg"], 0.9)
                                          context:self.model.context];
    
    //genero las noticias
    [RNONews newWithTitle:@"Muerte de caminante blanco"
                   author:@"Rafa"
                     text:@"Muere caminante blanco a manos de Samwell Tarly, el gordo, con una daga de dudosa procedencia"
                    state:1
                    photo:caminante
                 location:nil
                  context:self.model.context];
    
    [RNONews newWithTitle:@"Tragedia de Jaime Lannister"
                   author:@"Rafa"
                     text:@"Por suerte o por desgracia, éste cantamañanas no ha muerto de milagro. El único problema es que perdio una mano en el proceso..."
                    state:1
                    photo:jaime
                 location:nil
                  context:self.model.context];
    
    [RNONews newWithTitle:@"Muerte del rey"
                   author:@"Rafa"
                     text:@"El rey muere en su propia boda por culpa del veneno que ehcaron en su copa de vino. Todo un alivio para el reino y el resto de espectadores. Estaba como una haza pitos."
                    state:2
                    photo:joffrey
                 location:nil
                  context:self.model.context];
    
    [RNONews newWithTitle:@"Muerte del señor de invernalia"
                   author:@"Rafa"
                     text:@"Despedida del mejor actor experto en morirse, no hay serie o película en la que su personaje no muera. Como era de esperar dejo la serie muriendo."
                    state:1
                    photo:ned
                 location:nil
                  context:self.model.context];
    
    [RNONews newWithTitle:@"Juicio por combate (la Víbora vs la Montaña)"
                   author:@"Rafa"
                     text:@"Combate a muerte contra la Montaña. Hiere de muerte a la Montaña pero éste lo agarra de la cabeza y la hace explotar. Para uno que no era mala persona..."
                    state:1
                    photo:martell
                 location:nil
                  context:self.model.context];
    
    [RNONews newWithTitle:@"Muerte del señor del norte"
                   author:@"Rafa"
                     text:@"Matan a tóh quisqui en el banquete, entre ellos caen Robb, su mujer, su madre y el apuntador..."
                    state:1
                    photo:robb
                 location:nil
                  context:self.model.context];
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"error al guardar!!!");
        }
        
    }];
    
}

@end
