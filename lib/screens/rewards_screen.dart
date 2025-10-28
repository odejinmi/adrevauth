import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../adrevauth.dart';
import '../models/user_task.dart';
import '../services/auth_service.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  Future<List<UserTask>>? _tasksFuture;
  String? username;
  Map<String, dynamic>? _dashboardFuture;

  final adrevAuth = AdrevAuth.instance;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _handleTaskAction(UserTask task) {
    if (task.task.code.contains('watch') || task.task.code.contains('daily')) {
      adrevAuth.showRewardedAd(
        onReward: () async {
          String value = task.task.code.contains("login")
              ? "login"
              : "watch_ad";
          if (task.task.code.contains('watch')) {
            await adrevAuth
                .watchadlogging(); // This method does not exist on AdrevAuth
          }

          if (task.task.code.contains('daily')) {
            await adrevAuth.dailylogging();
          }
          _refreshTasks(); // Refresh the list after reward
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Reward granted!')));
          }
        },
      );
    } else {
      adrevAuth.startGamelogging();
      adrevAuth.startGame();
    }
  }

  Future<void> _refreshTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final dashboardData = await AuthService.instance.dashboard();
    if (mounted) {
      setState(() {
        username = prefs.getString('username');
        _dashboardFuture = dashboardData;
        _tasksFuture = AuthService.instance.mytask();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4A148C);

    return Scaffold(
      backgroundColor: primaryColor,
      body: RefreshIndicator(
        onRefresh: _refreshTasks,
        color: primaryColor,
        backgroundColor: Colors.white,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildHeader(),
            FutureBuilder<List<UserTask>>(
              future: _tasksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return _buildLoadingBody();
                }
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return _buildEmptyBody();
                }
                return _buildPopulatedBody(snapshot.data!);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooterButton(),
    );
  }

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 230.0,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A0DAD), Color(0xFF4A148C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Text(
                      username?.substring(0, 2).toUpperCase() ?? '',
                      style: TextStyle(
                        color: Color(0xFF4A148C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username ?? 'Player',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Level 1 Player',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(
                    value:
                        _dashboardFuture?['daily_login_streak_days']
                            ?.toString() ??
                        '0',
                    label: 'Daily Streak',
                  ),
                  _StatCard(
                    value:
                        _dashboardFuture?['tasks_completed']?.toString() ?? '0',
                    label: 'Tasks Done',
                  ),
                  _StatCard(
                    value: _dashboardFuture?['games_played']?.toString() ?? '0',
                    label: 'Games Played',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyBody() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Task(s)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: Center(
                child: Text(
                  'No tasks available right now.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPopulatedBody(List<UserTask> tasks) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Task(s)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _TaskItem(
                  task: tasks[index],
                  onAction: () => _handleTaskAction(tasks[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A148C),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        onPressed: adrevAuth.startGame,
        child: const Text(
          'Start game',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 24,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final UserTask task;
  final VoidCallback onAction;
  const _TaskItem({required this.task, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = task.progressCount >= task.task.targetCount;
    final double progress = isCompleted
        ? 1.0
        : (task.progressCount /
              (task.task.targetCount == 0 ? 1 : task.task.targetCount));
    if (task.task.code.contains('reach_highscore')) {
      AdrevAuth.instance.highscore = task.task.targetCount;
    }

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://picsum.photos/seed/${task.task.id}/80',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '+${task.task.rewardAmount} Coins',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF4A148C),
                        ),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isCompleted
                      ? 'Completed today'
                      : '${task.progressCount}/${task.task.targetCount} completed',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    if (task.progressCount >= task.task.targetCount) {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[500],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Done'),
      );
    }

    String buttonText = 'Start';
    if (task.task.code.contains('play')) buttonText = 'Play';
    if (task.task.code.contains('invite')) buttonText = 'Share';
    if (task.task.code.contains('daily')) buttonText = 'Watch';
    if (task.task.code.contains('watch')) buttonText = 'Watch';

    return ElevatedButton(
      onPressed: onAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A148C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(buttonText),
    );
  }
}
