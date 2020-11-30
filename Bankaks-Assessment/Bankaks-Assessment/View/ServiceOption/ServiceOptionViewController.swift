//
//  ServiceOptionViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

protocol ServiceOptionViewControllerCoodinator: class{
    func navigateToFormViewController()
}

class ServiceOptionViewController: UIViewController {
    
    var serviceOptionViewModel: ServiceOptionViewModel!
    weak var coordinator: ServiceOptionViewControllerCoodinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
