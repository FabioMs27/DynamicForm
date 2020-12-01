//
//  FormViewController.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 30/11/20.
//

import UIKit

class FormViewController: UIViewController {
    
    var formView: FormView!{
        willSet { view = newValue }
    }
    var formViewModel: FormViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)

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
