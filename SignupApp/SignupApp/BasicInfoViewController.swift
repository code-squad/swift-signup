//
//  ViewController.swift
//  SignupApp
//
//  Created by Song on 2021/03/29.
//

import UIKit

class BasicInfoViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var idMessageLabel: UILabel!
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var passwordConfirmMessageLabel: UILabel!
    @IBOutlet weak var nameMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var userIDs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        nameTextField.delegate = self
        
        performRequest(with: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")
        
        idMessageLabel.text = ""
        passwordTextField.text = ""
        passwordConfirmTextField.text = ""
        nameTextField.text = ""
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else { return }
            guard let ids = self.parseJSON(data) else { return }
            self.userIDs = ids
        }
        task.resume()
    }
    
    func parseJSON(_ userData: Data) -> [String]? {
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: userData) as? [String] else {
                print("Error: Cannot convert data to JSON object")
                return nil
            }
            return jsonObject
        } catch {
            print("Error: Trying to convert JSON data to string")
            return nil
        }
    }
}

extension BasicInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let id = idTextField.text else { return }
        if userIDs.contains(id) {
            idMessageLabel.text = "이미 사용중인 아이디입니다."
            idMessageLabel.textColor = UIColor(named: "redErrorMessage")
        } else {
            let idRegex = "[a-z0-9_-]{5,20}"
            let idValidation = id.validate(with: idRegex)
            if idValidation {
                idMessageLabel.text = "사용 가능한 아이디입니다."
                idMessageLabel.textColor = UIColor(named: "greenText")
            } else {
                idMessageLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
                idMessageLabel.textColor = UIColor(named: "redErrorMessage")
            }
        }
    }
}
