//
//  String+.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

extension String {
    var unescaped: String {
        return self.replacingOccurrences(of: "\n", with: "")
    }
}
