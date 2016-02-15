//
//  AppDelegate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mainTabBarController: UITabBarController?
    
    var talksNavigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //TalkTab
        let talkStoryboard = UIStoryboard(name: "Talks", bundle: NSBundle.mainBundle())
        let talksViewController = talkStoryboard.instantiateViewControllerWithIdentifier("TalksViewController") as! TalksViewController
        self.talksNavigationController = UINavigationController(rootViewController: talksViewController)
        self.talksNavigationController?.tabBarItem = talksNavigationController?.tabBarItem
        
        //TabBar init
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        mainTabBarController = mainStoryboard.instantiateViewControllerWithIdentifier("MainTabBarController") as? UITabBarController
        mainTabBarController?.setViewControllers(NSArray(objects: talksNavigationController!) as? [UIViewController], animated: false)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = mainTabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

