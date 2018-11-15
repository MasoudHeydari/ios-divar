//
//  Const.swift
//  Test1
//
//  Created by Masoud Heydari on 10/22/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import Foundation
struct Const {
    
    static let empty = ""
    
    struct Image {
        static let favorite = "favorite"
        static let favoriteBorder = "favorite_border"
        static let userProfileBorder = "user_border"
        static let userProfileSolid = "user_solid"
        static let aboutDivar = "about_app"
        static let aboutUs = "about_us"
        static let share = "share"
        static let advertising = "advertising"
        static let plus = "plus1"
        static let addPhoto = "add_photo"
        static let tempImage = "temp_img"
        static let delete = "delete"
        static let refresh = "refresh"
    }
    
    struct PlaceHolder {
        static let phoneNumber = "شماره تماس شما"
        static let price = "قیمت (تومان)"
        static let advertisingTitle = "عنوان آگهی خود را بنویسید"
        static let advertisingDescription = "توضیحات آگهی خود را بنویسید"
        
        static let userName = "نام کاربری (ایمیل)"
        static let fullName = "نام و نام‌خانوادگی"
        static let password = "رمز عبور"
        
    }
    
    struct Pages {
        
        struct NewADPage {
            static let advertisingTitle = "عنوان آگهی"
            static let advertisingDescription = "توضیحات آگهی"
            static let advertisingLocation = "محل آگهی"
            static let advertisingImage = "عکس آگهی"
            static let phoneNumber = "شماره تماس"
            static let price = "قیمت"
            static let advertisingImageDescription =  "\n" + "افزودن عکس، بازدید آگهی شما را تا ۳ برابر افزیش می‌دهد" + "\n" + "حداکثر ۵ عکس انتخاب کنید."
            static let newAdvertisingDescription = "تمام جزییات و نکات قابل توجه آگهی خود را یه صورت کامل در اینجا ذکر کنید. توجه با این مورد به طور قابل توجهی ابهامات کاربران را برطرف خواهد کرد و شانس موفقیت آگهی شما را افزایش می‌دهد."
            
            struct ErrorLabel {
                static let phoneNumber = "شماره تلفن نامعتبر است!"
                static let description = "طول متن باید بیشتر از ۱۰ حرف باشد!"
            }
        }
        
        struct AllADPage {
            static let noInternetConnection = "خطا در اتصال به سرور"
            
        }
        
        struct ProfilePage {
            static let loginToAccount = "برای استفاده از تمامی امکانات دیوار، وارد حساب کاربری‌تان شوید."
            static let welcomeUser = "شما وارد حساب کاربری خود شده‌اید."
            static let myAdvertisings = "آگهی‌های من"
            static let favAdvertisings = "نشان شده‌ها"
            static let aboutDivar = "درباره دیوار   ۱.۰.۰"
            static let aboutUs = "درباره ما"
        }
        
        struct AdvertisingDetails {
            static let price = "قیمت: "
            static let location = "محل: "
            static let fakeLocation = "تهران جنت آباد مرکزی"
            static let fakeTime = "دقایقی پیش"
            static let fakeAdvertisingTitle = "فروش ویلای شمال (نقد - اقساط) یا معاوضه با آپارتمان برای مشاوره با کادر مجرب ما میتوانید با یکی از شماره یزر تماس بگیرید مشاور املاک حیدری"
            static let fakePrice = "۷۲۰۰۰۰۰۰۰ تومان"
            static let fakeAdvertisingDescription = "سیبانه یک استاندارد جدید برای استفاده از پیشرفته ترین اسمارت فون جهان تعریف کرده است. این استاندارد جدید باعث شده است که کاربران ایرانی توانایی بیشتری برای استفاده از محصولات اپل داشته باشند. سیبانه اپ استور اپل را بصورت هوشمندانه و براساس نیازهای کاربران ایرانی بازطراحی کرده و در قالب اپ استور ایرانی نرم افزارهای اورجینال iOS در اختیار کاربران ایرانی قرار داده است."
            
            static let youNotLoggedIn = "شما وارد حساب خود نشده‌اید!"
            
        }
        
        struct LoginAndRegister {
            static let alreadyRegistered = "قبلا ثبت نام کرده‌ام!"
            static let notRegister = "ثبت نام نکردی؟ ثبت نام کن!"
        }
        
        struct MyFavAdvertisings {
            static let thereNoFavAdvertising = "شما هیچ آگهی نشان شده‌ای ندارید!"
        }
    }
    
    struct Cells {
        struct AllAdvertising {
            static let fakeLocationAndTime = "تهران پارس شمالی، یک ربع پیش"
            static let tempAdvertisingTitle = "این یک اگهی موقتی برای تست برنامه دیوار میباشد لطفا صبور باشید"
            static let fakePrice = "۳۵ میلیون تومان"
            
        }
    }
    
    
    struct NavTitle {
        static let allAdvertisings = "همه آگهی ها"
        static let newAdvertising = "آگهی جدید"
        static let AdvertisingDetails = "جزییات آگهی"
        static let myProfile = "پروفایل من"
        static let myAdvertisings = "آگهی‌های من"
        static let loginUser = "ورود کاربر"
        static let favAdvertisings = "نشان شده‌ها"
        static let aboutDivar = "درباره دیوار"
        static let aboutUs = "درباره ما"
    }
    
