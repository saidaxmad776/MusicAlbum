//
//  SingUpViewController.swift
//  DarkMod
//
//  Created by Test on 08/04/22.
//

import UIKit

class SingUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgraundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameTexrField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second Name"
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("SingUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private var datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegate()
        setupDatePicker()
        setConstrents()
        registerKeyBorardNotification()
    }
    
    deinit {
        removeKeyboardNotivacation()
    }
    
    private func setupView() {
        title = "SingUp"
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgraundView)
        
        elementsStackView = UIStackView(arragedSubviews: [firstNameTextField,
                                                          firstNameValidLabel,
                                                          secondNameTexrField,
                                                          secondNameValidLabel,
                                                          datePicker,
                                                          ageValidLabel,
                                                          phoneNumberTextField,
                                                          phoneValidLabel,
                                                          emailTextField,
                                                          emailValidLabel,
                                                          passwordTextField,
                                                          passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        backgraundView.addSubview(elementsStackView)
        backgraundView.addSubview(loginLabel)
        backgraundView.addSubview(singUpButton)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTexrField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    @objc private func singUpButtonTapped() {
        
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTexrField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 16
            && ageIsValid() == true {
            
            DataBase.shared.saveUser(firstName: firstNameText,
                                     seconName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: datePicker.date)
            
            loginLabel.text = "Registration complete"
        } else {
            loginLabel.text = "Registration"
            alertOk(title: "Error", message: "Fill in all the filds and your age must")
        }
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 16 {
            phoneValidLabel.text = "Phone is valid"
            phoneValidLabel.textColor = .green
        } else {
            phoneValidLabel.text = "Phone is not valid"
            phoneValidLabel.textColor = .red
        }
            
        return result
    }
    
    private func ageIsValid() -> Bool {
        
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
}

extension SingUpViewController {
    
    private func registerKeyBorardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotivacation() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notifacation: Notification) {
        let userInfo = notifacation.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyBoardWillHide(notifacation: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}


extension SingUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters, min 1 charactesr",
                                              string: string,
                                              range: range)
        case secondNameTexrField: setTextField(textField: secondNameTexrField,
                                               label: secondNameValidLabel,
                                               validType: nameValidType,
                                               validMessage: "Name is valid",
                                               wrongMessage: "Only A-Z characters, min 1 charactesr",
                                               string: string,
                                               range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                          label: emailValidLabel,
                                          validType: emailValidType,
                                          validMessage: "Email is valid",
                                          wrongMessage: "Email is not valid",
                                          string: string,
                                          range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                             label: passwordValidLabel,
                                             validType: passwordValidType,
                                             validMessage: "Password is valid",
                                             wrongMessage: "Password is not valid",
                                             string: string,
                                             range: range)
        case phoneNumberTextField: phoneNumberTextField.text = setPhoneNumberMask(textField: phoneNumberTextField,
                                                                                  mask: "+XXXXX XXX-XX-XX",
                                                                                  string: string,
                                                                                  range: range)
        default:
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTexrField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//        MARK: - Set Constreints

extension SingUpViewController {
    
    private func setConstrents() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgraundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgraundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgraundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgraundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgraundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgraundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgraundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgraundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgraundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            singUpButton.centerXAnchor.constraint(equalTo: backgraundView.centerXAnchor),
            singUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            singUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
