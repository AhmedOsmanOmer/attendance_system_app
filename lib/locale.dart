import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          "login_hint": "Student ID",
          "login_button": "Login",
          "id": "ID",
          "name": "Name",
          "specialization": "Program",
          "year": "Year",
          "index": "Index",
          "scan_button": "Scan QR Code ",
          "warning": "Warning",
          "another_std": "This Device is belong to another student",
          "not_you": "This Device is not belong to you",
          "system_off": "System is OFF",
          "wrong_id": "Wrong ID",
          "atttendence_success": "Atttendance Success",
          "attendence_twice": "You can't make Attendance more than once",
          "wrong_qr": "invalid QR Code",
          "loading": "Loading...",
          "no_connection": "No Connection",
          "check_internet": "Check Internet Connection",
          "ok":"OK"
        },
        "ar": {
          "login_hint": "الرقم الجامعي",
          "login_button": "تسجيل الدخول",
          "id": "الرقم الجامعي",
          "name": "الاسم",
          "specialization": "التخصص",
          "year": "السنة:  ",
          "index": "رقم الجلوس",
          "scan_button": "مسح رمز الاستجابة السريع ",
          "warning": "تنبيه",
          "another_std": "هذا الجهاز يخص طالب اخر",
          "not_you": "هذا الجهاز ليس لك",
          "system_off": "النظام مغلق",
          "wrong_id": "رقم طالب غير صحيح",
          "atttendence_success": "تم تسجيل الحضور بنجاح",
          "attendence_twice": "لا يمكنك تسجيل الحضور مرتين",
          "wrong_qr": "رمز Qr غير صحيح",
          "loading": "جاري التحميل...",
          "no_connection": "لايوجد انترنت",
          "check_internet": "تحقق من اتصال الانترنت",
          "ok":"حسنا"
        }
      };
}
