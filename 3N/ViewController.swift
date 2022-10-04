//
//  ViewController.swift
//  3N
//
//  Created by Erkan Kızgın on 26.09.2022.
//

import UIKit

class ViewController: UIViewController {
    let button : UIButton = {
        let button1 = UIButton()
        button1.titleLabel?.text = "afasdfs"
        return button1
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configure() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

