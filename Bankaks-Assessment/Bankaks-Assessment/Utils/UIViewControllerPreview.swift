//
//  UIViewControllerPreview.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 11/03/21.
//

import SwiftUI

@available(iOS 13, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    func makeUIViewController(context: Context) -> ViewController { viewController }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

//MARK: - Preview
struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let navigationController = UINavigationController()
            let coordinator = MainCoordinator(navigationController: navigationController)
            coordinator.start()
            
            return navigationController
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
