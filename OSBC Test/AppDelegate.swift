//
//  AppDelegate.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NFX.sharedInstance().start()        
        
        return true
    }
    
    
}

