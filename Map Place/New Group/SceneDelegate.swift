import FirebaseAuth

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        if Auth.auth().currentUser  == nil{
            let view = Builder().setAuthViewController()
            let navigationView = UINavigationController(rootViewController: view)
            window?.rootViewController = navigationView
            window?.makeKeyAndVisible()
        }else{
            let view = Builder().setMainViewController()
            let navigationView = UINavigationController(rootViewController: view)
            window?.rootViewController = navigationView
            window?.makeKeyAndVisible()
        }
       
    }

  
}

