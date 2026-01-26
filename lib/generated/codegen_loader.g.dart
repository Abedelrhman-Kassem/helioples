// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "login_screen": {
    "login": "تسجيل الدخول",
    "phone_number": "رقم الهاتف",
    "password": "كلمة المرور",
    "verification_info": "سوف تتلقى رمز التحقق",
    "continue": "استمرار",
    "verification_sent": "لقد أرسلنا رمز التحقق بالفعل",
    "no_account": "ليس لديك حساب؟ ",
    "register_now": "سجل الآن",
    "or": "أو",
    "shop_now": "تسوق الآن",
    "permission_granted": "تم منح الإذن من قبل المستخدم",
    "permission_provisional": "تم منح إذن مؤقت من قبل المستخدم",
    "permission_declined": "رفض المستخدم أو لم يقبل الإذن",
    "logged_in_successfully": "تم تسجيل الدخول بنجاح",
    "verification_code_sent": "تم ارسال كود التحقق"
  },
  "verification_screen": {
    "verify_phone_number": "تأكيد رقم الهاتف",
    "sent_code_to": "لقد أرسلنا رمزًا إلى رقمك",
    "please_enter_code": "يرجى إدخال الرمز المرسل",
    "verify_now": "تأكيد الآن",
    "didnt_receive_code": "لم تستلم رمز التحقق؟",
    "resend_code": "إعادة إرسال الرمز",
    "success_creating_account": "تم إنشاء الحساب بنجاح",
    "success_verification": "تم التأكد من الرمز بنجاح"
  },
  "signup_screen": {
    "register": "تسجيل جديد",
    "first_name": "الاسم الأول",
    "last_name": "اسم العائلة",
    "phone_number": "رقم الهاتف",
    "birthday_date": "تاريخ الميلاد",
    "continue": "استمرار",
    "already_have_account": "لديك حساب بالفعل؟",
    "login_now": "تسجيل الدخول الآن",
    "please_enter_validation_code": "يرجى إدخال رمز التحقق",
    "failed_send_otp": "فشل إرسال رمز التحقق",
    "otp_sent": "لقد أرسلنا لك رمز التحقق"
  },
  "set_location_screen": {
    "skip": "تخطي",
    "choose_delivery_location": "اختر موقع التوصيل",
    "find_a_place": "ابحث عن مكان...",
    "location_info": "معلومات الموقع",
    "cairo_egypt": "القاهرة، مصر",
    "loading_location": "جاري تحميل الموقع...",
    "error": "خطأ:",
    "no_location_found": "لم يتم العثور على موقع",
    "continue": "استمرار",
    "location_sent": "تم إرسال الموقع",
    "unknown_location": "الموقع غير معروف",
    "service_not_available": "خدمة تحديد الموقع غير متاحة حاليًا",
    "error_getting_location": "حدث خطأ أثناء الحصول على الموقع"
  },
  "notification_screen": {
    "allow_us_to_send": "اسمح لنا بإرسال ",
    "notifications": "الإشعارات؟",
    "allow_notification": "السماح بالإشعارات",
    "maybe_later": "ربما لاحقًا"
  },
  "confirmation_screen": {
    "account_created": "تم إنشاء حسابك بنجاح!",
    "welcome_promo": "مرحبًا بك، لقد حصلت على كود خصم 10% ",
    "promocode": "كود الخصم",
    "copied": "تم النسخ",
    "allow_location_access": "السماح بالوصول للموقع",
    "enter_location_manually": "إدخال الموقع يدويًا"
  },
  "all_special_offers_screen": {
    "special_offers": "العروض الخاصة",
    "view_all": "اظهار الكل"
  },
  "cart_modal": {
    "select_order_type": "يرجى اختيار نوع الطلب",
    "delivery": "توصيل",
    "pickup": "استلام",
    "continue": "استمرار",
    "sub_total": "الإجمالي الفرعي",
    "items": "عناصر",
    "discount": "خصم",
    "total_price": "السعر الإجمالي",
    "checkout": "إتمام الطلب"
  },
  "cart_screen": {
    "cart": "عربة التسوق",
    "initial_widget": "عنصر مبدئي",
    "cart_item_cant_add_more": "لا يمكنك إضافة أكثر من {pieces} قطعة",
    "cart_item_pcs": "قطعة",
    "cart_item_egp": "ج.م",
    "update": "تحديث",
    "ok": "موافق"
  },
  "sub_categories_screen": {
    "loading": "جاري التحميل...",
    "No_Products_Found": "لم يتم العثور على منتجات",
    "featured": "مميز"
  },
  "home_screen_categories": "الفئات",
  "re_order_screen": {
    "checkout": "إتمام الطلب",
    "edit_order_terms": "يمكنك تعديل شروط الطلب وإعادة الطلب",
    "re_order": "إعادة الطلب",
    "delivery_time": "وقت التوصيل"
  },
  "pickup_reorder_screen": {
    "checkout": "إتمام الطلب",
    "edit_order_terms": "يمكنك تعديل شروط الطلب وإعادة الطلب",
    "re_order": "إعادة الطلب",
    "pickup_time": "وقت الاستلام",
    "the_branch_is_null": "الفرع غير محدد"
  },
  "pickup_order_details_screen": {
    "order_details": "تفاصيل الطلب",
    "order_items": "عناصر الطلب",
    "pickup_branch": "فرع الاستلام",
    "address_sample": "شارع عمر بن الخطاب 436A"
  },
  "pick_up_screen": {
    "checkout": "إتمام الطلب",
    "order_items": "عناصر الطلب",
    "pickup_time": "وقت الاستلام",
    "the_branch_is_null": "الفرع غير محدد"
  },
  "checkout_details_screen": {
    "order_details": "تفاصيل الطلب",
    "order_items": "عناصر الطلب",
    "delivery_address": "عنوان التوصيل",
    "home": "المنزل",
    "address_sample": "شارع عمر بن الخطاب 436A",
    "payment": "الدفع",
    "cash_on_delivery": "الدفع عند الاستلام",
    "card_on_delivery": "بطاقة عند الاستلام",
    "credit_debit_card": "بطاقة ائتمان/خصم",
    "delivery_time": "وقت التوصيل",
    "instant": "فوري، ",
    "arrive_at": "سيصل الساعة 7:30 مساءً",
    "order_summery": "ملخص الطلب",
    "order_number": "رقم الطلب",
    "copied_to_clipboard": "تم النسخ إلى الحافظة!",
    "sub_total": "الإجمالي الفرعي",
    "items": "عناصر",
    "promocode_discount": "كود الخصم",
    "delivery_fees": "رسوم التوصيل",
    "total_price": "السعر الإجمالي",
    "cancel_order": "إلغاء الطلب"
  },
  "checkout_delivery_screen": {
    "checkout": "إتمام الطلب",
    "order_items": "عناصر الطلب",
    "delivery_time": "وقت التوصيل",
    "total_price": "السعر الإجمالي",
    "place_order": "تأكيد الطلب",
    "payment": "الدفع",
    "cash_on_delivery": "الدفع عند الاستلام (كاش)",
    "card_on_delivery": "الدفع عند الاستلام (بطاقة)",
    "credit_debit_card": "بطاقة ائتمان / خصم مباشر",
    "instant": "فوري، ",
    "arrive_at": "يصل في",
    "receive_at": "استلام في",
    "schedule_pickup_time": "جدولة وقت الاستلام",
    "please_select_address": "برجاء اختيار عنوان أو إضافة عنوان للمرة الواحدة"
  },
  "card_screen": {
    "add_payment_card": "إضافة بطاقة دفع",
    "card_number": "رقم البطاقة",
    "name_on_card": "الاسم على البطاقة",
    "expiration_date": "تاريخ الانتهاء",
    "cvv": "رمز التحقق (CVV)",
    "add_card": "إضافة البطاقة",
    "save_card_to_use_later": "حفظ البطاقة للاستخدام لاحقًا"
  },
  "explore_screen": {
    "search_for_groceries_and_more": "ابحث عن البقالة والمزيد",
    "search_history": "سجل البحث",
    "clear_history": "مسح السجل"
  },
  "home_layout_screen": {
    "home": "الرئيسية",
    "explore": "بحث",
    "liked": "المفضلة",
    "cart": "العربة",
    "profile": "الملف الشخصي"
  },
  "home_screen": {
    "hello_how": "مرحبًا كيف"
  },
  "intro_screen": {
    "better": "أفضل",
    "prices": "أسعار,",
    "faster": "أسرع",
    "delivery": "توصيل",
    "start_shopping": "ابدأ التسوق",
    "already_have_account": "هل لديك حساب بالفعل؟",
    "sign_in": "تسجيل الدخول."
  },
  "liked_screen": {
    "initial": "مبدئي",
    "likes": "المفضلة",
    "You_must_login_first": "يجب عليك تسجيل الدخول أولاً"
  },
  "product_screen": {
    "related_products": "منتجات ذات صلة",
    "hello_there": "مرحبًا هناك",
    "tap_to_try_again": "اضغط للمحاولة مرة أخرى"
  },
  "profile_screen": {
    "profile_information": "معلومات الحساب",
    "orders_history": "سجل الطلبات",
    "alerts": "التنبيهات",
    "app_settings": "إعدادات التطبيق",
    "help_center": "مركز المساعدة",
    "chat_with_us": "الدردشة معنا",
    "logout": "تسجيل الخروج",
    "user_profile": "الملف الشخصي",
    "logout_now_dialog_title": "تسجيل الخروج الآن",
    "logout_cancel": "إلغاء"
  },
  "settings_screen": {
    "app_settings": "إعدادات التطبيق",
    "change_language": "تغيير اللغة",
    "english": "الإنجليزية",
    "arabic": "العربية (Arabic)",
    "update_language": "تحديث اللغة",
    "app_mode": "وضع التطبيق",
    "light_mode": "الوضع الفاتح",
    "dark_mode": "الوضع الداكن",
    "update_mode": "تحديث الوضع",
    "delete_account": "حذف الحساب"
  },
  "change_information_screen": {
    "profile_information": "معلومات الحساب",
    "edit_your_personal_information": "تعديل معلوماتك الشخصية",
    "first_name": "الاسم الأول",
    "last_name": "اسم العائلة",
    "phone_number": "رقم الهاتف",
    "birthday_date": "تاريخ الميلاد",
    "save": "حفظ",
    "invalid_date_format": "تنسيق التاريخ غير صحيح"
  },
  "verification_changes_screen": {
    "profile_information": "معلومات الحساب",
    "verify_phone_number": "تأكيد رقم الهاتف",
    "sent_code_to": "لقد أرسلنا رمزًا إلى رقمك +2{phoneNumber}",
    "please_enter_code": "يرجى إدخال الرمز المرسل",
    "verify_now": "تأكيد الآن",
    "profile_updated_success": "تم تحديث معلومات حسابك بنجاح",
    "done": "تم",
    "didnt_receive_code": "لم تستلم رمز التحقق؟",
    "resend_code": "إعادة إرسال الرمز",
    "number_empty": "لا يمكن أن يكون الرقم فارغًا",
    "number_invalid": " رقم الهاتف يجب أن يكون 11 رقمًا"
  },
  "order_details_screen": {
    "something_went_wrong": "حدث خطأ ما",
    "order_details": "تفاصيل الطلب",
    "order_confirmed": "تم تأكيد الطلب",
    "order_prepared": "تم تجهيز الطلب",
    "picked_up": "تم الاستلام",
    "order_invoice": "فاتورة الطلب",
    "sub_total": "الإجمالي الفرعي",
    "vat": "ضريبة القيمة المضافة",
    "delivery_fees": "رسوم التوصيل",
    "promocode_discount": "خصم الكود الترويجي",
    "wallet": "المحفظة",
    "total": "الإجمالي"
  },
  "history_screen": {
    "orders_history": "سجل الطلبات",
    "active_orders": "الطلبات النشطة",
    "completed_orders": "الطلبات المكتملة",
    "Active": "نشط",
    "no_orders_found": "لا توجد طلبات",
    "canceled": "ملغى"
  },
  "report_screen": {
    "choose_image_source": "اختر مصدر الصورة",
    "camera": "الكاميرا",
    "gallery": "المعرض",
    "report_an_issue": "الإبلاغ عن مشكلة",
    "first_name": "الاسم الأول",
    "last_name": "اسم العائلة",
    "phone_number": "رقم الهاتف",
    "your_message": "رسالتك",
    "enter_your_message_in_details": "أدخل رسالتك بالتفصيل",
    "upload": "رفع",
    "submit_message": "إرسال الرسالة",
    "report_is_sent": "تم إرسال البلاغ"
  },
  "help_center_screen": {
    "help_center": "مركز المساعدة",
    "report_an_issue": "الإبلاغ عن مشكلة",
    "faqs": "الأسئلة الشائعة",
    "call_us": "اتصل بنا"
  },
  "faqs_screen": {
    "FAQS": "الأسئلة الشائعة"
  },
  "alerts_screen": {
    "Alerts": "التنبيهات",
    "Today": "اليوم",
    "Yesterday": "أمس",
    "Order_Confirmed_Successfully": "تم تأكيد الطلب بنجاح",
    "Lorem_ipsum": "هذا نص تجريبي يستخدم في التصميم، سيتم استبداله بمحتوى حقيقي لاحقًا."
  },
  "special_offer_item_screen": {
    "Special_Offers": "العروض الخاصة",
    "hello_there": "مرحباً هناك"
  },
  "profile_profile_information": "معلومات الحساب",
  "profile_orders_history": "سجل الطلبات",
  "profile_alerts": "التنبيهات",
  "profile_app_settings": "إعدادات التطبيق",
  "profile_help_center": "مركز المساعدة",
  "profile_chat_with_us": "تحدث معنا",
  "profile_logout": "تسجيل الخروج",
  "profile_user_profile": "الملف الشخصي",
  "comleted_order_screen": {
    "completed_order_screen_sign_in_now": "سجل الدخول الآن",
    "completed_order_screen_no_profile_information": "لا توجد معلومات حساب",
    "completed_order_screen_sign_in_to_control": "يجب عليك تسجيل الدخول للتحكم في معلوماتك الشخصية",
    "completed_order_screen_refresh": "تحديث",
    "completed_order_screen_error_occurred": "حدث خطأ",
    "completed_order_screen_problem_refresh": "يبدو أن هناك مشكلة، يرجى التحديث",
    "completed_order_screen_items": "عناصر",
    "completed_order_screen_egp": "ج.م",
    "completed_order_screen_location_sample": "١٣ صلاح سالم، رقم ٤٥ القاهرة مصر"
  },
  "cancel_order_bottom_sheet": {
    "order_cancellation": "إلغاء الطلب",
    "cancel_order_confirmation": "هل أنت متأكد أنك تريد إلغاء هذا الطلب؟",
    "cancel_order": "إلغاء الطلب",
    "dont_cancel": "لا تلغي",
    "help_us_reason": "ساعدنا في فهم سبب الإلغاء",
    "reason_just_changed": "غيرت رأيي فقط.",
    "reason_placed_by_mistake": "قمت بالطلب عن طريق الخطأ",
    "reason_modify_products": "أحتاج لتعديل منتجات الطلب",
    "reason_change_address": "أحتاج لتغيير عنوان التوصيل",
    "reason_change_payment": "أحتاج لتغيير طريقة الدفع",
    "reason_other": "أخرى",
    "submit": "إرسال"
  },
  "choose_bottom_sheet": {
    "choose_how_to_proceed": "إذا لم نتمكن من التواصل معك خلال 15 دقيقة، كيف تريدنا أن نتابع؟",
    "choose_for_me": "اختر لي",
    "choose_for_me_desc": "اختر منتجات تقريبًا بنفس السعر",
    "do_not_choose_alternative": "لا تختار بديل",
    "do_not_choose_alternative_desc": "سنتجاهل العناصر الناقصة",
    "submit": "إرسال"
  },
  "delivery_tips_container": {
    "appreciate_delivery_with_tips": "قدر عامل التوصيل بالبقشيش",
    "tips_amount_goes_to_labor": "مبلغ البقشيش سيذهب مباشرة لعامل التوصيل",
    "10_egp": "١٠ جنيه",
    "20_egp": "٢٠ جنيه",
    "30_egp": "٣٠ جنيه",
    "40_egp": "٤٠ جنيه",
    "custom": "مخصص",
    "tips_amount": "مبلغ البقشيش",
    "enter_amount": "أدخل المبلغ",
    "apply": "تطبيق",
    "enter_valid_number": "أدخل رقم صحيح"
  },
  "exit_order_bottom": {
    "exit_order": "خروج من الطلب",
    "exit_order_confirmation": "هل أنت متأكد أنك تريد الخروج من الطلب؟",
    "exit_order_button": "خروج من الطلب",
    "cancel": "إلغاء"
  },
  "order_summary_screen": {
    "sub_total": "الإجمالي الفرعي",
    "items": "عناصر",
    "discount": "الخصم",
    "promocode_discount": "خصم كود الخصم",
    "delivery_fees": "رسوم التوصيل",
    "currency": "ج.م",
    "title": "كود الخصم",
    "hint": "أدخل كود الخصم",
    "apply_button": "تطبيق",
    "error_message": "كود الخصم غير صالح",
    "success_message": "تم تطبيق كود الخصم بنجاح"
  },
  "schedule_screen": {
    "schedule_delivery_time": "حدد وقت التوصيل",
    "arrive_at": "الوصول في",
    "schedule": "جدولة"
  },
  "search_delegate": {
    "all_suggestions": "جميع الاقتراحات",
    "search_for_groceries_and_more": "ابحث عن البقالة والمزيد",
    "search_history": " سجل البحث",
    "clear_history": "مسح السجل"
  },
  "location_widget": {
    "delivery_duration": "مدة التوصيل:",
    "delivery_time": "٣٥ دقيقة",
    "delivery_address": "عنوان التوصيل",
    "add_address": "إضافة عنوان",
    "done": "تم",
    "please_login": "يرجى تسجيل الدخول لتحديد العنوان",
    "tap_to_add_address": "اضغط لإضافة عنوان",
    "no_address_found": "لم يتم العثور على عنوان",
    "no_address": "لا يوجد عنوان"
  },
  "validation": {
    "empty_error": "لا يمكن أن يكون الحقل فارغًا",
    "invalid_username": "اسم المستخدم غير صالح",
    "invalid_email": "البريد الإلكتروني غير صالح",
    "invalid_phone": "رقم الهاتف غير صالح",
    "too_short": "يجب ألا يقل عن {min} أحرف",
    "too_long": "يجب ألا يزيد عن {max} أحرف"
  },
  "product_widget": {
    "pcs": "قطعة",
    "egp": "ج.م",
    "off": "% خصم"
  },
  "alternative_container": {
    "alternative_products": "المنتجات البديلة",
    "alternative_description": "في حالة عدم توفر منتج أو أكثر من المنتجات المختارة، كيف يمكننا التواصل معك؟",
    "give_me_a_call": "اتصل بي",
    "remove_item": "إزالة المنتج"
  },
  "error_messages": {
    "failed_calculate_delivery_fee": "فشل في حساب رسوم التوصيل"
  },
  "add_location": {
    "address_title": "عنوان الموقع",
    "street": "الشارع",
    "floor": "الدور",
    "building_number": "رقم المبنى",
    "department": "الشقة",
    "save_address": "حفظ العنوان",
    "use_once": "استخدام مرة واحدة",
    "title_required": "العنوان مطلوب",
    "edit": "تعديل",
    "confirm_location": "تأكيد الموقع"
  },
  "maintenance_screen": {
    "server_unavailable": "الخدمة غير متوفرة",
    "notify_me": "أبلغني عندما تعود الخدمة",
    "default_maintenance_msg": "خوادمنا متوقفة حاليًا أو تخضع للصيانة. يرجى المحاولة مرة أخرى لاحقًا.",
    "service_temporarily_unavailable": "الخدمة غير متوفرة مؤقتاً"
  },
  "connectivity": {
    "no_internet": "الإنترنت غير متوفر الآن",
    "connection_restored": "تم استعادة الاتصال بالإنترنت"
  }
};
static const Map<String,dynamic> _en = {
  "login_screen": {
    "Already_Have_An_Account?": "Already Have An Account?",
    "login": "Login",
    "phone_number": "Phone Number",
    "password": "Password",
    "verification_info": "You will receive a verification code",
    "continue": "Continue",
    "verification_sent": "We already sent a verification code",
    "no_account": "Don’t Have Account? ",
    "register_now": "Register Now",
    "or": "Or",
    "shop_now": "Shop Now",
    "permission_granted": "User granted permission",
    "permission_provisional": "User granted provisional permission",
    "permission_declined": "User declined or has not accepted permission",
    "logged_in_successfully": "Logged in successfully",
    "verification_code_sent": "Verification code sent"
  },
  "verification_screen": {
    "verify_phone_number": "Verify Phone Number",
    "sent_code_to": "We have sent a code to your number",
    "please_enter_code": "Please enter the code sent",
    "verify_now": "Verify Now",
    "didnt_receive_code": "Didn’t receive verification Code?",
    "resend_code": "Resend Code",
    "success_creating_account": " success creating account",
    "success_verification": "OTP verified successfully"
  },
  "signup_screen": {
    "register": "Register",
    "first_name": "First Name",
    "last_name": "Last Name",
    "phone_number": "Phone Number",
    "birthday_date": "Birthday Date",
    "continue": "Continue",
    "already_have_account": "Already Have An Account?",
    "login_now": "Login Now",
    "please_enter_validation_code": "Please Enter Validation code",
    "failed_send_otp": "Failed to send OTP",
    "otp_sent": "We have sent you a verification code"
  },
  "set_location_screen": {
    "skip": "Skip",
    "choose_delivery_location": "Choose Delivery Location",
    "find_a_place": "Find a place...",
    "location_info": "Location Info",
    "cairo_egypt": "Cairo, Egypt",
    "loading_location": "Loading location...",
    "error": "Error:",
    "no_location_found": "No location found",
    "continue": "Continue",
    "location_sent": "location sent ",
    "unknown_location": "Unknown location",
    "service_not_available": "Location service not available",
    "error_getting_location": "Error while getting location"
  },
  "notification_screen": {
    "allow_us_to_send": "Allow Us To Send You ",
    "notifications": "notifications?",
    "allow_notification": "Allow Notification",
    "maybe_later": "Maybe Later"
  },
  "confirmation_screen": {
    "account_created": "Your account has been created successfully!",
    "welcome_promo": "Welcome to the board, you got a 10 % promocode ",
    "promocode": "Promocode",
    "copied": "Copied",
    "allow_location_access": "Allow Location Access",
    "enter_location_manually": "Enter Location Manually"
  },
  "all_special_offers_screen": {
    "special_offers": "Special Offers",
    "view_all": "View All"
  },
  "cart_modal": {
    "select_order_type": "Please Select Order Type",
    "delivery": "Delivery",
    "pickup": "Pickup",
    "continue": "Continue",
    "sub_total": "Sub Total",
    "items": "Items",
    "discount": "Discount",
    "total_price": "Total Price",
    "checkout": "Checkout"
  },
  "cart_screen": {
    "cart": "Cart",
    "initial_widget": "Initial Widget",
    "cart_item_cant_add_more": "You can't add more than {pieces} pieces",
    "cart_item_pcs": "Pcs",
    "cart_item_egp": "EGP",
    "update": "Update",
    "ok": "OK"
  },
  "sub_categories_screen": {
    "loading": "Loading...",
    "No_Products_Found": "No Products Found",
    "featured": "Featured"
  },
  "re_order_screen": {
    "checkout": "Checkout",
    "edit_order_terms": "You can edit order’s terms and re-order",
    "re_order": "Re-Order",
    "delivery_time": "Delivery Time"
  },
  "pickup_reorder_screen": {
    "checkout": "Checkout",
    "edit_order_terms": "You can edit order’s terms and re-order",
    "re_order": "Re-Order",
    "pickup_time": "PickUp Time",
    "the_branch_is_null": "the branch is null"
  },
  "pickup_order_details_screen": {
    "order_details": "Order Details",
    "order_items": "Order Items",
    "pickup_branch": "Pickup Branch",
    "address_sample": "Omar Ibn Al Khatab Street 436A"
  },
  "pick_up_screen": {
    "checkout": "Checkout",
    "order_items": "Order Items",
    "pickup_time": "PickUp Time",
    "the_branch_is_null": "the branch is null"
  },
  "checkout_details_screen": {
    "order_details": "Order Details",
    "order_items": "Order Items",
    "delivery_address": "Delivery Address",
    "home": "Home",
    "address_sample": "Omar Ibn Al Khatab Street 436A",
    "payment": "Payment",
    "cash_on_delivery": "Cash On Delivery",
    "card_on_delivery": "Card On Delivery",
    "credit_debit_card": "Credit/Debit Card",
    "delivery_time": "Delivery Time",
    "instant": "Instant, ",
    "arrive_at": "Arrive at 7:30 PM",
    "order_summery": "Order Summery",
    "order_number": "Order Number",
    "copied_to_clipboard": "Copied to clipboard!",
    "sub_total": "Sub Total",
    "items": "Items",
    "promocode_discount": "Promocode Discount",
    "delivery_fees": "Delivery fees",
    "total_price": "Total Price",
    "cancel_order": "Cancel Order"
  },
  "checkout_delivery_screen": {
    "checkout": "Checkout",
    "order_items": "Order Items",
    "delivery_time": "Delivery Time",
    "total_price": "Total Price",
    "place_order": "Place Order",
    "payment": "Payment",
    "cash_on_delivery": "Cash on delivery",
    "card_on_delivery": "Card on delivery",
    "credit_debit_card": "Credit/Debit card",
    "instant": "Instant, ",
    "arrive_at": "Arrive at",
    "receive_at": "Receive at",
    "schedule_pickup_time": "Schedule pickup time",
    "please_select_address": "Please select an address or add a once-use address"
  },
  "card_screen": {
    "add_payment_card": "Add Payment Card",
    "card_number": "Card Number",
    "name_on_card": "Name On Card",
    "expiration_date": "Expiration date",
    "cvv": "CVV",
    "add_card": "Add Card",
    "save_card_to_use_later": "Save Card to use later"
  },
  "explore_screen": {
    "search_for_groceries_and_more": "Search for groceries and more",
    "search_history": "Search History",
    "clear_history": "Clear History"
  },
  "home_layout_screen": {
    "home": "Home",
    "explore": "Explore",
    "liked": "Liked",
    "cart": "Cart",
    "profile": "Profile"
  },
  "home_screen": {
    "hello_how": "hello how"
  },
  "home_screen_view_all": "View All",
  "home_screen_categories": "Categories",
  "intro_screen": {
    "better": "Better",
    "prices": "Prices,",
    "faster": "Faster",
    "delivery": "Delivery",
    "start_shopping": "Start Shopping",
    "already_have_account": "Already Have account?",
    "sign_in": "Sign In."
  },
  "liked_screen": {
    "initial": "Initial",
    "likes": "Likes",
    "You_must_login_first": "You must login first"
  },
  "product_screen": {
    "related_products": "Related Products",
    "hello_there": "hello there",
    "tap_to_try_again": "Tap to try again"
  },
  "profile_screen": {
    "profile_information": "Profile Information",
    "orders_history": "Orders History",
    "alerts": "Alerts",
    "app_settings": "App Settings",
    "help_center": "Help Center",
    "chat_with_us": "Chat with Us",
    "logout": "Logout",
    "user_profile": "User Profile",
    "logout_now_dialog_title": "Logout Now",
    "logout_cancel": "Cancel"
  },
  "settings_screen": {
    "app_settings": "App Settings",
    "change_language": "Change Language",
    "english": "English",
    "arabic": "Arabic (العربية)",
    "update_language": "Update language",
    "app_mode": "App Mode",
    "light_mode": "Light Mode",
    "dark_mode": "Dark Mode",
    "update_mode": "Update Mode",
    "delete_account": "Delete Account"
  },
  "change_information_screen": {
    "profile_information": "Profile Information",
    "edit_your_personal_information": "Edit Your Personal Information",
    "first_name": "First Name",
    "last_name": "Last Name",
    "phone_number": "Phone Number",
    "birthday_date": "Birthday Date",
    "save": "Save",
    "invalid_date_format": "Invalid date format"
  },
  "verification_changes_screen": {
    "profile_information": "Profile Information",
    "verify_phone_number": "Verify Phone Number",
    "sent_code_to": "We have sent a code to your number +2{phoneNumber}",
    "please_enter_code": "Please enter the code sent",
    "verify_now": "Verify Now",
    "profile_updated_success": "Your Profile Information Updated Successfully",
    "done": "Done",
    "didnt_receive_code": "Didn’t receive verification Code?",
    "resend_code": "Resend Code",
    "number_empty": "Number can't be empty",
    "number_invalid": "Phone number must be 11 digits"
  },
  "order_details_screen": {
    "something_went_wrong": "Something went wrong",
    "order_details": "Order Details",
    "order_confirmed": "Order Confirmed",
    "order_prepared": "Order Prepared",
    "picked_up": "Picked Up",
    "order_invoice": "Order Invoice",
    "sub_total": "Sub Total",
    "vat": "Vat",
    "delivery_fees": "Delivery Fees",
    "promocode_discount": "Promocode Discount",
    "wallet": "Wallet",
    "total": "Total"
  },
  "history_screen": {
    "orders_history": "Orders History",
    "active_orders": "Active Orders",
    "completed_orders": "Completed Orders",
    "Active": "Active",
    "no_orders_found": "No Orders Found",
    "canceled": "Canceled"
  },
  "report_screen": {
    "choose_image_source": "Choose Image Source",
    "camera": "Camera",
    "gallery": "Gallery",
    "report_an_issue": "Report An Issue",
    "first_name": "First Name",
    "last_name": "Last Name",
    "phone_number": "Phone Number",
    "your_message": "Your Message",
    "enter_your_message_in_details": "Enter Your Message In Details",
    "upload": "Upload",
    "submit_message": "Submit Message",
    "report_is_sent": "Report Is Sent"
  },
  "help_center_screen": {
    "help_center": "Help Center",
    "report_an_issue": "Report An Issue",
    "faqs": "FAQS",
    "call_us": "Call Us"
  },
  "faqs_screen": {
    "FAQS": "FAQS"
  },
  "alerts_screen": {
    "Alerts": "Alerts",
    "Today": "Today",
    "Yesterday": "Yesterday",
    "Order_Confirmed_Successfully": "Order Confirmed Successfully",
    "Lorem_ipsum": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  },
  "special_offer_item_screen": {
    "Special_Offers": "Special Offers",
    "hello_there": "hello there"
  },
  "profile_profile_information": "Profile Information",
  "profile_orders_history": "Orders History",
  "profile_alerts": "Alerts",
  "profile_app_settings": "App Settings",
  "profile_help_center": "Help Center",
  "profile_chat_with_us": "Chat with Us",
  "profile_logout": "Logout",
  "profile_user_profile": "User Profile",
  "comleted_order_screen": {
    "completed_order_screen_sign_in_now": "Sign In Now",
    "completed_order_screen_no_profile_information": "No Profile Information",
    "completed_order_screen_sign_in_to_control": "You need sign in to app in order to control your personal information",
    "completed_order_screen_refresh": "Refresh",
    "completed_order_screen_error_occurred": "Error Occurred",
    "completed_order_screen_problem_refresh": "Seems like we got a problem, please refresh",
    "completed_order_screen_items": "Items",
    "completed_order_screen_egp": "EGP",
    "completed_order_screen_location_sample": "13 Salah Salem, No 45 Cairo Egypt"
  },
  "cancel_order_bottom_sheet": {
    "order_cancellation": "Order Cancellation",
    "cancel_order_confirmation": "Are you sure you want to cancel this order?",
    "cancel_order": "Cancel Order",
    "dont_cancel": "Don't Cancel",
    "help_us_reason": "Help Us understanding the reason beyond cancellation",
    "reason_just_changed": "Just changed my mind.",
    "reason_placed_by_mistake": "I placed the order by mistake",
    "reason_modify_products": "I need to modify orders products",
    "reason_change_address": "I need to change delivery address",
    "reason_change_payment": "I need to change payment method",
    "reason_other": "Other",
    "submit": "Submit"
  },
  "choose_bottom_sheet": {
    "choose_how_to_proceed": "If we couldn’t reach you in 15 minutes, how you want us to proceed?",
    "choose_for_me": "Choose for me",
    "choose_for_me_desc": "Choose products at approximately with the same price",
    "do_not_choose_alternative": "Do not choose alternative",
    "do_not_choose_alternative_desc": "We will ignore the missing items",
    "submit": "Submit"
  },
  "delivery_tips_container": {
    "appreciate_delivery_with_tips": "Appreciate delivery with tips",
    "tips_amount_goes_to_labor": "Tips amount will go directly to the delivery labor",
    "10_egp": "10 EGP",
    "20_egp": "20 EGP",
    "30_egp": "30 EGP",
    "40_egp": "40 EGP",
    "custom": "Custom",
    "tips_amount": "Tips Amount",
    "enter_amount": "Enter Amount",
    "apply": "Apply",
    "enter_valid_number": "enter valid nubmer"
  },
  "exit_order_bottom": {
    "exit_order": "Exit Order",
    "exit_order_confirmation": "Are you sure you want to exit order?",
    "exit_order_button": "Exit Order",
    "cancel": "Cancel"
  },
  "order_summary_screen": {
    "sub_total": "Sub Total",
    "items": "Items",
    "discount": "Discount",
    "promocode_discount": "Promocode Discount",
    "delivery_fees": "Delivery Fees",
    "currency": "EGP",
    "title": "Promo code",
    "hint": "Enter Promo code",
    "apply_button": "Apply",
    "error_message": "Invalid promo code",
    "success_message": "Promo code applied successfully"
  },
  "schedule_screen": {
    "schedule_delivery_time": "Schedule delivery time",
    "arrive_at": "Arrive at",
    "schedule": "Schedule"
  },
  "search_delegate": {
    "all_suggestions": "All Suggestions",
    "search_for_groceries_and_more": "Search for groceries and more",
    "search_history": "Search History",
    "clear_history": "Clear History"
  },
  "location_widget": {
    "delivery_duration": "Delivery Duration:",
    "delivery_time": "35 min",
    "delivery_address": "Delivery Address",
    "add_address": "Add Address",
    "done": "Done",
    "please_login": "Please login to set address",
    "tap_to_add_address": "Tap to add address",
    "no_address_found": "No Address Found",
    "no_address": "No Address"
  },
  "validation": {
    "empty_error": "Can't be empty",
    "invalid_username": "Not a valid username",
    "invalid_email": "Not a valid email",
    "invalid_phone": "Not a valid phone number",
    "too_short": "Can't be less than {min} characters",
    "too_long": "Can't be more than {max} characters"
  },
  "product_widget": {
    "pcs": "Pcs",
    "egp": "EGP",
    "off": "% off"
  },
  "alternative_container": {
    "alternative_products": "Alternative Products",
    "alternative_description": "In case we missed one or more of chosen products, how could we reach you?",
    "give_me_a_call": "Give me a call",
    "remove_item": "Remove item"
  },
  "error_messages": {
    "failed_calculate_delivery_fee": "Failed to calculate delivery fee"
  },
  "add_location": {
    "address_title": "Address title",
    "street": "Street",
    "floor": "Floor",
    "building_number": "Building number",
    "department": "Apartment",
    "save_address": "Save Address",
    "use_once": "Use Once",
    "title_required": "Title is required",
    "edit": "Edit",
    "confirm_location": "Confirm Location"
  },
  "maintenance_screen": {
    "server_unavailable": "Server Unavailable",
    "notify_me": "Notify me when the service is back",
    "default_maintenance_msg": "Our servers are currently down or undergoing maintenance. Please try again later.",
    "service_temporarily_unavailable": "Service Temporarily Unavailable"
  },
  "connectivity": {
    "no_internet": "No internet connection",
    "connection_restored": "Internet connection restored"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
