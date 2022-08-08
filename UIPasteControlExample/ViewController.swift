//
//  ViewController.swift
//  UIPasteControlExample
//
//  Created by Kyle Lanchman on 8/8/22.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController {
    private let pasteControl = UIPasteControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        pasteControl.target = self
        pasteConfiguration = UIPasteConfiguration(acceptableTypeIdentifiers: [
            UTType.text.identifier,
            UTType.image.identifier,
        ])

        view.addSubview(pasteControl)
        pasteControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pasteControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pasteControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension ViewController {
    override func paste(itemProviders: [NSItemProvider]) {
        for provider in itemProviders {
            if provider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
                _ = provider.loadObject(ofClass: String.self) { str, error in
                    print(str as Any, error as Any)
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                _ = provider.loadObject(ofClass: UIImage.self) { img, error in
                    print(img as Any, error as Any)
                }
            }
        }
    }
}
