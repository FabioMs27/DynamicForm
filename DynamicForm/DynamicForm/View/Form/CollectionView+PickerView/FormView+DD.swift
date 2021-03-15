//
//  FormCollectionView+DD.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

//MARK:- UICollectionViewDelegate
extension FormView: UICollectionViewDelegate { }
//MARK:- UICollectionViewDataSource
extension FormView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FormCollectionViewCell else {
            fatalError("Cell wasn't registered!")
        }
        let field = fields[indexPath.item]
        cell.hintLabel.text = "hint: \(field.hintText)"
        cell.inputTextField.attributedPlaceholder = field.placeholder.atributedString
        cell.regex = field.regex
        if field.dataType == .int {
            cell.inputTextField.delegate = self
        }
        cell.isMandatory = field.isMandatory
        if field.type == .dropdown {
            cell.values = field.values
            cell.inputTextField.inputView = cell.optionPickerView
        }
        return cell
    }
}
//MARK:- UITextFieldDelegate
extension FormView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
