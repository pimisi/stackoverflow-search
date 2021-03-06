//
//  AppDelegate.swift
//  StackoverflowSearch
//
//  Created by Paul Imisi on 2020/07/27.
//  Copyright © 2020 Osiris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNavigationBar()
        configureSearchBar()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    static var rootViewController: UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
}

extension AppDelegate {
    fileprivate func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = .gray
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigationBarAppearance.barStyle = .default
        navigationBarAppearance.barTintColor = .white
    }
    
    fileprivate func configureSearchBar() {
        let searchBarAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchBarAppearance.backgroundColor = .white
    }
}

