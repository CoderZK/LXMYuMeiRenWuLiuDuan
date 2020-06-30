//
//  LxmCopyLabel.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/10/31.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmCopyLabel.h"

@implementation LxmCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        UILongPressGestureRecognizer * recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressEvent:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

-(void)longPressEvent:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];//一定要写
        UIMenuController * menuController = [UIMenuController sharedMenuController];
        [menuController setTargetRect:self.bounds inView:self];
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder{
    return true;
}

- (void)copy:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.text];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return action == @selector(copy:);
}

@end
