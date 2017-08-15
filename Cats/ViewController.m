//
//  ViewController.m
//  Cats
//
//  Created by Tye Blackie on 2017-08-14.
//  Copyright © 2017 Tye Blackie. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *mutableCatArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutableCatArray = [NSMutableArray new];
    self.collectionView.dataSource = self;
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *sessionWithoutADelegate = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=1843cc3e956897158504469a5cd1ce7a&tags=cat"];
    
    NSURLSessionDataTask * dataTask = [sessionWithoutADelegate dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
       {

           NSDictionary *massiveCatDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:NSJSONReadingMutableContainers
                                                                                  error:nil];
           
           NSDictionary *photosDict = [massiveCatDictionary valueForKey:@"photos"];
           NSArray *photoArray = [photosDict valueForKey:@"photo"];
           
           for (NSDictionary *photoDict in photoArray){
               Photo *photo = [Photo new];
               photo.farm = [photoDict valueForKey:@"farm"];
               photo.server = [photoDict valueForKey:@"server"];
               photo.secret = [photoDict valueForKey:@"secret"];
               photo.photoID = [photoDict valueForKey:@"id"];
               photo.title = [photoDict valueForKey:@"title"];
               photo.imageURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo.farm, photo.server, photo.photoID, photo.secret];
               [self.mutableCatArray addObject:photo];
           
           }
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self.collectionView reloadData];

               });
                              
           
         }];
    
    [dataTask resume];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.mutableCatArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Photo *thisPhoto = [self.mutableCatArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:thisPhoto.imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    cell.imageView.image = [UIImage imageWithData:imageData];
    cell.label.text = thisPhoto.title;
    
    return cell;
    
}

// Do any additional setup after loading the view, typically from a nib.




@end
