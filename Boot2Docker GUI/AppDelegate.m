//
//  AppDelegate.m
//  Boot2Docker GUI
//
//  Created by Rimantas on 08/02/2014.
//  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setAlternateImage: [NSImage imageNamed:@"icon_or"]];
    [self.statusItem setHighlightMode:YES];
    // set image depending on the status
    [self setIcon];
    
}


- (IBAction)Start:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker will be up shortly";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *scriptName = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-up"];
}

- (IBAction)Pause:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-pause"];
}

- (IBAction)Stop:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-stop"];
}

- (IBAction)Restart:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-restart"];
}

- (IBAction)updateDockerClient:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"docker OS X Client";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"Update-Docker"];
}


- (IBAction)updateBoot2DockerScript:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"docker2boot script";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"Update-B2D-Script"];
}


- (IBAction)updateBoot2DockerOS:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"docker2boot OS";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"Update-B2D-Iso"];
}

- (IBAction)reInitB2D:(id)sender {
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"Delete B2D VM + Init"];
}


- (IBAction)installAll:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"docker2boot OS";
    notification.informativeText = @"installation will start shortly";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"B2D-Install"];
}


- (IBAction)About:(id)sender {
    [NSBundle loadNibNamed:@"About" owner:self];
}


- (void)runApp:(NSString*)appName {
    NSString *scriptName = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-stop"];
    
    // set image depending on the status
    [self setIcon];
    
    // lunch external App from the mainBundle
    [[NSWorkspace sharedWorkspace] launchApplication:appName];
}

- (void)runScript:(NSString*)scriptName {
    
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:scriptName ofType:@"command"]];
    [task launch];
    [task waitUntilExit];
    
    // set image depending on the status
    [self setIcon];
}


- (void)setIcon {
    // check b2d status and and return the shell script output
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:@"b2d-status" ofType:@"command"]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    [task waitUntilExit];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//    NSLog (@"Returned:\n%@", string);
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker";
    notification.informativeText = string;
//    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    // check the status and set the correct icon
    if([string rangeOfString:@"running"].location != NSNotFound){
        [self.statusItem setImage:[NSImage imageNamed:@"icon"]];
    }
    else{
        [self.statusItem setImage:[NSImage imageNamed:@"icon_bw"]];
    }
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

@end
