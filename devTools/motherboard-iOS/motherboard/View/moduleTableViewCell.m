//
//  moduleTableViewCell.m
//  app
//
//  Created by 李宫 on 2020/9/25.
//  Copyright © 2020 edz. All rights reserved.
//

#import "moduleTableViewCell.h"

@implementation moduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)module_nav:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_nav:)]) {
        [self.delegate module_nav:sender];
    }
    
}
- (IBAction)module_nav_push:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_nav_push:)]) {
        [self.delegate module_nav_push:sender];
    }
}
- (IBAction)module_localstorage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_localstorage:)]) {
        [self.delegate module_localstorage:sender];
    }
}
- (IBAction)module_camera:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_camera:)]) {
        [self.delegate module_camera:sender];
    }
}
- (IBAction)module_device:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_device:)]) {
        [self.delegate module_device:sender];
    }
}
- (IBAction)module_bluetooth:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_bluetooth:)]) {
        [self.delegate module_bluetooth:sender];
    }
}
- (IBAction)module_dcloud:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_dcloud:)]) {
        [self.delegate module_dcloud:sender];
    }
}

- (IBAction)module_lope:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_lope:)]) {
        [self.delegate module_lope:sender];
    }
}
- (IBAction)module_network:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_network:)]) {
        [self.delegate module_network:sender];
    }
}
- (IBAction)module_offline:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_offline:)]) {
        [self.delegate module_offline:sender];
    }
}

- (IBAction)module_router:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_router:)]) {
        [self.delegate module_router:sender];
    }
}

- (IBAction)module_scan:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_scan:)]) {
        [self.delegate module_scan:sender];
    }
}
- (IBAction)module_UI:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_UI:)]) {
        [self.delegate module_UI:sender];
    }
}

- (IBAction)module_tzcash:(id)sender {
    if ([self.delegate respondsToSelector:@selector(module_tzcash:)]) {
        [self.delegate module_tzcash:sender];
    }
}

@end
