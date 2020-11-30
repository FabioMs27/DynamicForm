//
//  ViewCodable.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

protocol ViewCodable {
    func setupViews()
    func setupHierarchyViews()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupHierarchyViews()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
