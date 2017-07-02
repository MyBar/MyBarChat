//
//  MBLoginViewController.swift
//  MyBarChat
//
//  Created by lijingui2010 on 2017/6/30.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit
import Hyphenate

class MBLoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.text = self.lastLoginUsername
        autoLoginSwitch.isOn = self.lastLoginIsAutoLogin
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        if (username!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) || (password!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            print("用户名和密码不能为空")
            return
        }
        
        //执行登录的请求
        EMClient.shared().login(withUsername: username, password: password) { (aUsername, aError) in
            if (aError != nil) {
                print("登录失败 \(aError!.code)")
                
                if (aError?.code == EMErrorUserAuthenticationFailed) {
                    print("密码错误 \(aError!.code)")
                    
                } else if (aError?.code == EMErrorUserNotFound) {
                    print("用户不存在 \(aError!.code)")
                    
                    //用户不存在后就注册
                    //执行注册的请求
                    EMClient.shared().register(withUsername: username, password: password) { (aUsername, aError) in
                        if (aError != nil) {
                            print("注册失败 \(aError!.code)")
                        }else {
                            print("注册成功")
                        }
                    }
                }
                
            }else {
                print("登录成功")
                
                //自动登录(内部会把用户名和密码保存到用户的偏好设置里)
                EMClient.shared().options.isAutoLogin = self.autoLoginSwitch.isOn
                
                self.saveLastLoginUsername()
                self.saveLastLoginIsAutoLogin()
                
                //进入主界面
                self.view.window?.rootViewController = MBMainViewController()
            }
        }
    }
    
    
    
    private func saveLastLoginUsername() {
        let username = EMClient.shared().currentUsername
        if username != nil && (!username!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(username, forKey: "mb_lastLogin_username")
            userDefaults.synchronize()
        }
    }
    
    private func saveLastLoginIsAutoLogin() {
        let isAutoLogin = EMClient.shared().options.isAutoLogin
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(isAutoLogin, forKey: "mb_lastLogin_isAutoLogin")
        userDefaults.synchronize()
    }
    
    private var lastLoginUsername : String? {
        let userDefaults = UserDefaults.standard
        let username = userDefaults.value(forKey: "mb_lastLogin_username") as? String
        
        if username != nil && (!username!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            return username
        }

        return nil
    }
    
    private var lastLoginIsAutoLogin : Bool {
        let userDefaults = UserDefaults.standard
        let isAutoLogin = userDefaults.value(forKey: "mb_lastLogin_isAutoLogin") as? Bool
        
        return isAutoLogin ?? false
    }
    

}
