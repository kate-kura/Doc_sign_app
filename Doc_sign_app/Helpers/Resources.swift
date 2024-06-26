//
//  Resources.swift
//  Doc_sign_app
//
//  Created by Екатерина on 09.01.2024.
//

import UIKit

//MARK: Сonstant values enumeration
enum Resources {
    
    //MARK: Colors
    enum Colors {
        static var buttonActive = UIColor(hexString: "#3185FC")
        static var background = UIColor(hexString: "#FBFBFF")
        static var white = UIColor(hexString: "#FFFFFF")
        static var secondaryLabelColor = UIColor(hexString: "#687590")
        static var primaryLabelColor = UIColor(hexString: "#262626")
        static var redColor = UIColor(hexString: "#F45D2D")
        static var greenColor = UIColor(hexString: "#54DB7F")
    }
    
    //MARK: Strings
    enum Strings {
        static var enter = "Вход"
        static var registerPrimaryText = "Регистрация"
        static var registerPrimaryText2 = "Подтвердите адрес электронной почты"
        static var registerPrimaryText3 = "Введите ваше имя и фамилию"
        static var registerPrimaryText4 = "Придумайте пароль"
        static var forgotPasswordPrimaryText = "Введите адрес электронной почты"
        static var forgotPasswordPrimaryText3 = "Придумайте новый пароль"
        static var back = "Назад"
        static var step1 = "Шаг 1 из 3"
        static var step2 = "Шаг 2 из 3"
        static var step3 = "Шаг 3 из 3"
        static var secondaryText = "Ваш адрес электронной почты будет использован для входа в аккаунт"
        static var secondaryText2 = "На вашу электронную почту отправлено письмо с кодом"
        static var secondaryText3 = "Пароль должен быть не менее 8 символов и содержать заглавные буквы и цифры"
        static var secondaryText4 = "Здесь будут подписанные вами договоры"
        static var secondaryText5 = "Здесь будут подписанные вами договоры более трёх месяцев назад"
        
        static var email = "E-mail"
        static var password = "Пароль"
        static var code = "Код"
        static var next = "Далее"
        static var confirm = "Подтвердить"
        static var noAccount = "Нет аккаунта?"
        static var zaRegister = "Зарегистрироваться"
        static var forgotPassword = "Забыли пароль?"
        static var againPassword = "Повторите пароль"
        static var endRegistration = "Закончить регистрацию"
        static var recoverPassword = "Восстановить пароль"
        
        static var name = "Имя"
        static var surname = "Фамилия"
        static var profile = "Имя Фамилия"
        static var exampleMail = "example@gmail.com"
        
        static var search = "Поиск"
        
        static var scanQRcode = "Сканировать QR-код"
        static var archive = "Архив"
        static var profileLabel = "Профиль"
        static var myDataLabel = "Мои данные"
        static var editDataLabel = "Редактировать данные"
        static var save = "Сохранить"
        static var basic = "Основное"
        static var contacts = "Контакты"
        static var mail = "Почта"
        static var exitButton = "Выйти из аккаунта"
        
        static var qrText = "QR-код будет отсканирован автоматически, как только вы поместите его внутрь квадрата"
        static var document = "Договор"
        static var documentSigned = "Договор подписан!"
        static var done = "Готово"
        static var toSign = "Подписать"
        static var openDocument = "Открыть документ"
        static var openPDF = "Открыть PDF"
        static var fillForm = "Заполните поля для подписания"
        static var homeVCTitle = "Подписанные договоры"
        static var watch = "Просмотреть"
        static var export = "Экспорт в PDF"
    }
    
    //MARK: Images
    enum Images {
        static var logo = UIImage(named: "po_rukam_logo")
        static var arrowLeft = UIImage(systemName: "chevron.left")
        static var arrowRight = UIImage(systemName: "chevron.right")
        static var avatar = UIImage(systemName: "person.fill")
        static var plus = UIImage(systemName: "plus")
        static var equal = UIImage(systemName: "equal")
        static var qrcode = UIImage(systemName: "qrcode")
        static var doc = UIImage(systemName: "doc.text")
        static var archivebox = UIImage(systemName: "archivebox")
        static var camera = UIImage(systemName: "camera")
        static var eye = UIImage(systemName: "eye")
        static var eyeClosed = UIImage(systemName: "eye.slash")
        static var check = UIImage(systemName: "checkmark")
        static var ellipsis = UIImage(systemName: "ellipsis")
        static var share = UIImage(systemName: "square.and.arrow.up")
    }
    
    //MARK: Fonts
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        static func helveticaMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
    
    //MARK: URLs
    enum API {
        static let baseURL = "http://77.232.143.172:8080/api/v1"
        
        // Auth
        static let signInURL = baseURL + "/users/physical/auth/sign_in"
        
        static let registrationURL = baseURL + "/users/physical/auth/sign_up/init"
        static let confirmRegistrationURL = baseURL + "/users/physical/auth/sign_up/verify_code/"
        static let completeRegistrationURL = baseURL + "/users/physical/auth/sign_up/complete"
        
        static let refreshTokenURL = baseURL + "/users/physical/auth/refresh"
        
        static let changePasswordURL = baseURL + "/users/physical/auth/change_password/send_code"
        static let confirmChangePasswordURL = baseURL + "/users/physical/auth/change_password/verify_code/"
        static let setNewPasswordURL = baseURL + "/users/physical/auth/change_password/set_new_password"
        
        // Profile
        static let getUserProfileDetailsURL = baseURL + "/users/physical/profile/get_me"
        static let updateUserProfileDetailsURL = baseURL + "/users/physical/profile/update_me"
        
        // Contracts
        static let getListOfContractsURL = baseURL + "/contracts/get_list_for_user"
        static let getPDFContractURL = baseURL + "/contracts/get_contract_pdf_v2/"
        static let getContractContentURL = baseURL + "/contracts/get_contract_content/"
        
        // Forms
        static let getFormContentURL = baseURL + "/forms/get_form_content/"
        static let getPDFFormURL = baseURL + "/forms/get_form_pdf_v2/"
        static let getFormFieldsURL = baseURL + "/forms/get_form_fields/"
        static let fillFormFieldsURL = baseURL + "/forms/fill_form_fields"
    }
    
    //MARK: UserDefaults Keys
    enum Keys {
        static let keyCheckFirstLaunch = "appWasLaunchedBefore"
        static let keyCheckIfSignedIn = "userIsSignedIn"
        static let keyCurrentUserEmail = "currentUserEmail"
        static let keyCurrentUserAuthToken = "currentUserAuthToken"
        static let keyCurrentUserRefreshToken = "currentUserRefreshToken"
        static let keyTemporaryUserAuthToken = "temporaryUserAuthToken"
        static let keyCurrentUserFirstName = "currentUserFirstName"
        static let keyCurrentUserLastName = "currentUserLastName"
        static let keyCurrentUserProfileImage = "currentUserProfileImage"
        
        static let keyCurrentQRcodeID = "currentQRcodeID"
        static let keyCurrentQRdocCompany = "currentQRdocCompany"
        static let keyCurrentQRdocTitle = "currentQRdocTitle"
        static let keyCurrentFormFields = "currentFormFields"
        static let keyCurrentBackendFormFields = "currentBackendFormFields"
        static let keyCurrentFormID = "currentFormID"
        static let keyCurrentContractID = "currentContractID"
    }
}
