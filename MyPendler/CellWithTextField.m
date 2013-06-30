//
//  CellWithTextField.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "CellWithTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation CellWithTextField

@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width * 0.3,10 ,self.contentView.bounds.size.width * 0.55 ,self.contentView.bounds.size.height - 20 )];
        textField.clearsOnBeginEditing = NO;
        textField.textAlignment =  NSTextAlignmentLeft;
        textField.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:textField];
        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = self.detailTextLabel.textColor;
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.borderStyle= UITextBorderStyleNone;
        [textField addTarget:self
                      action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
        textField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        textField.clearButtonMode = UITextFieldViewModeNever;

    }
    return self;
}

- (void)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

-(void) setPlaceholder:(NSString *) pl{
    textField.placeholder = pl;
}

-(void) setSecureTextEntry:(BOOL) isSecure{
    textField.secureTextEntry = isSecure;
}

-(NSString *) cellValue{
    
    return textField.text?textField.text:@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
