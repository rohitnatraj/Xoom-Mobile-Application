//
//  AppDelegate.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/17/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
                let xoom = XoomForeignExchangeCurrencyRateWireframe()
                self.window?.rootViewController = xoom.moduleNavigationController
                xoom.presentingListOfCountries()
                return true
        }

        func applicationWillResignActive(_ application: UIApplication) {
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
        }

        func applicationWillTerminate(_ application: UIApplication) {
        }
        
        func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
                return true
        }
        
        func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
                return true
        }


}

