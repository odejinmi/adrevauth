import 'dart:convert';

/// A helper function to parse the top-level list of tasks from the API response.
List<UserTask> userTasksFromJson(String str) => List<UserTask>.from(json.decode(str)['data'].map((x) => UserTask.fromJson(x)));

/// Represents a user's progress on a specific task.
class UserTask {
    final int id;
    final int enrollmentId;
    final int taskId;
    final int progressCount;
    final DateTime? completedAt;
    final DateTime? periodStart;
    final DateTime? periodEnd;
    final DateTime createdAt;
    final DateTime updatedAt;
    final TaskDetails task;

    UserTask({
        required this.id,
        required this.enrollmentId,
        required this.taskId,
        required this.progressCount,
        this.completedAt,
        this.periodStart,
        this.periodEnd,
        required this.createdAt,
        required this.updatedAt,
        required this.task,
    });

    factory UserTask.fromJson(Map<String, dynamic> json) => UserTask(
        id: json["id"],
        enrollmentId: json["enrollment_id"],
        taskId: json["task_id"],
        progressCount: json["progress_count"],
        completedAt: json["completed_at"] == null ? null : DateTime.parse(json["completed_at"]),
        periodStart: json["period_start"] == null ? null : DateTime.parse(json["period_start"]),
        periodEnd: json["period_end"] == null ? null : DateTime.parse(json["period_end"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        task: TaskDetails.fromJson(json["task"]),
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "enrollment_id": enrollmentId,
      "task_id": taskId,
      "progress_count": progressCount,
      "completed_at": completedAt?.toIso8601String(),
      "period_start": periodStart?.toIso8601String(),
      "period_end": periodEnd?.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "task": task.toJson(),
    };
}

/// Represents the details of a specific task.
class TaskDetails {
    final int id;
    final int appId;
    final String title;
    final String code;
    final String period;
    final int targetCount;
    final dynamic thresholdValue;
    final String rewardAmount;
    final bool isActive;
    final dynamic meta;
    final DateTime createdAt;
    final DateTime updatedAt;

    TaskDetails({
        required this.id,
        required this.appId,
        required this.title,
        required this.code,
        required this.period,
        required this.targetCount,
        this.thresholdValue,
        required this.rewardAmount,
        required this.isActive,
        this.meta,
        required this.createdAt,
        required this.updatedAt,
    });

    factory TaskDetails.fromJson(Map<String, dynamic> json) => TaskDetails(
        id: json["id"],
        appId: json["app_id"],
        title: json["title"],
        code: json["code"],
        period: json["period"],
        targetCount: json["target_count"]??0,
        thresholdValue: json["threshold_value"],
        rewardAmount: json["reward_amount"],
        isActive: json["is_active"],
        meta: json["meta"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "app_id": appId,
      "title": title,
      "code": code,
      "period": period,
      "target_count": targetCount,
      "threshold_value": thresholdValue,
      "reward_amount": rewardAmount,
      "is_active": isActive,
      "meta": meta,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
}
