//
//  LoginFormCell.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithTextField : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

-(void) setPlaceholder:(NSString *) pl;
-(void) setSecureTextEntry:(BOOL) isSecure;
-(NSString *) cellValue;
-(void) setCellValue:(NSString *)value;

@end
