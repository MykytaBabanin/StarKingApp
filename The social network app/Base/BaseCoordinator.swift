//
//  BaseCoordinator.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: Router { get set }
    
    func start()
}

class BaseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: Router
    
    init(navigationController: Router) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainScreenViewModel { [weak self] action in
            switch action {
            case .pushToSignUp:
                self?.moveToSignUp()
            case .pushToSignIn:
                self?.moveToMoviesList()
            case .pushToMoviePage:
                self?.moveToMoviesList()
            case .handleError(_):
                break
            }
        }
        let vc = MainScreenViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc)
    }
    
    func moveToSignUp() {
        let serviceLayer = BaseServiceLayer()
        let model = SignUpEntry(serviceLayer: serviceLayer)
        let viewModel = SignUpViewModel(model: model) { [unowned self] action in
            switch action {
            case .popToMain:
                self.navigationController.popToRootViewController()
            }
        }
        let viewController = SignUpViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController)
    }
    
    func moveToMoviesList() {
        let movieView = MovieAppView()
        let hostingController = UIHostingController(rootView: movieView)
        navigationController.pushViewController(hostingController)
    }
    
    func moveToSignIn() {
        let serviceLayer = BaseServiceLayer()
        let model = SignInEntry(serviceLayer: serviceLayer)
        let viewModel = SignInViewModel(model: model) { [weak self] action in
            switch action {
            case .pushToMoviePage:
                self?.moveToMoviesList()
            case .pushToSignUp:
                break
            case .pushToSignIn:
                break
            case .handleError(let alert):
                self?.navigationController.present(alert: alert)
            }
        }
        let viewController = SignInViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController)
    }
    
    func showMainViewControllerWithPush(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController)
    }
    
    func popToRootAndRemoveChilds(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}


class Router: NSObject {
    private(set) weak var rootController: UINavigationController?
    
    var isOnRootViewController: Bool {
        return rootController?.viewControllers.count == 1
    }
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        super.init()
        rootController.delegate = self
    }
    
    func pushViewController(_ viewController: UIViewController) {
        rootController?.pushViewController(viewController, animated: true)
    }
    
    func popToRootViewController(animated: Bool = true) {
        rootController?.popToRootViewController(animated: animated)
    }
    
    func setRootViewController(_ rootViewController: UIViewController?) {
        guard let root = rootViewController else {
            rootController?.setViewControllers([], animated: true)
            return
        }
        
        rootController?.setViewControllers([root], animated: true)
    }
    
    func present(alert: UIAlertController) {
        rootController?.present(alert, animated: true)
    }
    
    func presentMediumPageSheet(_ rootViewController: UIViewController) {
        rootViewController.modalPresentationStyle = .pageSheet
        if let sheet = rootViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        rootController?.present(rootViewController, animated: true)
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVc = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromVc) else { return }
    }
}
