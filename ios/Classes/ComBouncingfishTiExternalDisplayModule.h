/**
 * TiExternalDisplay
 *
 * Created by Duy Bao Nguyen
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <TitaniumKit/TiWindowProxy.h>

@interface ComBouncingfishTiExternalDisplayModule : TiModule {
    @private
    UIScreen *extScreen;
    UIWindow *extWindow;
    
}

@end
