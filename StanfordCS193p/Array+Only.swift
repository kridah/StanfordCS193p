//
//  Array+Only.swift
//  StanfordCS193p
//
//  Created by Kristoffer Dahl on 23/07/2020.
//  Copyright © 2020 Kristoffer Dahl. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
