//
//  CollectionViewCell.h
//  Cats
//
//  Created by Tye Blackie on 2017-08-14.
//  Copyright © 2017 Tye Blackie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
