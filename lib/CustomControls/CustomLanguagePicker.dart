import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Constants/LocalEnums.dart';
import 'package:homeapp/Services/AppLocalization.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';

class CustomLanguagePicker extends StatefulWidget {
  @override
  _CustomLanguagePickerState createState() => _CustomLanguagePickerState();
}

class _CustomLanguagePickerState extends State<CustomLanguagePicker> {
  Locales _locale;

  @override
  void initState() {
    super.initState();
    _setLocale();
  }

  void _setLocale() async {
    var result = await BlocProvider.of<AuthenticationBloc>(context).getLocale();
    if(result != null){
      setState(() {
        _locale = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      ListView(
        children: [
          ListTile(
            //TODO I18n
            title: Text(AppLocalization.of(context).language),
            subtitle: DropdownButton<Locales>(items: [
              DropdownMenuItem(child: Text(AppLocalization.of(context).english), value: Locales.England,),
              DropdownMenuItem(child: Text(AppLocalization.of(context).hungary), value: Locales.Hungary)
            ],
            value: _locale,
            underline: Container(width: 0, height: 0,),
            onChanged: (val) => _changeLocale(val, context)),
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

  void _changeLocale(Locales val, BuildContext context){
    setState(() {
      this._locale = val;
    });

    BlocProvider.of<AuthenticationBloc>(context).saveLocale(val);
  }
}