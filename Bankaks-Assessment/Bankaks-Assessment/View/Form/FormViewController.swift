//
//  FormViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

class FormViewController: UIViewController {
    
    let formView: FormView
    let formViewModel: FormViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(formView: FormView, viewModel: FormViewModel) {
        self.formView = formView
        self.formViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view = formView
        formView.submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        fetchForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
        var isValid = true
        for cell in formView.collectionView.visibleCells{
            guard let cell =  cell as? FormCollectionViewCell else { return }
            do {
                try formViewModel.isMandatoryValidator(value: cell.inputTextField.text, pattern: cell.regex, isMandatory: cell.isMandatory)
                cell.isMandatoryLabel.textColor = .clear
            } catch {
                UIView.animate(withDuration: 0.25) {
                    cell.isMandatoryLabel.text = error.localizedDescription
                    cell.isMandatoryLabel.alpha = 1
                }
                cell.inputTextField.shakeAnimation()
                isValid = false
            }
        }
        if isValid {
            UIView.animate(withDuration: 1) {
                sender.backgroundColor = .green
                sender.setImage(.checkmark, for: .normal)
            }
        }
        else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
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
