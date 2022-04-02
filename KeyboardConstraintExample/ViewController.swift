//
//  ViewController.swift
//  KeyboardConstraintExample
//
//  Created by cleanmac-ada on 02/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var exampleTf: UITextField!
    private var exampleLbl: UILabel!
    private var exampleView: UIView!
    private var exampleTfBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        exampleView = UIView()
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        exampleView.backgroundColor = .red
        exampleView.layer.cornerRadius = 8
        view.addSubview(exampleView)
        NSLayoutConstraint.activate([
            exampleView.heightAnchor.constraint(equalToConstant: 50),
            exampleView.widthAnchor.constraint(equalToConstant: 50),
            exampleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exampleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        exampleTf = UITextField()
        exampleTf.translatesAutoresizingMaskIntoConstraints = false
        exampleTf.placeholder = "Write something..."
        exampleTf.borderStyle = .roundedRect
        exampleTf.delegate = self
        view.addSubview(exampleTf)
        
        exampleTfBottomConstraint = exampleTf.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        NSLayoutConstraint.activate([
            exampleTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exampleTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exampleTfBottomConstraint,
            exampleTf.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        exampleLbl = UILabel()
        exampleLbl.translatesAutoresizingMaskIntoConstraints = false
        exampleLbl.text = "Will this UILabel follow the UITextField on the bottom?"
        view.addSubview(exampleLbl)
        NSLayoutConstraint.activate([
            exampleLbl.topAnchor.constraint(equalTo: exampleView.bottomAnchor, constant: -16),
            exampleLbl.bottomAnchor.constraint(equalTo: exampleTf.topAnchor, constant: -16),
            exampleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exampleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            exampleTfBottomConstraint.constant = -(keyboardSize.height)
            view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        exampleTfBottomConstraint.constant = -16
        view.layoutIfNeeded()
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

