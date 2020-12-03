//
//  ServiceOptionViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

/// Protocol for the view flow from the second screen.
protocol ServiceOptionViewControllerCoordinator: class{
    func navigateToFormViewController(option: Int)
}
/// Class containing the service option Interface
class ServiceOptionViewController: UIViewController {
    //MARK:- Atributtes
    var serviceOptionView: ServiceOptionView!{
        willSet{ view = newValue }
    }
    var serviceOptionViewModel: ServiceOptionViewModel!
    var coordinator: ServiceOptionViewControllerCoordinator?
    //MARK:- Constructors
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
    //MARK:- Methods
    /// Method called when button is pressed. It validas the textFields and either presents an error or goes to next screen.
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
