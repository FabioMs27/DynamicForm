//
//  AppCoordinator.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ServiceOptionViewModel()
        let viewController = ServiceOptionViewController()
        viewController.serviceOptionViewModel = viewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

extension MainCoordinator: ServiceOptionViewControllerCoodinator{
    func navigateToFormViewController() {
        let viewModel = FormViewModel()
        let viewController = FormViewController()
        viewController.formViewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
