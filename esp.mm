#import <Foundation/Foundation.h>
#import "esp.h"
#import <UIKit/UIKit.h>

@implementation esp : UIView
@synthesize players;
@synthesize espboxes;
@synthesize esplines;
@synthesize healthbarr;
@synthesize distanceesp;
- (id)initWithFrame:(UIWindow*)main
{
    self = [super initWithFrame:main.frame];
    self.userInteractionEnabled = false;
    self.hidden = false;
    self.backgroundColor = [UIColor clearColor];
    if(!players){
        players = new std::vector<player_t *>();
    }
    [main addSubview:self];
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(Update)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    return self;
}
- (void)Update {
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextClearRect(contextRef,self.bounds);
    CGContextSetLineWidth(contextRef, 0.5);
    CGColor *colour;
    UIColor *Ucolour;
    for(int i = 0; i < players->size(); i++) {
        if((*players)[i]->enemy){
            colour = [UIColor redColor].CGColor;
            Ucolour = [UIColor redColor];
        }else{
            colour = [UIColor blueColor].CGColor;
            Ucolour = [UIColor blueColor];
        }
        CGContextSetStrokeColorWithColor(contextRef, colour);
        if(esplines){
            if((*players)[i]->enemy){
                CGContextMoveToPoint(contextRef,self.frame.size.width/2, 0.0f);
                CGContextAddLineToPoint(contextRef, (*players)[i]->topofbox.x, (*players)[i]->topofbox.y);
            }else{
                CGContextMoveToPoint(contextRef,self.frame.size.width/2, self.frame.size.height);
                CGContextAddLineToPoint(contextRef, (*players)[i]->bottomofbox.x, (*players)[i]->bottomofbox.y);
            }
            CGContextStrokePath(contextRef);
        }
        if(espboxes){
            CGContextStrokeRect(contextRef, (*players)[i]->box);
        }
        if(healthbarr){
            [[UIColor redColor] setFill];
            CGContextFillRect(contextRef, (*players)[i]->healthbar);
            [[UIColor greenColor] setFill];
            float cc = (*players)[i]->health/100;
            CGRect healthbar = CGRectMake((*players)[i]->healthbar.origin.x, (*players)[i]->healthbar.origin.y, (*players)[i]->healthbar.size.width, (*players)[i]->healthbar.size.height*cc);
            CGContextFillRect(contextRef, healthbar);
        }
    }
    
}



@end
