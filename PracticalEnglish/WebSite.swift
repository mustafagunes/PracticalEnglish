//
//  WebSite.swift
//  PracticalEnglish
//
//  Created by Mustafa Gunes on 5.11.2022.
//

import Foundation

struct WebSiteContainer: Decodable {
  let data: [WebSiteEntity]
}

struct WebSiteEntity: Decodable {
  let name: String
  let url: URL
}
