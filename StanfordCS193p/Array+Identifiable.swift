//
//  Array+Identifiable.swift
//  StanfordCS193p
//
//  Created by Kristoffer Dahl on 23/07/2020.
//  Copyright © 2020 Kristoffer Dahl. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil        // TODO: Bogus!
    }
}
