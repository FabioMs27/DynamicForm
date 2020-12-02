//
//  FormViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

class FormViewController: UIViewController {
    
    var formView: FormView!
    var formViewModel: FormViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(formView: FormView, viewModel: FormViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.formView = formView
        self.view = formView
        formViewModel = viewModel
        fetchForm()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fetchForm(){
        hideActivityIndicator()
        showActivityIndicator()
        formViewModel.fetchForm(){ [weak self] result in
            switch result{
            case .success(let form):
                DispatchQueue.main.async {
                    self?.formView.result = form.result
                }
            case .failure(let error):
                print(error)
            }
            self?.hideActivityIndicator()
        }
    }
}
