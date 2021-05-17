//
//  FormDataSource.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 24/03/21.
//

import UIKit

class FormDataSource: NSObject {
    var fields = [Fields]()
    private let numberDelegate = NumberTextFieldDelegate()
    private let returnDelegate = ReturnTextFieldDelegate()
}

extension FormDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FormCollectionViewCell else {
            fatalError("Cell not registered!")
        }
        let field = fields[indexPath.item]
        cell.hintLabel.text = "hint: \(field.hintText)"
        cell.inputTextField.attributedPlaceholder = field.placeholder.atributedString
        cell.regex = field.regex
        cell.isMandatory = field.isMandatory
        if field.dataType == .int {
            cell.inputTextField.delegate = numberDelegate
            cell.inputTextField.keyboardType = .decimalPad
        } else {
            cell.inputTextField.delegate = returnDelegate
        }
        if field.type == .dropdown {
            cell.values = field.values
            cell.inputTextField.inputView = cell.optionPickerView
        }
        return cell
    }
}
