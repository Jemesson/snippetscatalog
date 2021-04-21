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
            let firstMasterNavController = splitViewController.viewControllers.first as? UINavigationController,
            let tagsViewController = firstMasterNavController.viewControllers.first as? TagsViewController,
            let secondSplitViewController = splitViewController.viewControllers.last as? UISplitViewController,
            let middleNavController = secondSplitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = middleNavController.viewControllers.first as? MasterTableViewController,
            let detailViewController = secondSplitViewController.viewControllers.last as? DetailViewController
        else { fatalError() }
        
        let firstSnippet = masterViewController.snippets.first
        detailViewController.snippet = firstSnippet
        masterViewController.delegate = detailViewController
        tagsViewController.delegate = masterViewController
    }
}
