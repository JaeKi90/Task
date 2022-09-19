//
//  String+Extention.swift
//  Task
//
//  Created by trost.jk on 2022/09/16.
//

import Foundation

extension String {
    var removedEscapeCharacters: String {
        /// remove: \"
        let removedEscapeWithQuotationMark = self.replacingOccurrences(of: "\\\"", with: "")
        /// remove: \
        let removedEscape = removedEscapeWithQuotationMark.replacingOccurrences(of: "\\", with: "")
        return removedEscape
    }
}
