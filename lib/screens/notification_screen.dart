
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationService = NotificationService();
  Future<List<NotificationModel>>? _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  Future<List<NotificationModel>> _fetchNotifications() async {
    final response = await _notificationService.getNotifications();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final notifications = (data['notifications'] as List)
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();
      return notifications;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    final response = await _notificationService.markAsRead(notificationId);

    if (response.statusCode == 200) {
      setState(() {
        _notificationsFuture = _fetchNotifications();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to mark as read')),
      );
    }
  }

  Future<void> _markAllAsRead() async {
    final response = await _notificationService.markAllAsRead();

    if (response.statusCode == 200) {
      setState(() {
        _notificationsFuture = _fetchNotifications();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to mark all as read')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications'));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification.data['message'] ?? 'No message'),
                  subtitle: Text(notification.createdAt.toString()),
                  trailing: notification.readAt == null
                      ? IconButton(
                          icon: const Icon(Icons.mark_email_read),
                          onPressed: () => _markAsRead(notification.id),
                        )
                      : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}
