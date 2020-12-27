//
//  AppDelegate.swift
//  CarMap
//
//  Created by mithat samet kaskara on 26.12.2020.
//  Copyright © 2020 Mithat Kaskara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setWindow()
        return true
    }
    
    func setWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MapViewController.instantiate(from: StoryboardNames.map.rawValue)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }

}

