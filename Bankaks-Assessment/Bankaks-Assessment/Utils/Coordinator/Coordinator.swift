//
//  Coordinator.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

/// A protocol containing methods related to the view flow of the app
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
