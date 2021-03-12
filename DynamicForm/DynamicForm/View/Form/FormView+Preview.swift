//
//  FormView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit
import SwiftUI

final class FormView: UIView {
    //MARK:- Atributtes
    var result: Results? {
        willSet{
            collectionView.reloadData()
            headerLabel.text = newValue?.screen_title
        }
    }
    
    var fields: [Field] {
        result?.fields ?? []
    }
    
    //MARK:- Interface
    lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4))
        view.backgroundColor = #colorLiteral(red: 0.4824108481, green: 0.7250191569, blue: 0.2658652067, alpha: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.04288191348, green: 0.476744771, blue: 0.2427864671, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Metrics.Device.width, height: Metrics.Device.height * 0.12)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FormCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
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
    //MARK:- Constructor
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK:- View Code
extension FormView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(
            headerLabel,
            anchors: [.centerX(0), .centerY(0)]
        )
        addSubview(
            collectionView,
            anchors: [.top(backgroundView.frame.height), .leading(layoutMargins.left), .trailing(-layoutMargins.right)]
        )
        addSubview(
            submitButton,
            anchors: [.centerX(0), .leading(20 + layoutMargins.left), .trailing(-20 - layoutMargins.right)]
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16)
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
            return FormViewController(
                formView: FormView(),
                viewModel: FormViewModel(option: 1)
            )
        }
    }
}
