enum Locales { 
  Hungary, England
}

class LocaleTranslator{
  static Map<int, Locales> localeMap = {1: Locales.England, 2: Locales.Hungary};

  static Locales getLocaleByID(int id){
    return localeMap[id];
  }

  static int getLocaleID(Locales locale) {
    int id;
    localeMap.forEach((key, value) {
      if(value == locale) id = key;
    });
    return id;
  }
}