//
//  ViewController.swift
//  Web
//
//  Created by 진형진 on 2021/03/19.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - Parmeters
    var urlStr: String = "https://www.naver.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlField.delegate = self
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.load(urlStr)
        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
          backButton.isEnabled = webView.canGoBack
          forwardButton.isEnabled = webView.canGoForward
        } else if keyPath == "estimatedProgress" {
          progressBar.isHidden = webView.estimatedProgress == 1
          progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }
      }
    
    // MARK: - IBActions
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func forward(_ sender: Any) {
        webView.goForward()
    }
    @IBAction func reload(_ sender: Any) {
        webView.reload()
    }

}



extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlField.text = webView.url?.absoluteString
        progressBar.setProgress(0.0, animated: false)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlField.resignFirstResponder()
        if let str = textField.text {
             urlStr = "https://" + str
             webView.load(urlStr)
        }
        return false
    }
}

// MARK: - WKWebView Extension

extension WKWebView {
  func load(_ urlString: String) {
    
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      load(request)
    }
  }
}

