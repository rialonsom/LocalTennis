//
//  LocalTennisWidgetBundle.swift
//  LocalTennisWidget
//
//  Created by Rodrigo Alonso on 25-05-24.
//

import WidgetKit
import SwiftUI

@main
struct LocalTennisWidgetBundle: WidgetBundle {
    var body: some Widget {
        LocalTennisWidget()
        LocalTennisWidgetLiveActivity()
    }
}
