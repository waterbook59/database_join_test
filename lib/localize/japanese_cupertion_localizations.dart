import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class _CupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ja';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      JapaneseCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(_CupertinoLocalizationDelegate old) => false;

  @override
  String toString() => 'DefaultCupertinoLocalizations.delegate(ja_JP)';
}

class JapaneseCupertinoLocalizations implements CupertinoLocalizations {
  const JapaneseCupertinoLocalizations();

  static const List<String> _shortWeekdays = <String>[
    '(月)',
    '(火)',
    '(水)',
    '(木)',
    '(金)',
    '(土)',
    '(日)',
  ];

  static const List<String> _shortMonths = <String>[
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ];

  static const List<String> _months = <String>[
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ];

  ///ここで'年'を加える表示
  @override
//  String datePickerYear(int yearIndex) => yearIndex.toString();
  String datePickerYear(int yearIndex) => '${yearIndex.toString()}年';

  ///CupertinoLocalizationsのdatePickerMonth(1~12)なので、
  /// 例えば1が入ってきたら_monthsリストのの0番目(1月)を取ってくる
  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  ///ここで'日'を加える表示
  @override
//  String datePickerDayOfMonth(int dayIndex) => dayIndex.toString();
  String datePickerDayOfMonth(int dayIndex) => dayIndex.toString()+'日';

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => hour.toString() + "時";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1) return '1 分';
    return minute.toString() + '分';
  }

  ///ここでDateTime(2018,12,25)みたいに入ってきた数字を○月○日○曜日に変換
  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2) + '日'}'
        '${_shortWeekdays[date.weekday - DateTime.monday]} ';
  }

  ///年月日の順番いじるのには_CupetinoDatePickerDateStateのbuild内の
  /// localizations.datePickerDateOrderいじるのが良さそう(mdyじゃなくてymd)
  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.ymd;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => '午前';

  @override
  String get postMeridiemAbbreviation => '午後';

  @override
  String get alertDialogLabel => 'Info';

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? '時' : '時'; //参考の書式のまま

  @override
  String timerPickerMinuteLabel(int minute) => '分';

  @override
  String timerPickerSecondLabel(int second) => '秒';

  @override
  String get cutButtonLabel => 'カット';

  @override
  String get copyButtonLabel => 'コピー';

  @override
  String get pasteButtonLabel => 'ペースト';

  @override
  String get selectAllButtonLabel => '選択';

  @override
  String get todayLabel => '今日'; //参考サイトにはなかったが、参照しないとエラーが出るので独自で追加
  /// Creates an object that provides US English resource values for the
  /// cupertino library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  ///
  static Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(
        const JapaneseCupertinoLocalizations());
  }

  /// A [LocalizationsDelegate] that uses [DefaultCupertinoLocalizations.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
  _CupertinoLocalizationDelegate();

  @override
  // TODO: implement modalBarrierDismissLabel
  String get modalBarrierDismissLabel => throw UnimplementedError();

  @override
  String tabSemanticsLabel({int tabIndex, int tabCount}) {
    // TODO: implement tabSemanticsLabel
    throw UnimplementedError();
  }
}
