#import "SwrveConversationUIButton.h"
#import "SwrveConversationButton.h"

#define SWRVEMIN(a,b)    ((a) < (b) ? (a) : (b))
#define SWRVEMAX(a,b)    ((a) > (b) ? (a) : (b))

@interface SwrveConversationUIButton ()

@property (nonatomic, retain) NSString *swrveButtonType;
@property (nonatomic, retain) UIColor *swrveForegroundColor;
@property (nonatomic, retain) UIColor *swrveBackgroundColor;
@property (nonatomic, retain) UIColor *swrveForegroundPressedColor;
@property (nonatomic, retain) UIColor *swrveBackgroundPressedColor;

@end

@implementation SwrveConversationUIButton

@synthesize swrveButtonType;
@synthesize swrveForegroundColor;
@synthesize swrveBackgroundColor;
@synthesize swrveForegroundPressedColor;
@synthesize swrveBackgroundPressedColor;

- (void) initButtonType:(NSString*)buttonType withForegroundColor:(UIColor*)foregroundColor withBackgroundColor:(UIColor*)backgroundColor {
    self.swrveButtonType = buttonType;
    self.swrveForegroundColor = foregroundColor;
    self.swrveBackgroundColor = backgroundColor;
    
    // Calculate pressed colors
    self.swrveForegroundPressedColor = [SwrveConversationUIButton lighterOrDarkerColor:self.swrveForegroundColor];
    self.swrveBackgroundPressedColor = [SwrveConversationUIButton lighterOrDarkerColor:self.swrveBackgroundColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [self updateButtonType:self.swrveButtonType withForegroundColor:self.swrveForegroundColor withBackgroundColor:self.swrveBackgroundColor];
}

- (void) updateButtonType:(NSString*)buttonType withForegroundColor:(UIColor*)foregroundColor withBackgroundColor:(UIColor*)backgroundColor {
    [self setTitleColor:foregroundColor forState:UIControlStateNormal];
    [self setTitleColor:foregroundColor forState:UIControlStateHighlighted];
    [self setTitleColor:foregroundColor forState:UIControlStateSelected];
    
    if ([buttonType isEqualToString:kSwrveTypeSolid]) {
        [self setBackgroundColor:backgroundColor];
    } else if ([buttonType isEqualToString:kSwrveTypeOutline]) {
        [[self layer] setBorderWidth:1.5f];
        [[self layer] setBorderColor:foregroundColor.CGColor];
        [self setBackgroundColor:backgroundColor];
    }
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        [self updateButtonType:self.swrveButtonType withForegroundColor:self.swrveForegroundPressedColor withBackgroundColor:self.swrveBackgroundPressedColor];
    }
    else {
        [self updateButtonType:self.swrveButtonType withForegroundColor:self.swrveForegroundColor withBackgroundColor:self.swrveBackgroundColor];
    }
}

+ (UIColor *)lighterOrDarkerColor:(UIColor*)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a]) {
        if (b < 0.5f) {
            // Color is dark, return a lighter color
            return [UIColor colorWithHue:h
                              saturation:s
                              brightness:SWRVEMIN(b + 0.3f, 1.0)
                                   alpha:a];
        } else {
            // Color is light, return a darker color
            return [UIColor colorWithHue:h
                          saturation:s
                          brightness:SWRVEMAX(b - 0.3f, 0)
                               alpha:a];
        }
    }
    
    return color;
}

@end
