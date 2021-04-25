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
            let uiSplitViewController = window?.rootViewController as? UISplitViewController,
            let uiNavController = uiSplitViewController.viewControllers.first as? UINavigationController,
            let tagsViewController = uiNavController.viewControllers.first as? TagsViewController,
            let uiSecondSplitViewController = uiSplitViewController.viewControllers.last as? UISplitViewController,
            let middleNavController = uiSecondSplitViewController.viewControllers.first as? UINavigationController,
            let masterTableViewController = middleNavController.viewControllers.first as? MasterTableViewController,
            let detailViewController = uiSecondSplitViewController.viewControllers.last as? DetailViewController
        else { fatalError() }

        detailViewController.snippet = masterTableViewController.snippets.first
        masterTableViewController.delegate = detailViewController
        tagsViewController.delegate = masterTableViewController
    }
}
