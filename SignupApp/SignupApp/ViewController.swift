//
//  ViewController.swift
//  SignupApp
//
//  Created by Issac on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var IDField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var checkPasswordField: CustomTextField!
    @IBOutlet weak var nameField: CustomTextField!
    
    @IBOutlet weak var IDMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var checkPasswordMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
     
    @IBOutlet var textFields: [CustomTextField]!
    @IBOutlet var messageLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.forEach { (textField) in
            textField.delegate = self
        }
        let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")!
        receiveIDList(url: url) { (IDs) in
            print(IDs)
        }
    }
    
    private func receiveIDList(url: URL, callback: @escaping ([String]) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var IDList = Array<String>()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { return }
            do {
                IDList = try JSONDecoder().decode([String].self, from: data)
            } catch {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                callback(IDList)
            }
        }
        task.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
