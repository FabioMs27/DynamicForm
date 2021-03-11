//
//  ServiceOptionViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

protocol ServiceOptionViewControllerCoodinator: class{
    func navigateToFormViewController(option: Int)
}

class ServiceOptionViewController: UIViewController {
    
    let serviceOptionView: ServiceOptionView
    let serviceOptionViewModel: ServiceOptionViewModel
    var coordinator: ServiceOptionViewControllerCoodinator?
    
    init(view: ServiceOptionView, viewModel: ServiceOptionViewModel) {
        self.serviceOptionView = view
        self.serviceOptionViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view  = view
        serviceOptionView.proccedButton.addTarget(self, action: #selector(goToFormView), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func goToFormView(){
        do{
            let value = serviceOptionView.optionTextField.text
            let option = try serviceOptionViewModel.inputValidator(value: value)
            coordinator?.navigateToFormViewController(option: option)
            serviceOptionView.errorLabel.alpha = 0
        }catch{
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
