//
//  ViewCodable.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

/// Protocol containing view code related methods. This class is used for creating views programmatically.
protocol ViewCodable {
    func setupViews()
    func setupHierarchyViews()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    /// Method which calls all the other methods related to view code.
    func setupViews() {
        setupHierarchyViews()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    /// Optional adicional view code setups.
    func setupAdditionalConfiguration() {}
}
