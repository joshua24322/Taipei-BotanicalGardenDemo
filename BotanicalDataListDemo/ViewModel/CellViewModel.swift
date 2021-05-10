//
//  CellViewModel.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/10.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation

struct CellViewModel {
    var fNameCh, fLocation, fFeature, fPic01URL: String?
    init(_ name: String?, _ location: String?, _ feature: String?, _ picURL: String?) {
        self.fNameCh = name
        self.fLocation = location
        self.fFeature = feature
        self.fPic01URL = picURL
    }
}
