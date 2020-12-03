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
        formView.submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        fetchForm()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func submitForm(sender: UIButton){
        for cell in formView.collectionView.visibleCells{
            guard let cell =  cell as? FormCollectionViewCell else { return }
            do {
                try formViewModel.isMandatoryValidator(value: cell.inputTextField.text, pattern: cell.regex, isMandatory: cell.isMandatory)
                sender.backgroundColor = .green
                formView.errorLabel.textColor = .clear
                cell.isMandatoryLabel.textColor = .clear
            } catch {
                cell.isMandatoryLabel.text = error.localizedDescription
                cell.isMandatoryLabel.textColor = .systemRed
//                formView.collectionView.showHints()
            }
        }
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
                self?.showAlert(title: error.localizedDescription)
            }
            self?.hideActivityIndicator()
        }
    }
    
    func showAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.fetchForm()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(tryAgainAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