    struct TabBarTitle {
        static let allAdvertising = "آگهی ها"
        static let newAdvertising = "آگهی جدید"
        static let profile = "پروفایل"
    }
    
    struct popupText {
        static let noInternetConnectionTitle = "به اینترنت وصل نیستید!"
        static let noInternetConnectionDescription = "اتصال خود به اینترنت را چک کنید"
        
        static let fillInTheBlank = "فیلد‌های خالی را پر کنید."
        
        static let imageGalleryTitle = "گالری عکس‌ها"
        static let imageGalleryMessage =  "عکس خود را انتخاب کنید"
        static let gallery = "گالری"
        static let camera = "دوربین"
        static let cancel = "بیخیال"
        static let ok = "باشه"
        
    }
    
    struct Id {
        static let allAdvertisingCell = "advertising_cell_id"
        static let favAdvertisingCell = "fav_advertising_cell_id"
        static let imageCell = "image_cell"
        static let imageEmptyCell = "image_empty_cell"
        static let popChooseLocationCellId = "popup_Chooce_location_cell_id"
    }
    
    struct BtnTitle {
        static let registerLocation = "ثبت آگهی"
        static let chooseLocation = "انتخاب محل"
        static let callToSeller = "تماس با فروشنده"
        static let login = "ورود"
        static let registerNewUser = "ثبت نام"
        static let logout = "خروج"
    }
    
    struct URL {
        static let mainBase = ""
        static let fakeBase = "http://127.0.0.1/Test1/"
        static let loginEndPoint = "\(fakeBase)logging.php"
        static let registerEndPoint = "\(fakeBase)register.php"
        static let allAdvertisingsEndPoint = "\(fakeBase)all-advertisings.php"
        static let newAdvertisingEndPoint = "\(fakeBase)add-new-advertising.php"
        static let likeAdvertising = "\(fakeBase)like-advertising.php"
        static let singleAdvertisingByUserId = "\(fakeBase)single-advertising-by-userid.php"
        static let sigleAdvertising = "\(fakeBase)single-advertising.php"
        static let favAdvertisings = "\(fakeBase)user-advertisings.php"

        static let fakeJSON = "https://jsonplaceholder.typicode.com/posts"
        
    }
    
    struct API {
        static let apiKey = ""
        static let accessTokenKey = "access_token"
        static let refreshTokenKey = "refresh_token"
        static let bearer = "Bearer ://"
        static let userId = "user_id"
        static let advertisingId = "advertising_id"
        static let fullName = "user_full_name"
        
        static let isSuccessful = "isSuccessful"
        static let isLoggedIn = "isLoggedIn"
    }
    
    struct Toast {
        static let serverNotResponding = "سرور پاسخ گو نیست. مجددا امتحان کنید!"
        static let checkInternetConnection = "اتصال خود به اینترنت را چک کنید!"
        static let chooseLocation = "استان محل زندگی خود را انتخاب کنید!"
        static let imageListNotEnough = "حداقل یک عکس انتخاب کنید."
        static let notLoggedIn = "شما وارد حساب کاربری خود نشده‌اید!"
        static let fillInTheBlank = "فیلد‌های خالی را پر کنید!"
        static let newAdvertisingRegisteredSuccessfully = "آگهی شما اب موفقیت ثبت شد."
        static let thereIsProblem = "مشکلی پیش آمده، بعدا امتحان کنید!"
        static let validateYourInput = "ورودی نامعتبر است!"
        static let shortCharacter = "طول ورودی‌ها کمتر از حد مجاز است!"
        
    }
    
    struct TempText {
        static let newAdvertising = "بخش 'آگهی جدید' بزودی کامل می شود"
        static let myAdvertisings = "بخش 'آگهی‌های من' بزودی بروز رسانی می شود"
        static let loginUser = "بخش 'ورود کاربر' بزودی بروز رسانی می شود"
        static let favoriteAdvertising = "بخش 'نشان شده‌ها' بزودی بروز رسانی می شود"
        static let phoneNumber = "09195474883"
        static let qazvin = "قزوین"
    }
    
    struct Province {
        static let provincesList = [
            
                        "کرمان",
            "سیستان و بلوچستان",
            "خراسان جنوبی",
            "فارس",
            "خراسان رضوی",
            "اصفهان",
            "سمنان",
            "یزد",
            "هرمزگان",
            "خوزستان",
            "آذربایجان شرقی",
            "آذربایجان غربی",
            "کردستان",
            "مرکزی",
            "خراسان شمالی",
            "لرستان",
            "بوشهر",
            "کرمانشاه",
            "مازندران",
            "زنجان",
            "گلستان",
            "ایلام",
            "همدان",
            "اردبیل",
            "چهارمحال و بختیاری",
            "قزوین",
            "کهگیلویه و بویراحمد",
            "گیلان",
            "تهران",
            "قم",
            "البرز"
        ]
    }
}
