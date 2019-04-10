//
//  RootViewController.swift
//  WikipediaFlightScraper
//
//  Created by Jacob Hausmann on 4/10/19.
//  Copyright © 2019 Jacob Hausmann. All rights reserved.
//

import Cocoa
import MapKit
import Foundation
import SwiftSoup

class RootViewController: NSViewController {
    let startUrl = URL(string: "https://en.wikipedia.org/wiki/Wikipedia:WikiProject_Aviation/Airline_destination_lists:_North_America")!




    override func viewDidLoad() {
        super.viewDidLoad()
        visitPage()
        // Do any additional setup after loading the view.
    }

    func visitPage() {
        print("Visit page")
        do {
            let html = try String(contentsOf: startUrl, encoding: String.Encoding.utf8)
            let regex = try! NSRegularExpression(pattern:"<li><a href=\"/wiki/[a-zA-Z_,%0-9\\.]*\" (?:class=\"[a-zA-Z-]\" )?title=\"[a-zA-Z, &#;0-9\\.]*\">[a-zA-Z, \\.']*</a> \\(<a href=\"/wiki/[a-zA-Z_,\\.]*\" title=\"[a-zA-Z,\\. ]*\">[a-zA-Z,\\. ]*</a>\\)</li>")

            let range = NSRange(location: 0, length: html.count)
            let matches = regex.matches(in: html, options: [], range: range)

            for (index, match) in matches.enumerated() {
                let matchRange = Range(match.range)
                let startIndex = html.index(html.startIndex, offsetBy: (matchRange?.lowerBound)!)
                let endIndex = html.index(html.startIndex, offsetBy: (matchRange?.upperBound)!)
                print(html[startIndex..<endIndex])
            }

        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

