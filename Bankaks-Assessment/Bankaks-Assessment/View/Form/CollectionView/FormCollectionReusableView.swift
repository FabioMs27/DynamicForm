//
//  FormCollectionReusableView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

class FormCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FormCollectionReusableView: ViewCodable{
    func setupHierarchyViews() {}
    
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {}
}
