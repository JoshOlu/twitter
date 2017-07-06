//
//  ComposeViewController.swift
//
//
//  Created by Josh Olumese on 7/5/17.
//
//

import UIKit



protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    
    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    

    @IBAction func postButton(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeTextView.text) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myColor: UIColor = UIColor.lightGray
        composeTextView!.layer.borderWidth = 1
        composeTextView!.layer.borderColor = myColor.cgColor
        
        composeTextView.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length + range.location > composeTextView.text.characters.count {
            
            return false
        }
        
        let newlength = composeTextView.text.characters.count + text.characters.count - range.length
        
        if newlength <= 140 {
            self.characterCount.text = "\(140 - newlength)"
            return true
        }
        
        return newlength <= 140
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
