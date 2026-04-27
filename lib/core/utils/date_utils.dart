import 'package:intl/intl.dart';

/// 日期工具类
/// 时间戳、日期、时长格式化
class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _timestampFormat = DateFormat('MM/dd HH:mm:ss.SSS');
  static final DateFormat _timeFormat = DateFormat('HH:mm:ss');
  static final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');

  /// 格式化为时间戳 MM/dd HH:mm:ss.SSS
  static String formatTimestamp(DateTime dateTime) {
    return _timestampFormat.format(dateTime);
  }

  /// 格式化为时间 HH:mm:ss
  static String formatTime(DateTime dateTime) {
    return _timeFormat.format(dateTime);
  }

  /// 格式化为日期 yyyy/MM/dd
  static String formatDate(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  /// 格式化为中文时长 XX小时XX分钟XX秒
  static String formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}小时'
        '${minutes.toString().padLeft(2, '0')}分钟'
        '${seconds.toString().padLeft(2, '0')}秒';
  }
}