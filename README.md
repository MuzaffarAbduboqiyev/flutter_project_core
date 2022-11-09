# delivery_service

This project using for shopping food and delivery service. We use Flutter bloc architecture

## Getting Started

Application state management va business logic uchun BLoC va Flutter BLoC plugginlaridan foydalanildi.

- [Business Logic](https://pub.dev/packages/bloc)
- [State management](https://pub.dev/packages/flutter_bloc)

Singletonlik va DI uchun GetIt pluggindan foydalanildi.

- [Singleton and DI](https://pub.dev/packages/get_it)

Network service. Internet bilan ishlash uchun Dio pluggindan foydalanildi.

- [Network service](https://pub.dev/packages/dio)

Textlarga style berish uchub GoogleFonts pluggindan foydalanildi

- [Styles](https://pub.dev/packages/google_fonts)

Local Database. Kichik ma'lumotlarni(theme mode, password, token, phone number) Local devicega saqlab
turish uchun.

- [Hive local database](https://pub.dev/packages/hive)

Multi Language. Applicationni ko'p tilda foydalanish uchun(Uz, Ru, En).

- [EasyLocalization](https://pub.dev/packages/easy_localization)

Local Database. Katta ma'lumotlarni List larni saqlash uchun Moor databasedan foydalanildi. Buni
afzallik tomonlaridan biri, Databasedagi o'zgarishlarni eshitib turish mumkin

- [MoorDatabase](https://pub.dev/packages/moor_flutter/versions/4.0.0-nullsafety)

Flutter Debounce. Biror amalni ma'lum vaqtdan keyin bajarish. Search qilishda, har bir knopka
bosilgandan keyin serverdan ma'lumotlarni yuklash o'rniga, ma'lum vaqt oralig'i beramiz, va shu vaqt
oralig'ida kutib turadi, agar berilgan vaqt ichida yana knopka bosilsa vaqt qayta sanaydi aks holda
berilgan vaqt tugagandan keyin, biz bergan amalni bajaradi. Serverdan ma'lumotlarni yuklab oladi.

- [EasyDebounce](https://pub.dev/packages/easy_debounce)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on
mobile development, and a full API reference.
