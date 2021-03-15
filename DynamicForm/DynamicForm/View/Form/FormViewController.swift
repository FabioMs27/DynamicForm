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
    
    /// Method called when submit button is pressed. It validates all fields and update accordingly.
    /// - Parameter sender: The button that was pressed.
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
            showOkAlert(title: "You have completed the Assessment")
        }
        else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    /// Method that fetchs from api and uptade view accordingly. It sets up a loading screen while fetching data.
    func fetchForm() {
        hideActivityIndicator()
        showActivityIndicator()
        formViewModel.fetchForm() { [weak self] result in
            switch result {
            case .success(let form):
                DispatchQueue.main.async {
                    self?.formView.form = form
                }
            case .failure(let error):
                self?.showAlert(title: error.localizedDescription)
            }
            self?.hideActivityIndicator()
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
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    /// Method that presents an alert. It has an ok option to continue the app.
    /// - Parameter title: A string to be presented on the alert view.
    func showOkAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
