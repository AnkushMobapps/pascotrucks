//
//  SceneDelegate.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /*
     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         var navigationController: UINavigationController? = (self.window?.rootViewController as? UINavigationController)
         guard let windowScene = (scene as? UIWindowScene) else { return }
         
         /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
         let window = UIWindow(windowScene: windowScene)
         
         /// 3. Create a view hierarchy programmatically
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let welcome = storyBoard.instantiateViewController(withIdentifier: "WelcomeNavigation") as! WelcomeNavigation
         let customerHome = storyBoard.instantiateViewController(withIdentifier: "CustomerHomeNavigation") as! CustomerHomeNavigation
         let hostHome = storyBoard.instantiateViewController(withIdentifier: "HostHomeNavigation") as! HostHomeNavigation
         
         print(UserDefaults.standard.string(forKey: "user_id") ?? "")
         
         if UserDefaults.standard.string(forKey: "user_id") != nil && UserDefaults.standard.integer(forKey: "user_id") != 0
         {
             if UserDefaults.standard.integer(forKey: "host_type") == 0{
                 window.rootViewController = customerHome
             }
             else if UserDefaults.standard.integer(forKey: "host_type") == 1{
                 window.rootViewController = hostHome
             }
         }
         else
         {
             window.rootViewController = welcome
         }
         /// 5. Set the window and call makeKeyAndVisible()
         self.window = window
         window.makeKeyAndVisible()
     }
     */
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        var navigationController: UINavigationController? = (self.window?.rootViewController as? UINavigationController)
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
//        let window = UIWindow(windowScene: windowScene)
//        
//        /// 3. Create a view hierarchy programmatically
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let welcome = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//        let driverTabbar = storyBoard.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
//       
//        
//        print(UserDefaults.standard.string(forKey: "user_id") ?? "")
//        
//        if UserDefaults.standard.string(forKey: "user_id") != nil && UserDefaults.standard.integer(forKey: "user_id") != 0
//        {
//            window.rootViewController = driverTabbar
//        }
//        else
//        {
//            window.rootViewController = welcome
//        }
//        /// 5. Set the window and call makeKeyAndVisible()
//        self.window = window
//        window.makeKeyAndVisible()

        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

