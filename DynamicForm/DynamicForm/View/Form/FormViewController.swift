//
//  FormViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit
/// Class containing the form Interface
class FormViewController: UIViewController {
    
    let formView: FormView
    let formViewModel: FormViewModel
    let dataSource: FormDataSource
    
    init(formView: FormView, viewModel: FormViewModel, dataSource: FormDataSource) {
        self.formView = formView
        self.formViewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        formView.submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        bindViewModel()
        fetchForm()
        hideKeyboardWhenTappedAround()
        formView.collectionView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = formView
    }
    
    /// Method called when submit button is pressed. It validates all fields and update accordingly.
    /// - Parameter sender: The button that was pressed.
    @objc func submitForm(sender: UIButton){
        var isValid = true
        for view in formView.collectionView.subviews {
            guard let cell = view as? FormCollectionViewCell else { return }
            do {
                if cell.isMandatory {
                    try formViewModel.validateInputs(
                        value: cell.inputTextField.text,
                        pattern: cell.regex
                    )
                }
                cell.isMandatoryLabel.textColor = .clear
            } catch {
                cell.showInvalid(text: error.localizedDescription)
                isValid = false
            }
        }
        isValid ? completeAssessment() : giveInvalidFeedback()
    }
    
    private func completeAssessment() {
        UIView.animate(withDuration: 1) { [unowned self] in
            formView.submitButton.backgroundColor = .green
            formView.submitButton.setImage(.checkmark, for: .normal)
        }
        showOkAlert(title: "You have completed the Assessment")
    }
    
    /// Method that fetchs from api and uptade view accordingly. It sets up a loading screen while fetching data.
    func fetchForm() {
        hideActivityIndicator()
        showActivityIndicator()
        formViewModel.fetchForm()
    }
    
    func bindViewModel() {
        formViewModel.errorPublisher.bind { [weak self] error in
            self?.hideActivityIndicator()
            self?.showAlert(title: error?.localizedDescription)
        }
        
        formViewModel.formPublisher.bind { [weak self] form in
            guard let self = self else { return }
            self.hideActivityIndicator()
            self.dataSource.fields = form?.fields ?? []
            self.formView.headerLabel.text = form?.screenTitle
            self.formView.collectionView.reloadData()
        }
    }
    
    /// Method that presents an alert. It has two options and goes back to the previous screen.
    /// - Parameter title: A string to be presented on the alert view.
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
        present(alert, animated: true)
    }
}
