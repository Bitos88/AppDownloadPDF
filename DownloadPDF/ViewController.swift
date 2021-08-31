//
//  ViewController.swift
//  DownloadPDF
//
//  Created by Alberto Alegre Bravo on 30/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func pressedButton(_ sender: UIButton) {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.keepcoding.concurrency")
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        
        guard let url = URL(string: "https://manuals.info.apple.com/MANUALS/1000/MA1565/en_US/iphone_user_guide.pdf") else {
            return
        }
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func showAlertController() {
        
        let alertController = UIAlertController(title: "Succes", message: "Your file has been downloaded", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController : URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        progressBar.setProgress(0.0, animated: true)
        
        showAlertController()
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressBar.setProgress(progress, animated: true)
    }
}

