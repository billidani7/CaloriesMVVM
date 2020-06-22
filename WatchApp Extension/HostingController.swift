//
//  HostingController.swift
//  WatchApp Extension
//
//  Created by Vasilis Daningelis on 19/6/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    override var body: ContentView {
        return ContentView(viewModel: ContentViewModel())
    }
}
