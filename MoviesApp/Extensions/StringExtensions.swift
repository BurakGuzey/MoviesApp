//
//  StringExtensions.swift
//  MoviesApp
//
//  Created by Burak Güzey on 23.09.2022.
//

import Foundation

extension String {
    
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    
    }
}
