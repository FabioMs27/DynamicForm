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
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let view = ServiceOptionView()
        let viewModel = ServiceOptionViewModel()
        let viewController = ServiceOptionViewController(view: view, viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

extension MainCoordinator: ServiceOptionViewControllerCoodinator{
    func navigateToFormViewController(option: Int) {
        let view = FormView()
        let viewModel = FormViewModel(option: option)
        let viewController = FormViewController(formView: view, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
