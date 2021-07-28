//
//  ProgressRingExample.swift
//  CircleProgressBar
//
//  Created by Yejin Lee on 2021/07/27.
//

import Foundation
import UICircularProgressRing
import SwiftUI

struct ProgressRingExample: View {
    @State var progress = RingProgress.percent(0.44)

    var body: some View {
        VStack {
            ProgressRing(
                progress: $progress,
                axis: .top,
                clockwise: true,
                outerRingStyle: .init(
                    color: .color(.gray),
                    strokeStyle: .init(lineWidth: 20)
                ),
                innerRingStyle: .init(
                    color: .color(.green),
                    strokeStyle: .init(lineWidth: 10),
                    padding: 5
                )
            )
                .animation(.easeInOut(duration: 5))
                .padding(32)
        }
    }
}
