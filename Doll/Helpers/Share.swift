//
//  Share.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import UIKit

func share(items: [Any]) {
    let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}
