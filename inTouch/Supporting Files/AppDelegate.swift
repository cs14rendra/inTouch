//
//  AppDelegate.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit
import RealmSwift
var realm  : Realm?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        let defaultParentURL = defaultURL.deletingLastPathComponent()
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Contacts.className()) { oldObject, newObject in
                   
                }
            }
          
            print("Migration complete.")
        }
       
        if let url = bundleURL("defaultV1") {
            let realmURL = defaultParentURL.appendingPathComponent("defaultV1.realm")
            print(realmURL)
            let realmnewConfiguration = Realm.Configuration(fileURL: realmURL, schemaVersion: 1, migrationBlock: migrationBlock)
            do {
                
                if FileManager.default.fileExists(atPath: String(describing: realmURL)){
                    print("Exist")
                 try FileManager.default.removeItem(at: realmURL)
                }
                try FileManager.default.copyItem(at: url, to: realmURL)
              
            } catch {
                print(error.localizedDescription)
            }
            do{
                try Realm.performMigration(for: realmnewConfiguration)
                realm = try Realm(configuration: realmnewConfiguration)
                print("Migrated objects : \(String(describing: realm?.objects(Contacts.self)))")
            }catch{
                print(error.localizedDescription)
            }
        }

        return true
    }
    func bundleURL(_ name: String) -> URL? {
        let url = Bundle.main.url(forResource: name, withExtension: "realm")
        return url
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

