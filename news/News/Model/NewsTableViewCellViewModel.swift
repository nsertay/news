//
//  NewsTableViewCellViewModel.swift
//  News
//
//  Created by Нурмуханбет Сертай on 05.02.2023.
//

import Foundation

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subTitle: String, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
