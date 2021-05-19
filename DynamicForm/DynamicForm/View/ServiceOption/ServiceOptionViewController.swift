//
//  ServiceOptionViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

/// Protocol for the view flow from the second screen.
protocol ServiceOptionViewControllerCoordinator: class {
    func navigateToFormViewController(option: Int)
}
/// Class containing the service option Interface
class ServiceOptionViewController: UIViewController {
    
    private let serviceOptionView: ServiceOptionView
    private let serviceOptionViewModel: ServiceOptionViewModel
    weak var coordinator: ServiceOptionViewControllerCoordinator?
    
    init(view: ServiceOptionView, viewModel: ServiceOptionViewModel) {
        self.serviceOptionView = view
        self.serviceOptionViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = serviceOptionView
    }
    
    private func setup() {
        serviceOptionView.proccedButton.addAction(
            UIAction { [goToFormView] _ in
                goToFormView()
            },
            for: .touchUpInside)
        hideKeyboardWhenTappedAround()
    }
    
    /// Method called when button is pressed. It validas the textFields and either presents an error or goes to next screen.
    func goToFormView() {
        do {
            let value = serviceOptionView.optionTextField.text
            let option = try serviceOptionViewModel.inputValidator(value: value)
            coordinator?.navigateToFormViewController(option: option)
            serviceOptionView.errorLabel.alpha = 0
        } catch {
            serviceOptionView.showInvalid(text: error.localizedDescription)
            giveInvalidFeedback()
        }
    }

}
