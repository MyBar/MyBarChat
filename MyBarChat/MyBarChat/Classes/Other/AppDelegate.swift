//
//  AppDelegate.swift
//  MyBarChat
//
//  Created by lijingui2010 on 2017/6/30.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit
import Hyphenate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, EMClientDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //AppKey:注册的AppKey，详细见下面注释。
        //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
        let options = EMOptions(appkey: "1136170617115842#wechat")
        //options?.apnsCertName = "istore_dev"
        EMClient.shared().initializeSDK(with: options)
        
        //添加EMClient的代理
        EMClient.shared().add(self, delegateQueue: nil)
        
        
        //创建窗口
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //自动登录：即首次登录成功后，不需要再次调用登录方法，在下次 APP 启动时，SDK 会自动为您登录。并且如果您自动登录失败，也可以读取到之前的会话信息。
        //SDK 中自动登录属性默认是关闭的，需要您在登录成功后设置，以便您在下次 APP 启动时不需要再次调用环信登录，并且能在没有网的情况下得到会话列表。
        if EMClient.shared().options.isAutoLogin {
            
            self.window?.rootViewController = MBMainViewController()
            
            
        } else {
            
            self.window?.rootViewController = MBLoginViewController()
            
        }
        
        //设置主窗口并可见
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        EMClient.shared().applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        EMClient.shared().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //EMClientDelegate中的方法，如果发生自动登录，会有以下回调
    func autoLoginDidCompleteWithError(_ aError: EMError!) {
        print("autoLoginDidCompleteWithError - \(aError)")
    }
    
    //EMClientDelegate中的方法，当前登录账号在其它设备登录时会接收到此回调
    func userAccountDidLoginFromOtherDevice() {
        
        self.window?.rootViewController = MBLoginViewController()
        
        let alert = UIAlertController(title: "提醒", message: "当前帐号在其它设备登录，如非本人操作，请及时修改密码", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

