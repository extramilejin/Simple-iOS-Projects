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
    var webViewObserverList: [NSKeyValueObservation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlField.delegate = self
        urlField.autocorrectionType = .no
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        webView.navigationDelegate = self
        
        addWKWebViewObserver()
        
//      webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
//      webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        
        webView.load(urlStr)
        
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "loading" {
//          backButton.isEnabled = webView.canGoBack
//          forwardButton.isEnabled = webView.canGoForward
//        } else
//        if keyPath == "estimatedProgress" {
//          progressBar.isHidden = webView.estimatedProgress == 1
//          progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
//        }
//      }
    
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
    
    // MARK: - Helper
    fileprivate func addWKWebViewObserver() {
        // closure는 self가 해제 될 때까지 기다리고 self는 closure가 해제될 때까지 기다리는 strong reference cycle 상황을 만들어 내게 된다. 이러한 상황을 해결하기 위해 사용하는 것이 [weak self] param in 이다.
        let loadingObserver = webView.observe(\.isLoading) { [weak self] (webView, _) in
            guard let strongSelf = self else { return }
            strongSelf.backButton.isEnabled = webView.canGoBack
            strongSelf.forwardButton.isEnabled = webView.canGoForward
        }
        
        let progressObserver = webView.observe(\.estimatedProgress) { [weak self] (webView, _) in
            guard let strongSelf = self else { return }
            strongSelf.progressBar.isHidden = webView.estimatedProgress == 1
            strongSelf.progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }
        webViewObserverList.append(loadingObserver)
        webViewObserverList.append(progressObserver)
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

