//
//  DemoTableViewCell.m
//  AutoLayoutDynamicTypeDemo
//
//  Created by Matt Glover on 24/09/2015.
//  Copyright © 2015 Duchy Software Ltd. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        [self configureView];
        [self setNeedsUpdateConstraints];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangePreferredContentSize:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup
- (void) setupView {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.nameLabel];
}

- (void)configureView {
    self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.numberOfLines = 0;
}

- (void)updateConstraints {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nameLabel]-(>=8)-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_nameLabel]-15-|" options:0 metrics:nil views:views]];
    
    [super updateConstraints];
}

#pragma mark - NSNotification Listener
- (void)didChangePreferredContentSize:(NSNotification *)notification {
    [self configureView];
}

@end
