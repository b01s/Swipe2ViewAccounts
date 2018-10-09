@interface T1TimelineNavigationController
- (void)tabWasLongPressed;
@end

@interface T1TabbedViewController
@property(readonly, nonatomic) T1TimelineNavigationController *selectedViewController;
@end

@interface TFNCustomTabBar : UIView
@end

@interface T1TabbedAppNavigationViewController
@property(readonly, nonatomic) TFNCustomTabBar *tabBar; // @synthesize tabBar=_tabBar;
@end

T1TabbedAppNavigationViewController *tanvc=nil;

%hook T1TabbedAppNavigationViewController
- (void)viewDidLoad {
    %orig;
    tanvc=self;
}
%end

%hook T1TabbedViewController
- (void)viewDidAppear:(BOOL)arg1 {
    %orig;
    
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc]
                                                initWithTarget:self.selectedViewController
                                                action:@selector(tabWasLongPressed)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [tanvc.tabBar addGestureRecognizer:swipeUpGesture];
}
%end
