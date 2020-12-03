//
//  Coordinator.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
