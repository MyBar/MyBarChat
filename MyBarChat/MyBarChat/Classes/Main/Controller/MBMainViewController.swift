//
//  MBMainViewController.swift
//  MyBarChat
//
//  Created by lijingui2010 on 2017/6/30.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit

class MBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加tabar控制器的4个子控制器
        let wechatVC = MBWeChatTableViewController()
        self.addChildViewController(wechatVC, title: "微信", imagedNamed: "tabbar_wechat", selectedImagedNamed: "tabbar_wechatHL")
        
        let contactsVC = MBContactsTableViewController()
        self.addChildViewController(contactsVC, title: "通讯录", imagedNamed: "tabbar_contacts", selectedImagedNamed: "tabbar_contactsHL")
        
        let discoverVC = MBDiscoverTableViewController()
        self.addChildViewController(discoverVC, title: "发现", imagedNamed: "tabbar_discover", selectedImagedNamed: "tabbar_discoverHL")
        
        let profileVC = MBProfileTableViewController()
        self.addChildViewController(profileVC, title: "我", imagedNamed: "tabbar_profile", selectedImagedNamed: "tabbar_profileHL")
        
        //设置tabBar的backgroundImage
        self.tabBar.backgroundImage = UIImage(named: "tabbarBkg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     *  添加一个TabBarController的子控制器
     *
     *  @param childController       子控制器
     *  @param title                 标题
     *  @param image                 图片
     *  @param selectedImage         选中的图片
     */
    func addChildViewController(_ childController: UIViewController, title: String, imagedNamed: String, selectedImagedNamed: String) {
        // 设置子控制器的文字
        childController.title = title; // 同时设置tabbar和navigationBar的文字
        
        // 设置子控制器的图片
        childController.tabBarItem.image = UIImage(named: imagedNamed)
        //childController.tabBarItem.
        childController.tabBarItem.selectedImage = UIImage(named: selectedImagedNamed)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        // 设置文字的样式
//        var textAttrs = Dictionary<String, UIColor>()
//        textAttrs[NSForegroundColorAttributeName] = UIColor(red: 0 / 255.0, green: 188.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0)
//        childController.tabBarItem.setTitleTextAttributes(textAttrs, for: UIControlState.normal)
        
        // 设置选中时文字的样式
        var selectTextAttrs = Dictionary<String, UIColor>()
        selectTextAttrs[NSForegroundColorAttributeName] = UIColor(red: 0 / 255.0, green: 188.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0)
        childController.tabBarItem.setTitleTextAttributes(selectTextAttrs, for: UIControlState.selected)
        
        // 先给外面传进来的小控制器 包装 一个导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 添加为子控制器
        self.addChildViewController(nav)
        
    }

}
