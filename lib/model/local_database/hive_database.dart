import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as paths;

/*
 1) Hive local database Map(key, value) strukturasi bo'yicha ma'lumotlarni saqlaydi.

 2) Hive database saqlash uchun application o'rnatilgan device(qurilma)dagi manzilni olamiz => dir = paths.getApplicationDocumentsDirectory().

 3) Hive databaseni yaratish uchun Init(ishga tushirish yoki generate- yaratish) qilamiz
 va application manzilini beramiz => Hive.init(dir).

 4) Hive databasedan foydalanish uchun openBox(open - ochish, box - quti) qilamiz
 va bunga database nomini beramiz va bu bizga box (quti) qaytaradi => Hive.openBox(databaseName).

 5) Hive databasega ma'lumot joylash uchun openBox dan qaytgan box ning
  put(joylash) methodidan foydalanamiz => box.put(key, value).

  6) Hive databasedan ma'lumotni o'qib olish uchun openBox dan qaytgan box ning
  get(olish) methodidan foydalanamiz => box.get(key, defaultValue)
  Agar get methodidagi key Hive databasedagi keys(keylar) ichidan topilmasa, hatolik bermasligi uchun,
  defaultValue(standart qiymat) beriladi.
  defaultValue(standart qiymat)ning toifasi get methodidan
  qaytadigan javobni o'zlashtiradigan o'zgaruvchini toifasi bilan bir xil bo'ladi
  double count = box.get("count", defaultValue: 1.0 (toifasi double, chunki get methodidan double qiymat kutilyapti));
  bool hasToken = box.get("token", defaultValue: false (toifasi bool, chunki get methodidan bool qiymat kutilyapti));

 */

abstract class HiveDatabase {
  Future<Box> generateHiveDatabase();

  Future<bool> changeThemeMode();

  Future<bool> getThemeMode();

  Future<String> getToken();

  Future<bool> setToken(String token);

  Future<String> getPhone();

  Future<bool> setPhone(String phone);

  Future<String> getName();

  Future<bool> setName(String name);

  Future<String> getSurname();

  Future<bool> setSurname(String userSurname);

  Stream<BoxEvent> listenToken();

  Stream<BoxEvent> listenName();

  Stream<BoxEvent> listenSurname();
}

class HiveDatabaseImpl extends HiveDatabase {
  @override
  Stream<BoxEvent> listenToken() async* {
    await generateHiveDatabase();
    yield* Hive.box(hiveDatabaseName).watch(key: hiveToken);
  }

  @override
  Stream<BoxEvent> listenName() async* {
    await generateHiveDatabase();
    yield* Hive.box(hiveDatabaseName).watch(key: hiveName);
  }

  @override
  Stream<BoxEvent> listenSurname() async* {
    await generateHiveDatabase();
    yield* Hive.box(hiveDatabaseName).watch(key: hiveSurname);
  }

  @override
  Future<Box> generateHiveDatabase() async {
    final dataDir = await paths.getApplicationDocumentsDirectory();
    Hive.init(dataDir.path);
    return await Hive.openBox(hiveDatabaseName);
  }

  @override
  Future<bool> changeThemeMode() async {
    final box = await generateHiveDatabase();
    final bool state = await box.get(hiveCurrentTheme, defaultValue: true);
    await box.put(hiveCurrentTheme, !state);
    return !state;
  }

  @override
  Future<bool> getThemeMode() async {
    final box = await generateHiveDatabase();
    final bool state = await box.get(hiveCurrentTheme, defaultValue: true);
    return state;
  }

  @override
  Future<String> getToken() async {
    final box = await generateHiveDatabase();
    final String token = await box.get(hiveToken, defaultValue: "");
    return token;
  }

  @override
  Future<bool> setToken(String token) async {
    final box = await generateHiveDatabase();
    await box.put(hiveToken, token);
    return true;
  }

  @override
  Future<String> getPhone() async {
    final box = await generateHiveDatabase();
    final String userPhone = await box.get(hivePhone, defaultValue: "");
    return userPhone;
  }

  @override
  Future<bool> setPhone(String phone) async {
    final box = await generateHiveDatabase();
    await box.put(hivePhone, phone);
    return true;
  }

  @override
  Future<String> getName() async {
    final box = await generateHiveDatabase();
    final userName = await box.get(hiveName, defaultValue: "");
    return userName;
  }

  @override
  Future<String> getSurname() async {
    final box = await generateHiveDatabase();
    final userSurname = await box.get(hiveSurname, defaultValue: "");
    return userSurname;
  }

  @override
  Future<bool> setName(String name) async {
    final box = await generateHiveDatabase();
    await box.put(hiveName, name);
    return true;
  }

  @override
  Future<bool> setSurname(String userSurname) async {
    final box = await generateHiveDatabase();
    await box.put(hiveSurname, userSurname);
    return true;
  }
}

const hiveDatabaseName = "delivery_service_hive_database";
const hiveCurrentTheme = "delivery_service_hive_theme";
const hiveToken = "delivery_service_hive_token";
const hivePhone = "delivery_service_hive_phone";
const hiveName = "delivery_service_hive_name";
const hiveSurname = "delivery_service_hive_surname";
