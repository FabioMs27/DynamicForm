//
//  DropDownDataSource.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 17/05/21.
//

import UIKit

class DropDownDataSource: NSObject {
    private(set) var values = [String]()
    
    func update(values: [String]) {
        self.values = values
    }
}

extension DropDownDataSource: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        values.count
    }
}
