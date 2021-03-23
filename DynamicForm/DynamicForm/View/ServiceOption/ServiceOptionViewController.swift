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
    
    let serviceOptionView: ServiceOptionView
    let serviceOptionViewModel: ServiceOptionViewModel
    var coordinator: ServiceOptionViewControllerCoordinator?
    
    init(view: ServiceOptionView, viewModel: ServiceOptionViewModel) {
        self.serviceOptionView = view
        self.serviceOptionViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        serviceOptionView.proccedButton.addTarget(self, action: #selector(goToFormView), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = serviceOptionView
    }
    
    //MARK:- Methods
    /// Method called when button is pressed. It validas the textFields and either presents an error or goes to next screen.
    @objc func goToFormView() {
        do {
            let value = serviceOptionView.optionTextField.text
            let option = try serviceOptionViewModel.inputValidator(value: value)
            coordinator?.navigateToFormViewController(option: option)
            serviceOptionView.errorLabel.alpha = 0
        } catch {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.serviceOptionView.errorLabel.text = error.localizedDescription
                self?.serviceOptionView.errorLabel.alpha = 1
            }
            serviceOptionView.optionTextField.shakeAnimation()
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }

}
