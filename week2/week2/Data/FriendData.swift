//
//  FriendData.swift
//  week2
//
//  Created by 김태형 on 2020/05/14.
//  Copyright © 2020 김태형. All rights reserved.
//

import Foundation

class  FriendData {
    var title: String? // Title for a row
    var content: [String]? // Content after row selection
    init (_ str: String?){ // Takes row title in initialisation
        title = str
    }
}
