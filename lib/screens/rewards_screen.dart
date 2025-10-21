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

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _handleTaskAction(UserTask task) {
    final adrevAuth = AdrevAuth.instance;
    // Example: if the task is to watch an ad, show a rewarded ad
    if (task.task.code.contains('watch')|| task.task.code.contains('daily')) {
      adrevAuth.showRewardedAd(onReward: () async {
        String value = "";
        if(task.task.code.contains("login")){
         value = "login";
        }else{
         value =  "watch_ad";
        }
        await adrevAuth.Logging(value,"0");
        // After reward, you might want to refresh the task list
        setState(() {
          _tasksFuture = AuthService.instance.mytask();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reward granted!')),
        );
      });
    } else{
      AdrevAuth.instance.startGame();
    }
    // TODO: Add logic for other task codes like 'play_game' or 'invite_friend'
  }

  var authservice = AuthService.instance;
  // Method to refresh the task list
  Future<void> _refreshTasks() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    setState(() {
      var enrolluser = authservice.enrolluser();
      _tasksFuture = authservice.mytask();
    });
    // Wait for the tasks to be refreshed
    await _tasksFuture;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4A148C); // Main purple from the design

    return Scaffold(
      backgroundColor: primaryColor,
      body: RefreshIndicator(
        onRefresh: _refreshTasks,
        color: primaryColor,
        backgroundColor: Colors.white,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensures the list is always scrollable
          slivers: [
            _buildHeader(),
            _buildBody(),
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
                    child: Text(username?.substring(0, 2)??'', style: TextStyle(color: Color(0xFF4A148C), fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username??'', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Level 12 Player', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(value: '7', label: 'Day streak'),
                  _StatCard(value: '18', label: 'Task Done'),
                  _StatCard(value: '5.2k', label: 'Total Earned'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildBody() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My task',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<UserTask>>(
                future: _tasksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                    return const Center(child: Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Text('No tasks available right now.', style: TextStyle(color: Colors.grey)),
                    ));
                  }
                  final tasks = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _TaskItem(task: tasks[index], onAction: () => _handleTaskAction(tasks[index]));
                    },
                  );
                },
              ),
            ],
          ),
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
        onPressed: AdrevAuth.instance.startGame, // Call the central startGame method
        child: const Text('Start game', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
    final double progress = isCompleted ? 1.0 : (task.progressCount / (task.task.targetCount == 0 ? 1 : task.task.targetCount));
    print(task.toJson());
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200)
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
                Text(task.task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('+${task.task.rewardAmount} Coins', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A148C)),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isCompleted ? 'Completed today' : '${task.progressCount}/${task.task.targetCount} completed',
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
