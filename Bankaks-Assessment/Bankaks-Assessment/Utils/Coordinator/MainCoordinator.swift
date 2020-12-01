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
        let view = ServiceOptionView()
        let viewModel = ServiceOptionViewModel()
        let viewController = ServiceOptionViewController(view: view, viewModel: viewModel)
        viewController.serviceOptionViewModel = viewModel
        viewController.coordinator = self
        viewController.serviceOptionView = view
        navigationController.pushViewController(viewController, animated: false)
        navigateToFormViewController()
    }
    
}

extension MainCoordinator: ServiceOptionViewControllerCoodinator{
    func navigateToFormViewController() {
        let view = FormView()
        let viewModel = FormViewModel()
        let viewController = FormViewController()
        viewController.formView = view
        viewController.formViewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
