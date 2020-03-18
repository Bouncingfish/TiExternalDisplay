/**
 * TiExternalDisplay
 *
 * Created by Duy Bao Nguyen
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "ComBouncingfishTiExternalDisplayModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComBouncingfishTiExternalDisplayModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"693266d3-5826-42c2-bc3c-e24fd4aa271c";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"com.bouncingfish.TiExternalDisplay";
}

#pragma mark Lifecycle

- (void)dealloc
{
  self->extScreen = nil;
  self->extWindow = nil;
  [super dealloc];
}

- (void)startup
{
  // This method is called when the module is first loaded
  // You *must* call the superclass
  [super startup];
  DebugLog(@"[DEBUG] %@ loaded", self);
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenDidConnectNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull notification) {
        if (@available(iOS 13.0, *)) {
            UIScreen *newScreen = [notification object];
            CGRect screenBounds = newScreen.bounds;
            if (self->extScreen == nil) {
                self->extScreen = newScreen;
            }
            if ([self _hasListeners:@"connected"]) {
                [self fireEvent:@"connected" withObject:@{@"rect": [TiUtils rectToDictionary:screenBounds]}];
            }
        }
        else {
            if ([self _hasListeners:@"connected"]) {
                [self fireEvent:@"connected" withObject:@{@"rect": [TiUtils rectToDictionary:CGRectZero]}];
            }
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenDidDisconnectNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull notification) {
        self->extScreen = nil;
        self->extWindow = nil;
        
        if ([self _hasListeners:@"disconnected"]) {
            [self fireEvent:@"disconnected"];
        }
    }];
}

-(void)setupExternalView:(NSArray *)args
{
    if (extScreen) {
        TiViewProxy *viewProxy = [args objectAtIndex:0];
        ENSURE_TYPE(viewProxy, TiViewProxy);
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
        [viewController.view addSubview:viewProxy.view];
        
        // layout view
        [TiUtils setView:viewProxy.view positionRect:extScreen.bounds];
        [viewProxy.view setAutoresizingMask:UIViewAutoresizingNone];

        //Ensure all the child views are laid out as well
        [viewProxy windowWillOpen];
        [viewProxy setParentVisible:YES];
        [viewProxy layoutChildren:NO];
        [viewProxy refreshSize];
        [viewProxy refreshPosition];
        
        // fire postlayout
        dispatch_block_t block = ^{
          [viewProxy fireEvent:@"postlayout" withObject:nil propagate:NO];
        };
        TiThreadPerformOnMainThread(block, NO);
        
        if (extWindow) {
            extWindow = nil;
        }
        extWindow = [[UIWindow alloc] init];
        extWindow.rootViewController = viewController;
        extWindow.screen = extScreen;
        [extWindow makeKeyAndVisible];
    }
    
}

#pragma Public APIs

@end
