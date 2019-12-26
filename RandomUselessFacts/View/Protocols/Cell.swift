//
//  Cell.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit

protocol Cell: class {
    /// A default reuse identifier for the cell class
    static var defaultReuseIdentifier: String { get }
}

extension Cell {
    static var defaultReuseIdentifier: String {
        // Should return the class's name, without namespacing or mangling.
        return "\(self)"
    }
}
