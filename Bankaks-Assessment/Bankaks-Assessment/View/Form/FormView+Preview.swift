//
//  FormView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit
import SwiftUI

final class FormView: UIView {
    
    var result: Results? {
        willSet{ collectionView.reloadData() }
    }
    
    var fields: [Field] {
        result?.fields ?? []
    }
    
    var screen: CGSize {
        UIScreen.main.bounds.size
    }
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4))
        view.backgroundColor = #colorLiteral(red: 0.4824108481, green: 0.7250191569, blue: 0.2658652067, alpha: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var collectionView: FormCollectionView = { [weak self] in
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screen.width, height: screen.height * 0.12)
        layout.headerReferenceSize = CGSize(width: screen.width, height: 120)
        let collectionView = FormCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FormCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(FormCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FormView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(backgroundView)
        addSubview(collectionView)
        addSubview(submitButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -32),
            collectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16),
            submitButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

//MARK: - Preview
struct FormViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return FormViewController(formView: FormView(), viewModel: FormViewModel(option: 1))
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
