//
//  ViewController.swift
//  plotlyios
//
//  Created by Van-Tien on 6/6/20.
//  Copyright © 2020 Van-Tien. All rights reserved.
//

import UIKit
import CSV
import Plotly
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        display(testMultiple3DSubplots())
    }

    func heatmap() -> Figure{
        let trace = Heatmap(
            z: [[1, nil, 30, 50, 1], [20, 1, 60, 80, 30], [30, 60, 1, -10, 20]],
            x: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
            y: ["Morning", "Afternoon", "Evening"],
            hoverOnGaps: false
        )
        let figure = Figure(data: [trace])
//        figure.config?.displayLogo = false
//        figure.config?.displayModeBar
        var conf = Config()
        conf.displayLogo = false
//        conf.displayModeBar.
//        figure.config = conf
        return figure
    }
    func display(_ figure:Figure){
        let html = try! HTML.create(from: figure, plotly: .online, mathJax: .online, document: true)
        webView.loadHTMLString(html, baseURL: nil)
    }

    func displayPlotonWebView() {
        let x = [1.0, 2.0, 3.0, 4.0]
        let y = [10.0, 15.0, 13.0, 17.0]
        let data: [Trace] = [
            Scatter(name: "Scatter", x: x, y: y),
            Bar(name: "Bar", x: x, y: y)
        ]

        let figure = Figure(data: data)

        let html = try! HTML.create(from: figure, plotly: .online, mathJax: .online, document: true)
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    func testMultiple3DSubplots() -> Figure {
        let trace1 = Mesh3D<[Double], [Double], [Double], [Int], [Int], [Int]>(
            x: (0...50).map { _ in Double.random(in: -75...0) },
            y: (0...50).map { _ in Double.random(in: 0...75) },
            z: (0...50).map { _ in Double.random(in: 0...75) },
            color: .RGB(255, 127, 80, 0.7),
            opacity: 0.5,
            scene: .init(
                domain: .init(
                    x: [0.0, 0.5],
                    y: [0.5, 1.0]
                )
            )
        )

        let trace2 = Mesh3D<[Double], [Double], [Double], [Int], [Int], [Int]>(
            x: (0...50).map { _ in Double.random(in: -75...0) },
            y: (0...50).map { _ in Double.random(in: 0...75) },
            z: (0...50).map { _ in Double.random(in: 0...75) },
            color: .pink,
            opacity: 0.5,
            scene: .init(
                domain: .init(
                    x: [0.5, 1.0],
                    y: [0.5, 1.0]
                )
            )
        )

        let trace3 = Mesh3D<[Double], [Double], [Double], [Int], [Int], [Int]>(
            x: (0...50).map { _ in Double.random(in: -75...0) },
            y: (0...50).map { _ in Double.random(in: -75...0) },
            z: (0...50).map { _ in Double.random(in: -75...0) },
            color: .RGB(33, 255, 100),
            opacity: 0.4,
            scene: .init(
                domain: .init(
                    x: [0.0, 0.33],
                    y: [0.0, 0.5]
                )
            )
        )

        let trace4 = Mesh3D<[Double], [Double], [Double], [Int], [Int], [Int]>(
            x: (0...50).map { _ in Double.random(in: -75...0) },
            y: (0...50).map { _ in Double.random(in: -75...0) },
            z: (0...50).map { _ in Double.random(in: -75...0) },
            color: .RGB(200, 100, 200),
            opacity: 0.5,
            scene: .init(
                domain: .init(
                    x: [0.33, 0.66],
                    y: [0.0, 0.5]
                )
            )
        )

        let trace5 = Mesh3D<[Double], [Double], [Double], [Int], [Int], [Int]>(
            x: (0...50).map { _ in Double.random(in: 0...100) },
            y: (0...50).map { _ in Double.random(in: 0...100) },
            z: (0...50).map { _ in Double.random(in: 0...100) },
            color: .RGB(0, 150, 200),
            opacity: 0.5,
            scene: .init(
                domain: .init(
                    x: [0.66, 0.99],
                    y: [0.0, 0.5]
                )
            )
        )

        let layout = Layout(
            height: 600,
            margin: .init(l: 0, r: 0, t: 0, b: 0, padding: 0)
        )

        let figure = Figure(data: [trace1, trace2, trace3, trace4, trace5], layout: layout)
        return figure
    }
}

