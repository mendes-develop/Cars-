//
//  CarViewController.swift
//  Carangas
//
//  Created by Alex Mendes on 05/24/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit
import WebKit

class CarViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    //MARK: - Properties
    var car: Car!

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.title = self.car.brand
            self.lbBrand.text = self.car.name
            self.lbGasType.text = self.car.gas
            self.lbPrice.text = "U$ \(self.car.price)"
            
            let name = (self.car.name + "+" + self.car.brand).replacingOccurrences(of: "", with: "+")
            let urlString = "https://www.google.com/search?q=\(name)&tbm=isch"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            self.webView.allowsBackForwardNavigationGestures = true
            self.webView.allowsLinkPreview = true
            self.webView.navigationDelegate = self
            self.webView.uiDelegate = self
            self.webView.load(request)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let vc = segue.destination as! AddEditViewController
            vc.car = car
        }
    }


}

extension CarViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
    
}
