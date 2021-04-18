//
//  SceneDelegate.swift
//  CatalogoSnippets
//
//  Created by Jemesson Lima on 18/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }

        guard
            
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.viewControllers.first as? MasterTableViewController,
            let detailNavViewController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = detailNavViewController.viewControllers.first as? DetailViewController
            
        else { fatalError() }
        
        let firstSnippet = masterViewController.snippets.first
            detailViewController.snippet = firstSnippet
            masterViewController.delegate = detailViewController
    }
}
