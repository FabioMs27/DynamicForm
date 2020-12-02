//
//  FormCollectionReusableView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

class FormCollectionReusableView: UICollectionReusableView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.5019147992, green: 0.5019902587, blue: 0.5018982291, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FormCollectionReusableView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(headerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
