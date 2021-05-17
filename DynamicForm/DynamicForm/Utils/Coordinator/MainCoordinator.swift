//
//  AppCoordinator.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

/// Class related to the main flow off the app.
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.isNavigationBarHidden = false
    }
    /// Starts the view flow of the app. It adds a ViewController to a navigationController.
    func start() {
        let view = ServiceOptionView()
        let viewModel = ServiceOptionViewModel()
        let viewController = ServiceOptionViewController(view: view, viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
}
//MARK: - ServiceOptionViewControllerCoordinator
extension MainCoordinator: ServiceOptionViewControllerCoordinator{
    /// Method used to navigates to the form view.
    /// - Parameter option: The service option in which that app will make a request to.
    func navigateToFormViewController(option: Int) {
        let view = FormView()
        let viewModel = FormViewModel(option: option)
        let dataSource = FormDataSource()
        let viewController = FormViewController(
            formView: view,
            viewModel: viewModel,
            dataSource: dataSource
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
