//
//  KYAMainMenu.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 12.02.22.
//  Copyright © 2022 Marcel Dierkes. All rights reserved.
//

#import "KYAMainMenu.h"
#import <KYACommon/KYACommon.h>
#import "KYALocalizedStrings.h"
#import "KYAAppDelegate.h"

/// Assigns a system symbol image to a menu item.
/// Since macOS 27, AppKit determines the visibility of menu item images and hides
/// them by default, so the image is explicitly requested to be visible.
static void KYARegisterMenuItemSymbolImage(NSMenuItem *menuItem, NSString *symbolName)
{
    NSCParameterAssert(menuItem);
    NSCParameterAssert(symbolName);
    
    if(@available(macOS 26.0, *))
    {
        Auto image = [NSImage imageWithSystemSymbolName:symbolName accessibilityDescription:nil];
        menuItem.image = image;
    }
    if(@available(macOS 27.0, *))
    {
        menuItem.preferredImageVisibility = NSMenuItemImageVisibilityVisible;
    }
}

NSMenu *KYACreateMainMenuWithActivationDurationsSubMenu(NSMenu *activationDurationsSubMenu)
{
    NSCParameterAssert(activationDurationsSubMenu);
    
    Auto mainMenu = [[NSMenu alloc] initWithTitle:@""];
    
    Auto activateForDuration = [[NSMenuItem alloc] initWithTitle:KYA_L10N_ACTIVATE_FOR_DURATION
                                                          action:nil
                                                   keyEquivalent:@""];
    KYARegisterMenuItemSymbolImage(activateForDuration, @"timer");
    activateForDuration.submenu = activationDurationsSubMenu;
    [mainMenu addItem:activateForDuration];
    
    [mainMenu addItem:NSMenuItem.separatorItem];
    
    Auto settings = [[NSMenuItem alloc] initWithTitle:KYA_L10N_SETTINGS_ELLIPSIS
                                               action:@selector(showSettingsWindow:)
                                        keyEquivalent:@","];
    KYARegisterMenuItemSymbolImage(settings, @"gear");
    [mainMenu addItem:settings];
    
    [mainMenu addItem:NSMenuItem.separatorItem];
    
    Auto quit = [[NSMenuItem alloc] initWithTitle:KYA_L10N_QUIT
                                           action:@selector(terminate:)
                                    keyEquivalent:@"q"];
    [mainMenu addItem:quit];
    
    return mainMenu;
}
