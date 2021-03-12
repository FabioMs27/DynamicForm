//
//  Metrics.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 03/12/20.
//

import UIKit
/// Metrics used throughout the app
enum Metrics {
    ///Device metrics
    enum Device {
        static var width: CGFloat{
            UIScreen.main.bounds.size.width
        }
        static var height: CGFloat{
            UIScreen.main.bounds.size.height
        }
    }
}
