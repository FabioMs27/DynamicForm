//
//  FormView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 01/12/20.
//

import UIKit

class FormView: UIView{
    
    let values = [
        "Fabio",
        "Ivanka",
        "David"
    ]
    
    lazy var contentTableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FormView: UITableViewDelegate{}

extension FormView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = values[indexPath.row]
        return cell
    }
}

extension FormView: ViewCodable{
    func setupHierarchyViews() {
        addSubview(contentTableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: topAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
