//
//  String.swift
//  DynamicForm
//
//  Created by Fábio Maciel de Sousa on 15/03/21.
//

import UIKit

extension String {
    var atributedString: NSAttributedString {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(
            string: self,
            attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle]
        )
        return attributedPlaceholder
    }
}
