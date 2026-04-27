import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';

/// 消息类型
enum MessageType {
  success,
  warning,
  error,
  info,
}

/// 消息服务接口
abstract class MessageService {
  /// 发送系统推送通知
  Future<void> sendPushNotification(String title, String body);

  /// 发送应用内横幅
  Future<void> showInAppBanner(String message, MessageType type);

  /// 发送应用内弹窗
  Future<void> showInAppDialog(String title, String message);
}

/// 默认消息服务实现
class DefaultMessageService implements MessageService {
  final FlutterLocalNotificationsPlugin _pushPlugin =
      FlutterLocalNotificationsPlugin();

  DefaultMessageService() {
    _initPushNotifications();
  }

  Future<void> _initPushNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _pushPlugin.initialize(initSettings);
  }

  @override
  Future<void> sendPushNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _pushPlugin.show(0, title, body, details);
  }

  @override
  Future<void> showInAppBanner(String message, MessageType type) async {
    final color = _getColor(type);
    final icon = _getIcon(type);

    showOverlay((context, t) {
      return FadeTransition(
        opacity: AlwaysStoppedAnimation(t),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  color: color,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, duration: const Duration(seconds: 3));
  }

  @override
  Future<void> showInAppDialog(String title, String message) async {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Color _getColor(MessageType type) {
    switch (type) {
      case MessageType.success:
        return const Color(0xFF4CAF50);
      case MessageType.warning:
        return const Color(0xFFFF9800);
      case MessageType.error:
        return const Color(0xFFF44336);
      case MessageType.info:
        return const Color(0xFF2196F3);
    }
  }

  IconData _getIcon(MessageType type) {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.warning:
        return Icons.warning;
      case MessageType.error:
        return Icons.error;
      case MessageType.info:
        return Icons.info;
    }
  }
}

/// 全局 Navigator Key（用于 Overlay）
final navigatorKey = GlobalKey<NavigatorState>();
