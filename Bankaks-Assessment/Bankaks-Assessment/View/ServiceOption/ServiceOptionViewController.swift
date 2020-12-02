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
    
    var serviceOptionView: ServiceOptionView!{
        willSet{ view = newValue }
    }
    var serviceOptionViewModel: ServiceOptionViewModel!
    var coordinator: ServiceOptionViewControllerCoodinator?
    
    init(view: ServiceOptionView, viewModel: ServiceOptionViewModel) {
        super.init(nibName: nil, bundle: nil)
        serviceOptionView = view
        serviceOptionViewModel = viewModel
        serviceOptionView.proccedButton.addTarget(self, action: #selector(goToFormView), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func goToFormView(){
        do{
            let value = serviceOptionView.optionTextField.text
            let option = try serviceOptionViewModel.inputValidator(value: value)
            coordinator?.navigateToFormViewController(option: option)
            serviceOptionView.errorLabel.textColor = .clear
        }catch{
            serviceOptionView.errorLabel.text = error.localizedDescription
            serviceOptionView.errorLabel.textColor = .systemRed
        }
    }

}
