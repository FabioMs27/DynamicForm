//
//  ServiceOptionViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

protocol ServiceOptionViewControllerCoodinator: class{
    func navigateToFormViewController()
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
        coordinator?.navigateToFormViewController()
    }

}
