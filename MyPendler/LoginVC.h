//
//  LoginVC.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SignUpCompletedDelegate ;

@interface LoginVC : UIViewController<UITableViewDataSource, UITableViewDelegate, SignUpCompletedDelegate>

@property (nonatomic,strong) UITableView *tableView;

-(CGFloat) addImageAndReturnHeight;
-(UITableView *)addTableViewWithTopPadding:(CGFloat) topPadding;


@end
