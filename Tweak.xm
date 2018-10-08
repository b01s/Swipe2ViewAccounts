@interface T1TimelineNavigationController
- (void)tabWasLongPressed;
@end

@interface T1TabbedViewController
@property(readonly, nonatomic) T1TimelineNavigationController *selectedViewController;
@end

@interface TFNCustomTabBar : UIView
@end

@interface T1TabbedAppNavigationViewController
@property(readonly, nonatomic) T1TabbedViewController *tabController; // @synthesize tabController=_tabController;
@property(readonly, nonatomic) TFNCustomTabBar *tabBar; // @synthesize tabBar=_tabBar;
@end

T1TimelineNavigationController *t1TimelineNavigationController=nil;

%hook T1TabbedAppNavigationViewController
- (void)viewDidAppear:(_Bool)arg1 {
    %orig;
    
    t1TimelineNavigationController = self.tabController.selectedViewController;
    
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:t1TimelineNavigationController action:@selector(tabWasLongPressed)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.tabBar addGestureRecognizer:swipeUpGesture];
}
%end
