import 'package:flutter/material.dart';
import 'package:homeapp/Constants/LocalEnums.dart';
import 'package:homeapp/Services/AppLocalization.dart';

class CustomLanguagePicker extends StatefulWidget {
  @override
  _CustomLanguagePickerState createState() => _CustomLanguagePickerState();
}

class _CustomLanguagePickerState extends State<CustomLanguagePicker> {
  Locales _locale;

  @override
  void initState() {
    super.initState();

    //TODO: from SharedPrefs
    _locale = Locales.England;
  }

  @override
  Widget build(BuildContext context) {
    return
      ListView(
        children: [
          ListTile(
            //TODO I18n
            title: Text('Language'),
            subtitle: DropdownButton<Locales>(items: [
              DropdownMenuItem(child: Text('English'), value: Locales.England,),
              DropdownMenuItem(child: Text('Hungarian'), value: Locales.Hungary)
            ],
            value: _locale,
            underline: Container(width: 0, height: 0,),
            onChanged: (val) => _changeLocale(val)),
            trailing: _getFlag(),
          ),
        ],
    );
  }

  Image _getFlag(){
    String assetPath;
    switch(_locale){
      case Locales.England:
        assetPath = 'assets/pcs/uk.png';
        break;
      case Locales.Hungary:
        assetPath = 'assets/pcs/hungary.png';
        break;
      default:
        assetPath = 'assets/pcs/uk.png';
    }

    return Image.asset(
            assetPath,
            scale: 4.5,
            );
  }

  void _changeLocale(Locales val){
    setState(() {
      this._locale = val;
    });

    if(val == Locales.England){
      AppLocalization.load(Locale('en','EN'));
    } else if(val == Locales.Hungary){
      AppLocalization.load(Locale('hu','HU'));
    } else {
      AppLocalization.load(Locale('en','EN'));
    }
  }
}